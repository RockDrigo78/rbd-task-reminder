import 'package:flutter_test/flutter_test.dart';
import 'package:task_reminder/models/todo.dart';
import 'package:task_reminder/utils/todo_sorting.dart';

void main() {
  test('active todos are sorted by today, tomorrow, then later reminders', () {
    final now = DateTime(2026, 6, 11, 12, 0);
    final todos = [
      Todo(
        id: 'later',
        title: 'Later task',
        reminderAt: DateTime(2026, 6, 20, 9, 0),
        createdAt: now,
        updatedAt: now,
      ),
      Todo(
        id: 'tomorrow',
        title: 'Tomorrow task',
        reminderAt: DateTime(2026, 6, 12, 9, 0),
        createdAt: now,
        updatedAt: now,
      ),
      Todo(
        id: 'today',
        title: 'Today task',
        reminderAt: DateTime(2026, 6, 11, 18, 0),
        createdAt: now,
        updatedAt: now,
      ),
      Todo(
        id: 'no-reminder',
        title: 'No reminder',
        createdAt: now,
        updatedAt: now,
      ),
    ];

    sortTodos(todos);

    expect(todos.map((todo) => todo.id).toList(), [
      'today',
      'tomorrow',
      'later',
      'no-reminder',
    ]);
  });

  test('groupActiveTodos splits tasks into today, tomorrow, and later sections', () {
    final now = DateTime(2026, 6, 11, 12, 0);
    final todos = [
      Todo(
        id: 'later',
        title: 'Later task',
        reminderAt: DateTime(2026, 6, 20, 9, 0),
        createdAt: now,
        updatedAt: now,
      ),
      Todo(
        id: 'tomorrow',
        title: 'Tomorrow task',
        reminderAt: DateTime(2026, 6, 12, 9, 0),
        createdAt: now,
        updatedAt: now,
      ),
      Todo(
        id: 'today',
        title: 'Today task',
        reminderAt: DateTime(2026, 6, 11, 18, 0),
        createdAt: now,
        updatedAt: now,
      ),
    ];

    final grouped = groupActiveTodos(todos);

    expect(grouped.today.map((todo) => todo.id), ['today']);
    expect(grouped.tomorrow.map((todo) => todo.id), ['tomorrow']);
    expect(grouped.later.map((todo) => todo.id), ['later']);
  });
}
