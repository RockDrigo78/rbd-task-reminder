import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../l10n/l10n_helpers.dart';
import '../repositories/settings_repository.dart';
import '../repositories/todo_repository.dart';
import '../services/notification_service.dart';
import '../services/reminder_scheduler.dart';
import 'settings_provider.dart';
import 'todo_provider.dart';

final notificationServiceProvider = Provider<NotificationService>((ref) {
  throw UnimplementedError('NotificationService must be overridden');
});

final reminderSchedulerProvider = Provider<ReminderScheduler>((ref) {
  final notificationService = ref.watch(notificationServiceProvider);
  return ReminderScheduler(
    notificationService,
    () => localizationsForLanguageCode(
      ref.read(settingsProvider).languageCode,
    ).appTitle,
  );
});

typedef AppOverrides = List<Override>;

AppOverrides createAppOverrides({
  required TodoRepository todoRepository,
  required SettingsRepository settingsRepository,
  required NotificationService notificationService,
}) {
  return [
    todoRepositoryProvider.overrideWithValue(todoRepository),
    settingsRepositoryProvider.overrideWithValue(settingsRepository),
    notificationServiceProvider.overrideWithValue(notificationService),
  ];
}
