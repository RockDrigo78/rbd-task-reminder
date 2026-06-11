import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../l10n/app_localizations.dart';
import '../l10n/l10n_helpers.dart';
import '../models/todo.dart';
import '../providers/reminder_action_provider.dart';
import '../providers/settings_provider.dart';
import '../providers/todo_provider.dart';
import '../theme/app_colors.dart';
import '../utils/time_picker_helpers.dart';
import '../widgets/gradient_fab.dart';

Future<void> showReminderActionBottomSheet({
  required BuildContext context,
  required WidgetRef ref,
  required String todoId,
}) async {
  final todo = ref.read(todosProvider.notifier).getById(todoId);
  if (todo == null || !context.mounted) {
    ref.read(reminderActionProvider.notifier).clear();
    return;
  }

  await showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (sheetContext) {
      return _ReminderActionSheetContent(
        todo: todo,
        onClose: () {
          ref.read(reminderActionProvider.notifier).clear();
          Navigator.pop(sheetContext);
        },
      );
    },
  );

  ref.read(reminderActionProvider.notifier).clear();
}

class _ReminderActionSheetContent extends ConsumerStatefulWidget {
  const _ReminderActionSheetContent({
    required this.todo,
    required this.onClose,
  });

  final Todo todo;
  final VoidCallback onClose;

  @override
  ConsumerState<_ReminderActionSheetContent> createState() =>
      _ReminderActionSheetContentState();
}

class _ReminderActionSheetContentState
    extends ConsumerState<_ReminderActionSheetContent> {
  bool showPostponeOptions = false;
  String? errorMessage;

  Future<void> _postponeTo(DateTime newReminderAt) async {
    final localizations = AppLocalizations.of(context)!;
    if (!newReminderAt.isAfter(DateTime.now())) {
      setState(() {
        errorMessage = localizations.reminderMustBeFuture;
      });
      return;
    }

    await ref
        .read(todosProvider.notifier)
        .postponeReminder(widget.todo.id, newReminderAt);
    widget.onClose();
  }

  Future<void> _pickManualTime() async {
    final now = DateTime.now();
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now.add(const Duration(hours: 1)),
      firstDate: now,
      lastDate: now.add(const Duration(days: 365 * 5)),
    );

    if (pickedDate == null || !mounted) {
      return;
    }

    final pickedTime = await showConfiguredTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(
        now.add(const Duration(hours: 1)),
      ),
      use24HourFormat: ref.read(settingsProvider).use24HourTimeFormat,
    );

    if (pickedTime == null) {
      return;
    }

    final selectedDateTime = DateTime(
      pickedDate.year,
      pickedDate.month,
      pickedDate.day,
      pickedTime.hour,
      pickedTime.minute,
    );

    await _postponeTo(selectedDateTime);
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context).toString();
    final dateFormat = DateFormat('MMM d, h:mm a', locale);
    final presets = ref.watch(settingsProvider).postponePresets;
    final reminderTime = widget.todo.reminderAt;
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      margin: const EdgeInsets.fromLTRB(12, 0, 12, 12),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: colorScheme.outline),
        boxShadow: [
          BoxShadow(
            color: AppColors.indigo.withValues(alpha: 0.15),
            blurRadius: 32,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: colorScheme.outline,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      gradient: AppColors.subtleGradient,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Icon(
                      Icons.notifications_active_rounded,
                      color: AppColors.indigo,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.todo.title,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        if (reminderTime != null)
                          Text(
                            localizations.reminderAt(
                              dateFormat.format(reminderTime),
                            ),
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                      ],
                    ),
                  ),
                ],
              ),
              if (errorMessage != null) ...[
                const SizedBox(height: 12),
                Text(
                  errorMessage!,
                  style: TextStyle(color: colorScheme.error),
                ),
              ],
              const SizedBox(height: 20),
              GradientButton(
                onPressed: () async {
                  await ref
                      .read(todosProvider.notifier)
                      .markComplete(widget.todo.id);
                  widget.onClose();
                },
                label: localizations.markDone,
                icon: Icons.check_rounded,
              ),
              const SizedBox(height: 10),
              if (!showPostponeOptions)
                OutlinedButton.icon(
                  onPressed: () {
                    setState(() {
                      showPostponeOptions = true;
                      errorMessage = null;
                    });
                  },
                  icon: const Icon(Icons.snooze_rounded),
                  label: Text(localizations.postpone),
                )
              else ...[
                Text(
                  localizations.postponeFor,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    for (final preset in presets)
                      ActionChip(
                        label: Text(presetDisplayLabel(preset, localizations)),
                        onPressed: () => _postponeTo(
                          preset.resolveTarget(DateTime.now()),
                        ),
                      ),
                    ActionChip(
                      avatar: const Icon(Icons.edit_calendar, size: 18),
                      label: Text(localizations.pickTime),
                      onPressed: _pickManualTime,
                    ),
                  ],
                ),
              ],
              const SizedBox(height: 8),
              TextButton(
                onPressed: widget.onClose,
                child: Text(localizations.cancel),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
