import 'package:hive_flutter/hive_flutter.dart';

import '../models/todo.dart';
import '../utils/todo_sorting.dart';

const String todoBoxName = 'todos';

class TodoRepository {
  Box<Map>? _box;

  Future<void> init() async {
    _box = await Hive.openBox<Map>(todoBoxName);
  }

  List<Todo> getAll() {
    final box = _box;
    if (box == null) {
      return [];
    }

    final todos = <Todo>[];
    for (final value in box.values) {
      try {
        todos.add(Todo.fromMap(value));
      } catch (_) {
        continue;
      }
    }

    sortTodos(todos);
    return todos;
  }

  Todo? getById(String id) {
    final box = _box;
    if (box == null) {
      return null;
    }

    final value = box.get(id);
    if (value == null) {
      return null;
    }

    return Todo.fromMap(value);
  }

  Future<void> save(Todo todo) async {
    final box = _box;
    if (box == null) {
      throw StateError('TodoRepository is not initialized');
    }

    await box.put(todo.id, todo.toMap());
  }

  Future<void> delete(String id) async {
    await _box?.delete(id);
  }
}
