import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../models/todo.dart';
import '../repositories/todo_repository.dart';
import '../services/reminder_scheduler.dart';
import 'service_providers.dart';

final todoRepositoryProvider = Provider<TodoRepository>((ref) {
  throw UnimplementedError('TodoRepository must be overridden');
});

final todosProvider =
    StateNotifierProvider<TodoNotifier, List<Todo>>((ref) {
  final repository = ref.watch(todoRepositoryProvider);
  final scheduler = ref.watch(reminderSchedulerProvider);
  return TodoNotifier(repository, scheduler);
});

class TodoNotifier extends StateNotifier<List<Todo>> {
  TodoNotifier(this._repository, this._scheduler) : super([]) {
    loadTodos();
  }

  final TodoRepository _repository;
  final ReminderScheduler _scheduler;

  void loadTodos() {
    try {
      state = _repository.getAll();
    } catch (error, stackTrace) {
      debugPrint('Failed to load todos: $error\n$stackTrace');
      state = [];
    }
  }

  Future<void> rescheduleAllReminders() async {
    await _scheduler.rescheduleAll(state);
  }

  Todo? getById(String id) {
    return _repository.getById(id);
  }

  Future<bool> addTodo({
    required String title,
    String notes = '',
    DateTime? reminderAt,
  }) async {
    final now = DateTime.now();
    final todo = Todo(
      id: const Uuid().v4(),
      title: title.trim(),
      notes: notes.trim(),
      reminderAt: reminderAt,
      createdAt: now,
      updatedAt: now,
    );

    await _repository.save(todo);
    loadTodos();

    if (reminderAt == null) {
      return true;
    }

    return _scheduleReminderSafely(todo);
  }

  Future<bool> updateTodo(Todo todo) async {
    final updatedTodo = todo.copyWith(updatedAt: DateTime.now());
    await _repository.save(updatedTodo);
    loadTodos();

    if (updatedTodo.reminderAt == null || updatedTodo.isCompleted) {
      await _cancelReminderSafely(updatedTodo.id);
      return true;
    }

    return _scheduleReminderSafely(updatedTodo);
  }

  Future<bool> _scheduleReminderSafely(Todo todo) async {
    try {
      final scheduled = await _scheduler.schedule(todo);
      if (!scheduled) {
        debugPrint('Reminder was not scheduled for todo ${todo.id}');
      }
      return scheduled;
    } catch (error, stackTrace) {
      debugPrint('Failed to schedule reminder: $error\n$stackTrace');
      return false;
    }
  }

  Future<void> _cancelReminderSafely(String todoId) async {
    try {
      await _scheduler.cancel(todoId);
    } catch (error, stackTrace) {
      debugPrint('Failed to cancel reminder: $error\n$stackTrace');
    }
  }

  Future<void> toggleComplete(String id) async {
    final todo = _repository.getById(id);
    if (todo == null) {
      return;
    }

    final updatedTodo = todo.copyWith(
      isCompleted: !todo.isCompleted,
      updatedAt: DateTime.now(),
    );

    await _repository.save(updatedTodo);
    loadTodos();
    if (updatedTodo.isCompleted) {
      await _cancelReminderSafely(id);
    } else {
      await _scheduleReminderSafely(updatedTodo);
    }
  }

  Future<void> deleteTodo(String id) async {
    await _cancelReminderSafely(id);
    await _repository.delete(id);
    loadTodos();
  }

  Future<void> markComplete(String id) async {
    final todo = _repository.getById(id);
    if (todo == null || todo.isCompleted) {
      return;
    }

    final updatedTodo = todo.copyWith(
      isCompleted: true,
      updatedAt: DateTime.now(),
    );

    await _repository.save(updatedTodo);
    loadTodos();
    await _cancelReminderSafely(id);
  }

  Future<void> postponeReminder(String id, DateTime newReminderAt) async {
    final todo = _repository.getById(id);
    if (todo == null) {
      return;
    }

    final updatedTodo = todo.copyWith(
      reminderAt: newReminderAt,
      updatedAt: DateTime.now(),
    );

    await _repository.save(updatedTodo);
    loadTodos();
    await _scheduleReminderSafely(updatedTodo);
  }
}
