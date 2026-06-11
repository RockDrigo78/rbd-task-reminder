import 'package:flutter/foundation.dart';
import '../models/todo.dart';
import 'notification_service.dart';

class ReminderScheduler {
  ReminderScheduler(this._notificationService, this._notificationTitle);

  final NotificationService _notificationService;
  final String Function() _notificationTitle;

  Future<void> schedule(Todo todo) async {
    await _notificationService.cancelReminder(todo.id);

    if (todo.reminderAt != null && !todo.isCompleted) {
      await _notificationService.scheduleReminder(
        todo,
        notificationTitle: _notificationTitle(),
      );
    }
  }

  Future<void> cancel(String todoId) async {
    await _notificationService.cancelReminder(todoId);
  }

  Future<void> rescheduleAll(List<Todo> todos) async {
    for (final todo in todos) {
      try {
        await schedule(todo);
      } catch (error, stackTrace) {
        debugPrint(
          'Failed to reschedule reminder for ${todo.id}: $error\n$stackTrace',
        );
      }
    }
  }
}
