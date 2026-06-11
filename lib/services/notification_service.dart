import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as timezone_data;
import 'package:timezone/timezone.dart' as timezone;

import '../models/todo.dart';

typedef NotificationTapHandler = void Function(String todoId);

class NotificationService {
  NotificationService();

  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  NotificationTapHandler? onNotificationTap;

  static const String channelId = 'task_reminder_channel';
  static const String channelName = 'Task reminders';
  static const String channelDescription = 'Notifications for task reminders';

  Future<void> init({required NotificationTapHandler onTap}) async {
    onNotificationTap = onTap;
    timezone_data.initializeTimeZones();

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
    await androidPlugin?.requestExactAlarmsPermission();

    final iosPlugin = _plugin.resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin>();
    await iosPlugin?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
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

    final scheduledDate = timezone.TZDateTime.from(reminderAt, timezone.local);
    final notificationId = _notificationIdForTodo(todo.id);

    const androidDetails = AndroidNotificationDetails(
      channelId,
      channelName,
      channelDescription: channelDescription,
      importance: Importance.high,
      priority: Priority.high,
    );

    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _plugin.zonedSchedule(
      notificationId,
      notificationTitle,
      todo.title,
      scheduledDate,
      details,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      payload: todo.id,
    );
  }

  Future<void> cancelReminder(String todoId) async {
    await _plugin.cancel(_notificationIdForTodo(todoId));
  }

  int _notificationIdForTodo(String todoId) {
    return todoId.hashCode.abs() % 2147483647;
  }

  Future<void> _createAndroidChannel() async {
    const channel = AndroidNotificationChannel(
      channelId,
      channelName,
      description: channelDescription,
      importance: Importance.high,
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
