import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'l10n/app_localizations.dart';
import 'l10n/l10n_helpers.dart';
import 'models/todo.dart';
import 'providers/reminder_action_provider.dart';
import 'providers/service_providers.dart';
import 'providers/settings_provider.dart';
import 'providers/todo_provider.dart';
import 'screens/home_screen.dart';
import 'theme/app_theme.dart';
import 'widgets/reminder_action_bottom_sheet.dart';

final navigatorKey = GlobalKey<NavigatorState>();

class TaskReminderApp extends ConsumerStatefulWidget {
  const TaskReminderApp({super.key});

  @override
  ConsumerState<TaskReminderApp> createState() => _TaskReminderAppState();
}

class _TaskReminderAppState extends ConsumerState<TaskReminderApp>
    with WidgetsBindingObserver {
  Timer? dueReminderTimer;
  final Set<String> triggeredReminderKeys = {};

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _startDueReminderChecks();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      unawaited(_bootstrapNotifications());
    });
  }

  Future<void> _bootstrapNotifications() async {
    try {
      final notificationService = ref.read(notificationServiceProvider);
      await notificationService.prepareReliableScheduling();
      await ref.read(todosProvider.notifier).rescheduleAllReminders();

      final launchTodoId =
          await notificationService.getLaunchNotificationTodoId();
      if (launchTodoId != null) {
        ref.read(reminderActionProvider.notifier).show(launchTodoId);
      }

      _checkDueReminders();
    } catch (error, stackTrace) {
      debugPrint('Notification bootstrap failed: $error\n$stackTrace');
    }
  }

  @override
  void dispose() {
    dueReminderTimer?.cancel();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      unawaited(_onAppResumed());
    }
  }

  Future<void> _onAppResumed() async {
    try {
      await ref.read(todosProvider.notifier).rescheduleAllReminders();
    } catch (error, stackTrace) {
      debugPrint('Failed to reschedule reminders on resume: $error\n$stackTrace');
    }
    _checkDueReminders();
  }

  void _startDueReminderChecks() {
    dueReminderTimer = Timer.periodic(
      const Duration(seconds: 15),
      (_) => _checkDueReminders(),
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkDueReminders();
    });
  }

  String _reminderTriggerKey(Todo todo) {
    return '${todo.id}:${todo.reminderAt?.millisecondsSinceEpoch ?? 0}';
  }

  void _checkDueReminders() {
    if (WidgetsBinding.instance.lifecycleState != AppLifecycleState.resumed) {
      return;
    }

    final now = DateTime.now();
    final todos = ref.read(todosProvider);

    for (final todo in todos) {
      if (todo.isCompleted || todo.reminderAt == null) {
        continue;
      }

      if (!todo.reminderAt!.isAfter(now)) {
        final triggerKey = _reminderTriggerKey(todo);
        if (triggeredReminderKeys.contains(triggerKey)) {
          continue;
        }

        triggeredReminderKeys.add(triggerKey);
        unawaited(_showDueReminderNotification(todo));
      }
    }
  }

  Future<void> _showDueReminderNotification(Todo todo) async {
    try {
      final notificationTitle = localizationsForLanguageCode(
        ref.read(settingsProvider).languageCode,
      ).appTitle;
      await ref.read(notificationServiceProvider).showReminderNow(
            todo,
            notificationTitle: notificationTitle,
          );
    } catch (error, stackTrace) {
      debugPrint(
        'Failed to show due reminder notification: $error\n$stackTrace',
      );
    }
  }

  void _showReminderSheetIfNeeded(String? todoId) {
    if (todoId == null) {
      return;
    }

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final context = navigatorKey.currentContext;
      if (context == null || !context.mounted) {
        return;
      }

      await showReminderActionBottomSheet(
        context: context,
        ref: ref,
        todoId: todoId,
      );
      triggeredReminderKeys.removeWhere(
        (key) => key.startsWith('$todoId:'),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<String?>(reminderActionProvider, (previous, next) {
      if (next != null && next != previous) {
        _showReminderSheetIfNeeded(next);
      }
    });

    final settings = ref.watch(settingsProvider);
    final locale = settings.languageCode == null
        ? null
        : Locale(settings.languageCode!);
    final localizations = lookupAppLocalizations(
      resolveAppLocale(settings.languageCode),
    );

    return MaterialApp(
      navigatorKey: navigatorKey,
      onGenerateTitle: (_) => localizations.appTitle,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: settings.themePreference.themeMode,
      locale: locale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      home: const HomeScreen(),
    );
  }
}
