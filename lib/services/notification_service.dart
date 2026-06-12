import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/data/latest.dart' as timezone_data;
import 'package:timezone/timezone.dart' as timezone;

import '../models/reminder_permission_status.dart';
import '../models/todo.dart';

typedef NotificationTapHandler = void Function(String todoId);

class NotificationService {
  NotificationService();

  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  NotificationTapHandler? onNotificationTap;

  static const String channelId = 'task_reminder_channel_v3';
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

  Future<ReminderPermissionStatus> getReminderPermissionStatus() async {
    return ReminderPermissionStatus(
      notificationsEnabled: await areNotificationsEnabled(),
      exactAlarmsEnabled: await canScheduleExactAlarms(),
      batteryOptimizationDisabled: await isBatteryOptimizationDisabled(),
    );
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

  Future<void> openAppSettingsPage() async {
    await openAppSettings();
  }

  Future<void> requestBatteryOptimizationExemption() async {
    if (!Platform.isAndroid) {
      return;
    }

    await Permission.ignoreBatteryOptimizations.request();
  }

  Future<bool> isBatteryOptimizationDisabled() async {
    if (!Platform.isAndroid) {
      return true;
    }

    final status = await Permission.ignoreBatteryOptimizations.status;
    return status.isGranted;
  }

  Future<void> prepareReliableScheduling() async {
    await requestPermissions();
    if (!await canScheduleExactAlarms()) {
      await openExactAlarmSettings();
    }
    if (!await isBatteryOptimizationDisabled()) {
      await requestBatteryOptimizationExemption();
    }
  }

  Future<bool> canScheduleExactAlarms() async {
    if (!Platform.isAndroid) {
      return true;
    }

    final androidPlugin = _plugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    return await androidPlugin?.canScheduleExactNotifications() ?? false;
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

  Future<bool> scheduleReminder(
    Todo todo, {
    required String notificationTitle,
  }) async {
    final reminderAt = todo.reminderAt;
    if (reminderAt == null || todo.isCompleted) {
      return true;
    }

    if (!reminderAt.isAfter(DateTime.now())) {
      return false;
    }

    await _configureLocalTimeZone();

    final scheduledDate = _localReminderTime(reminderAt);
    final notificationId = _notificationIdForTodo(todo.id);
    final details = _reminderNotificationDetails();

    return _scheduleReminderAt(
      notificationId: notificationId,
      notificationTitle: notificationTitle,
      body: todo.title,
      scheduledDate: scheduledDate,
      details: details,
      payload: todo.id,
    );
  }

  Future<void> rescheduleAllReminders(
    List<Todo> todos, {
    required String notificationTitle,
  }) async {
    for (final todo in todos) {
      if (todo.isCompleted || todo.reminderAt == null) {
        continue;
      }

      if (!todo.reminderAt!.isAfter(DateTime.now())) {
        continue;
      }

      try {
        await cancelReminder(todo.id);
        final scheduled = await scheduleReminder(
          todo,
          notificationTitle: notificationTitle,
        );
        if (!scheduled) {
          debugPrint('Failed to reschedule reminder for todo ${todo.id}');
        }
      } catch (error, stackTrace) {
        debugPrint(
          'Failed to reschedule reminder for ${todo.id}: $error\n$stackTrace',
        );
      }
    }
  }

  timezone.TZDateTime _localReminderTime(DateTime reminderAt) {
    final localReminderAt = reminderAt.isUtc ? reminderAt.toLocal() : reminderAt;

    return timezone.TZDateTime(
      timezone.local,
      localReminderAt.year,
      localReminderAt.month,
      localReminderAt.day,
      localReminderAt.hour,
      localReminderAt.minute,
      localReminderAt.second,
    );
  }

  NotificationDetails _reminderNotificationDetails() {
    const androidDetails = AndroidNotificationDetails(
      channelId,
      channelName,
      channelDescription: channelDescription,
      importance: Importance.max,
      priority: Priority.high,
      category: AndroidNotificationCategory.alarm,
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

  Future<bool> _scheduleReminderAt({
    required int notificationId,
    required String notificationTitle,
    required String body,
    required timezone.TZDateTime scheduledDate,
    required NotificationDetails details,
    required String payload,
  }) async {
    if (Platform.isAndroid) {
      return _scheduleAndroidReminder(
        notificationId: notificationId,
        notificationTitle: notificationTitle,
        body: body,
        scheduledDate: scheduledDate,
        details: details,
        payload: payload,
      );
    }

    return _scheduleIosReminder(
      notificationId: notificationId,
      notificationTitle: notificationTitle,
      body: body,
      scheduledDate: scheduledDate,
      details: details,
      payload: payload,
    );
  }

  Future<bool> _scheduleAndroidReminder({
    required int notificationId,
    required String notificationTitle,
    required String body,
    required timezone.TZDateTime scheduledDate,
    required NotificationDetails details,
    required String payload,
  }) async {
    // Community fix for Android 14+/Pixel: alarmClock works when setExact is
    // ignored. See flutter_local_notifications issue #2185.
    const scheduleModes = <AndroidScheduleMode>[
      AndroidScheduleMode.alarmClock,
      AndroidScheduleMode.exactAllowWhileIdle,
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
          payload: payload,
        );
        debugPrint(
          'Scheduled reminder $notificationId at $scheduledDate '
          '(now=${timezone.TZDateTime.now(timezone.local)}) using $scheduleMode',
        );
        return true;
      } on PlatformException catch (error) {
        lastError = error;
        debugPrint(
          'Reminder scheduling failed with $scheduleMode: ${error.code}',
        );
      }
    }

    if (lastError != null) {
      debugPrint('All Android scheduling modes failed: ${lastError.code}');
    }
    return false;
  }

  Future<bool> _scheduleIosReminder({
    required int notificationId,
    required String notificationTitle,
    required String body,
    required timezone.TZDateTime scheduledDate,
    required NotificationDetails details,
    required String payload,
  }) async {
    try {
      await _plugin.zonedSchedule(
        notificationId,
        notificationTitle,
        body,
        scheduledDate,
        details,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        payload: payload,
      );
      debugPrint('Scheduled iOS reminder $notificationId at $scheduledDate');
      return true;
    } on PlatformException catch (error) {
      debugPrint('iOS reminder scheduling failed: ${error.code}');
      return false;
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
      debugPrint('Timezone configured: ${timeZoneInfo.identifier}');
      return;
    } catch (error, stackTrace) {
      debugPrint('Device timezone lookup failed: $error\n$stackTrace');
    }

    _setLocalTimeZoneFromDeviceOffset();
  }

  void _setLocalTimeZoneFromDeviceOffset() {
    try {
      final offset = DateTime.now().timeZoneOffset;
      final totalMinutes = offset.inMinutes;
      final hours = totalMinutes ~/ 60;
      final minutes = totalMinutes.abs() % 60;

      if (minutes == 0) {
        final locationName =
            'Etc/GMT${hours >= 0 ? '-' : '+'}${hours.abs()}';
        timezone.setLocalLocation(timezone.getLocation(locationName));
        debugPrint('Timezone fallback configured: $locationName');
        return;
      }

      timezone.setLocalLocation(timezone.UTC);
      debugPrint('Timezone fallback configured: UTC');
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
