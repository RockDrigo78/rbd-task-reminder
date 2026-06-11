import '../models/todo.dart';

abstract final class TodoSortGroup {
  static const int today = 0;
  static const int tomorrow = 1;
  static const int later = 2;
  static const int noReminder = 3;
}

class GroupedActiveTodos {
  const GroupedActiveTodos({
    required this.today,
    required this.tomorrow,
    required this.later,
    required this.withoutReminder,
  });

  final List<Todo> today;
  final List<Todo> tomorrow;
  final List<Todo> later;
  final List<Todo> withoutReminder;

  bool get isEmpty =>
      today.isEmpty &&
      tomorrow.isEmpty &&
      later.isEmpty &&
      withoutReminder.isEmpty;
}

int reminderDaySortGroup(Todo todo) {
  final reminderAt = todo.reminderAt;
  if (reminderAt == null) {
    return TodoSortGroup.noReminder;
  }

  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final reminderDay = DateTime(
    reminderAt.year,
    reminderAt.month,
    reminderAt.day,
  );

  if (!reminderDay.isAfter(today)) {
    return TodoSortGroup.today;
  }

  if (reminderDay.difference(today).inDays == 1) {
    return TodoSortGroup.tomorrow;
  }

  return TodoSortGroup.later;
}

GroupedActiveTodos groupActiveTodos(List<Todo> todos) {
  final activeTodos = todos.where((todo) => !todo.isCompleted).toList();
  sortTodos(activeTodos);

  final today = <Todo>[];
  final tomorrow = <Todo>[];
  final later = <Todo>[];
  final withoutReminder = <Todo>[];

  for (final todo in activeTodos) {
    final group = reminderDaySortGroup(todo);
    if (group == TodoSortGroup.today) {
      today.add(todo);
    } else if (group == TodoSortGroup.tomorrow) {
      tomorrow.add(todo);
    } else if (group == TodoSortGroup.later) {
      later.add(todo);
    } else {
      withoutReminder.add(todo);
    }
  }

  return GroupedActiveTodos(
    today: today,
    tomorrow: tomorrow,
    later: later,
    withoutReminder: withoutReminder,
  );
}

void sortTodos(List<Todo> todos) {
  todos.sort((first, second) {
    if (first.isCompleted != second.isCompleted) {
      return first.isCompleted ? 1 : -1;
    }

    if (first.isCompleted) {
      return second.updatedAt.compareTo(first.updatedAt);
    }

    final groupCompare =
        reminderDaySortGroup(first).compareTo(reminderDaySortGroup(second));
    if (groupCompare != 0) {
      return groupCompare;
    }

    if (first.reminderAt != null && second.reminderAt != null) {
      return first.reminderAt!.compareTo(second.reminderAt!);
    }

    if (first.reminderAt != null) {
      return -1;
    }

    if (second.reminderAt != null) {
      return 1;
    }

    return second.updatedAt.compareTo(first.updatedAt);
  });
}
