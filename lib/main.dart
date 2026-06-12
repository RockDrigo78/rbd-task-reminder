import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'l10n/l10n_helpers.dart';
import 'app.dart';
import 'providers/reminder_action_provider.dart';
import 'providers/service_providers.dart';
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

  try {
    await notificationService
        .init(
          onTap: (todoId) {
            container.read(reminderActionProvider.notifier).show(todoId);
          },
        )
        .timeout(const Duration(seconds: 10));

    await notificationService.requestPermissions();

    final settings = settingsRepository.getSettings();
    final notificationTitle = localizationsForLanguageCode(
      settings.languageCode,
    ).appTitle;
    await notificationService.rescheduleAllReminders(
      todoRepository.getAll(),
      notificationTitle: notificationTitle,
    );
  } catch (error, stackTrace) {
    debugPrint('Notification init failed: $error\n$stackTrace');
  }

  runApp(
    UncontrolledProviderScope(
      container: container,
      child: const TaskReminderApp(),
    ),
  );
}
