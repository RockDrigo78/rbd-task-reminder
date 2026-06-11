import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest.dart' as timezone_data;
import 'package:timezone/timezone.dart' as timezone;

import '../models/todo.dart';

typedef NotificationTapHandler = void Function(String todoId);

class NotificationService {
  NotificationService();

  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  NotificationTapHandler? onNotificationTap;

  static const String channelId = 'task_reminder_channel_v2';
  static const String channelName = 'Task reminders';
  static const String channelDescription = 'Notifications for task reminders';

  Future<void> init({required NotificationTapHandler onTap}) async {
    onNotificationTap = onTap;
    await _configureLocalTimeZone();

    const androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    const settings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _plugin.initialize(
      settings,
      onDidReceiveNotificationResponse: _handleNotificationResponse,
      onDidReceiveBackgroundNotificationResponse:
          _backgroundNotificationTapHandler,
    );

    await _createAndroidChannel();
  }

  Future<String?> getLaunchNotificationTodoId() async {
    final launchDetails = await _plugin.getNotificationAppLaunchDetails();
    if (launchDetails?.didNotificationLaunchApp != true) {
      return null;
    }

    return launchDetails?.notificationResponse?.payload;
  }

  Future<void> requestPermissions() async {
    final androidPlugin = _plugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    await androidPlugin?.requestNotificationsPermission();

    final iosPlugin = _plugin.resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin>();
    await iosPlugin?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  Future<void> openExactAlarmSettings() async {
    final androidPlugin = _plugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    await androidPlugin?.requestExactAlarmsPermission();
  }

  Future<bool> canScheduleExactAlarms() async {
    final androidPlugin = _plugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    return await androidPlugin?.canScheduleExactNotifications() ?? true;
  }

  Future<bool> areNotificationsEnabled() async {
    final androidPlugin = _plugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    return await androidPlugin?.areNotificationsEnabled() ?? true;
  }

  Future<void> showReminderNow(
    Todo todo, {
    required String notificationTitle,
  }) async {
    if (todo.isCompleted) {
      return;
    }

    final notificationId = _notificationIdForTodo(todo.id);
    await _plugin.show(
      notificationId,
      notificationTitle,
      todo.title,
      _reminderNotificationDetails(),
      payload: todo.id,
    );
  }

  Future<void> scheduleReminder(
    Todo todo, {
    required String notificationTitle,
  }) async {
    final reminderAt = todo.reminderAt;
    if (reminderAt == null || todo.isCompleted) {
      return;
    }

    if (!reminderAt.isAfter(DateTime.now())) {
      return;
    }

    final scheduledDate = timezone.TZDateTime(
      timezone.local,
      reminderAt.year,
      reminderAt.month,
      reminderAt.day,
      reminderAt.hour,
      reminderAt.minute,
      reminderAt.second,
    );
    final notificationId = _notificationIdForTodo(todo.id);
    final details = _reminderNotificationDetails();

    await _scheduleReminderAt(
      notificationId: notificationId,
      notificationTitle: notificationTitle,
      body: todo.title,
      scheduledDate: scheduledDate,
      details: details,
      payload: todo.id,
    );
  }

  NotificationDetails _reminderNotificationDetails() {
    const androidDetails = AndroidNotificationDetails(
      channelId,
      channelName,
      channelDescription: channelDescription,
      importance: Importance.max,
      priority: Priority.high,
      category: AndroidNotificationCategory.reminder,
      visibility: NotificationVisibility.public,
      playSound: true,
      enableVibration: true,
      ticker: 'Task reminder',
    );

    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
      interruptionLevel: InterruptionLevel.timeSensitive,
    );

    return const NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );
  }

  Future<void> _scheduleReminderAt({
    required int notificationId,
    required String notificationTitle,
    required String body,
    required timezone.TZDateTime scheduledDate,
    required NotificationDetails details,
    required String payload,
  }) async {
    final canUseExactAlarms = await canScheduleExactAlarms();
    final scheduleModes = canUseExactAlarms
        ? <AndroidScheduleMode>[
            AndroidScheduleMode.exactAllowWhileIdle,
            AndroidScheduleMode.inexactAllowWhileIdle,
          ]
        : <AndroidScheduleMode>[
            AndroidScheduleMode.inexactAllowWhileIdle,
          ];

    PlatformException? lastError;

    for (final scheduleMode in scheduleModes) {
      try {
        await _plugin.zonedSchedule(
          notificationId,
          notificationTitle,
          body,
          scheduledDate,
          details,
          androidScheduleMode: scheduleMode,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime,
          payload: payload,
        );
        return;
      } on PlatformException catch (error) {
        lastError = error;
        debugPrint(
          'Reminder scheduling failed with $scheduleMode: ${error.code}',
        );
      }
    }

    if (lastError != null) {
      throw lastError;
    }
  }

  Future<void> cancelReminder(String todoId) async {
    await _plugin.cancel(_notificationIdForTodo(todoId));
  }

  int _notificationIdForTodo(String todoId) {
    return todoId.hashCode.abs() % 2147483647;
  }

  Future<void> _configureLocalTimeZone() async {
    timezone_data.initializeTimeZones();

    try {
      final timeZoneInfo = await FlutterTimezone.getLocalTimezone().timeout(
        const Duration(seconds: 5),
      );
      timezone.setLocalLocation(
        timezone.getLocation(timeZoneInfo.identifier),
      );
      return;
    } catch (error, stackTrace) {
      debugPrint('Device timezone lookup failed: $error\n$stackTrace');
    }

    _setLocalTimeZoneFromDeviceOffset();
  }

  void _setLocalTimeZoneFromDeviceOffset() {
    try {
      final offset = DateTime.now().timeZoneOffset;
      final hours = offset.inHours;
      final locationName =
          'Etc/GMT${hours >= 0 ? '-' : '+'}${hours.abs()}';
      timezone.setLocalLocation(timezone.getLocation(locationName));
    } catch (error, stackTrace) {
      debugPrint('Timezone offset fallback failed: $error\n$stackTrace');
    }
  }

  Future<void> _createAndroidChannel() async {
    const channel = AndroidNotificationChannel(
      channelId,
      channelName,
      description: channelDescription,
      importance: Importance.max,
      playSound: true,
      enableVibration: true,
    );

    final androidPlugin = _plugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    await androidPlugin?.createNotificationChannel(channel);
  }

  void _handleNotificationResponse(NotificationResponse response) {
    final payload = response.payload;
    if (payload == null || payload.isEmpty) {
      return;
    }

    onNotificationTap?.call(payload);
  }

  @pragma('vm:entry-point')
  static void _backgroundNotificationTapHandler(
    NotificationResponse response,
  ) {
    // Tap handling is wired through onDidReceiveNotificationResponse on resume.
  }
}
