import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'app.dart';
import 'providers/reminder_action_provider.dart';
import 'providers/service_providers.dart';
import 'providers/todo_provider.dart';
import 'repositories/settings_repository.dart';
import 'repositories/todo_repository.dart';
import 'services/notification_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  final todoRepository = TodoRepository();
  final settingsRepository = SettingsRepository();
  final notificationService = NotificationService();

  await todoRepository.init();
  await settingsRepository.init();

  final container = ProviderContainer(
    overrides: createAppOverrides(
      todoRepository: todoRepository,
      settingsRepository: settingsRepository,
      notificationService: notificationService,
    ),
  );

  await notificationService.init(
    onTap: (todoId) {
      container.read(reminderActionProvider.notifier).show(todoId);
    },
  );

  final launchDetails =
      await notificationService.getLaunchNotificationTodoId();
  if (launchDetails != null) {
    container.read(reminderActionProvider.notifier).show(launchDetails);
  }

  await container.read(todosProvider.notifier).rescheduleAllReminders();

  runApp(
    UncontrolledProviderScope(
      container: container,
      child: const TaskReminderApp(),
    ),
  );
}
