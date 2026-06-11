import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'l10n/app_localizations.dart';
import 'l10n/l10n_helpers.dart';
import 'providers/reminder_action_provider.dart';
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
  final Set<String> triggeredReminderIds = {};

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _startDueReminderChecks();
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
      _checkDueReminders();
    }
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

  void _checkDueReminders() {
    final now = DateTime.now();
    final todos = ref.read(todosProvider);
    final pendingTodoId = ref.read(reminderActionProvider);

    for (final todo in todos) {
      if (todo.isCompleted || todo.reminderAt == null) {
        continue;
      }

      if (!todo.reminderAt!.isAfter(now)) {
        if (triggeredReminderIds.contains(todo.id)) {
          continue;
        }
        if (pendingTodoId == todo.id) {
          continue;
        }

        triggeredReminderIds.add(todo.id);
        ref.read(reminderActionProvider.notifier).show(todo.id);
        break;
      }
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
      triggeredReminderIds.remove(todoId);
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
