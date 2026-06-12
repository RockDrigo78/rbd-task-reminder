import '../models/todo.dart';
import 'notification_service.dart';

class ReminderScheduler {
  ReminderScheduler(this._notificationService, this._notificationTitle);

  final NotificationService _notificationService;
  final String Function() _notificationTitle;

  Future<bool> schedule(Todo todo) async {
    await _notificationService.cancelReminder(todo.id);

    if (todo.reminderAt != null && !todo.isCompleted) {
      return _notificationService.scheduleReminder(
        todo,
        notificationTitle: _notificationTitle(),
      );
    }

    return true;
  }

  Future<void> cancel(String todoId) async {
    await _notificationService.cancelReminder(todoId);
  }

  Future<void> rescheduleAll(List<Todo> todos) async {
    await _notificationService.rescheduleAllReminders(
      todos,
      notificationTitle: _notificationTitle(),
    );
  }
}
