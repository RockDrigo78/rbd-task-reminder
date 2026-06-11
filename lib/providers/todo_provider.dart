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
    state = _repository.getAll();
  }

  Future<void> rescheduleAllReminders() async {
    await _scheduler.rescheduleAll(
      state.where((todo) => !todo.isCompleted).toList(),
    );
  }

  Todo? getById(String id) {
    return _repository.getById(id);
  }

  Future<void> addTodo({
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
    await _scheduler.schedule(todo);
    loadTodos();
  }

  Future<void> updateTodo(Todo todo) async {
    final updatedTodo = todo.copyWith(updatedAt: DateTime.now());
    await _repository.save(updatedTodo);
    await _scheduler.schedule(updatedTodo);
    loadTodos();
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
    if (updatedTodo.isCompleted) {
      await _scheduler.cancel(id);
    } else {
      await _scheduler.schedule(updatedTodo);
    }
    loadTodos();
  }

  Future<void> deleteTodo(String id) async {
    await _scheduler.cancel(id);
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
    await _scheduler.cancel(id);
    loadTodos();
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
    await _scheduler.schedule(updatedTodo);
    loadTodos();
  }
}
