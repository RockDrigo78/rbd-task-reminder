import 'package:hive_flutter/hive_flutter.dart';

import '../models/todo.dart';

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

    return box.values
        .map((value) => Todo.fromMap(value))
        .toList()
      ..sort((first, second) {
        if (first.isCompleted != second.isCompleted) {
          return first.isCompleted ? 1 : -1;
        }
        return second.updatedAt.compareTo(first.updatedAt);
      });
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
    await _box?.put(todo.id, todo.toMap());
  }

  Future<void> delete(String id) async {
    await _box?.delete(id);
  }
}
