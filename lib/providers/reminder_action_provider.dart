import 'package:flutter_riverpod/flutter_riverpod.dart';

final reminderActionProvider =
    StateNotifierProvider<ReminderActionNotifier, String?>((ref) {
  return ReminderActionNotifier();
});

class ReminderActionNotifier extends StateNotifier<String?> {
  ReminderActionNotifier() : super(null);

  void show(String todoId) {
    if (state == todoId) {
      return;
    }
    state = todoId;
  }

  void clear() {
    state = null;
  }
}
