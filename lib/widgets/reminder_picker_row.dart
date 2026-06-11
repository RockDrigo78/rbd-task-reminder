import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../l10n/app_localizations.dart';
import '../providers/settings_provider.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../utils/reminder_helpers.dart';
import 'app_card.dart';

enum ReminderPickMode { tomorrow, custom }

class ReminderPickerRow extends ConsumerStatefulWidget {
  const ReminderPickerRow({
    super.key,
    required this.reminderEnabled,
    required this.reminderAt,
    required this.onReminderEnabledChanged,
    required this.onReminderAtChanged,
  });

  final bool reminderEnabled;
  final DateTime? reminderAt;
  final ValueChanged<bool> onReminderEnabledChanged;
  final ValueChanged<DateTime?> onReminderAtChanged;

  @override
  ConsumerState<ReminderPickerRow> createState() => _ReminderPickerRowState();
}

class _ReminderPickerRowState extends ConsumerState<ReminderPickerRow> {
  ReminderPickMode? selectedMode;

  @override
  void initState() {
    super.initState();
    _syncModeFromReminder();
  }

  @override
  void didUpdateWidget(covariant ReminderPickerRow oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.reminderAt != widget.reminderAt ||
        oldWidget.reminderEnabled != widget.reminderEnabled) {
      _syncModeFromReminder();
    }
  }

  void _syncModeFromReminder() {
    if (!widget.reminderEnabled || widget.reminderAt == null) {
      selectedMode = null;
      return;
    }

    final settings = ref.read(settingsProvider);
    final tomorrowTarget = tomorrowReminderAt(
      hour: settings.defaultTomorrowReminderHour,
      minute: settings.defaultTomorrowReminderMinute,
    );

    selectedMode = isSameReminderMinute(widget.reminderAt!, tomorrowTarget)
        ? ReminderPickMode.tomorrow
        : ReminderPickMode.custom;
  }

  void _selectTomorrow() {
    final settings = ref.read(settingsProvider);
    final tomorrowTarget = tomorrowReminderAt(
      hour: settings.defaultTomorrowReminderHour,
      minute: settings.defaultTomorrowReminderMinute,
    );

    setState(() {
      selectedMode = ReminderPickMode.tomorrow;
    });
    widget.onReminderAtChanged(tomorrowTarget);
  }

  Future<void> _pickCustomReminder(BuildContext context) async {
    final now = DateTime.now();
    final initialDate = widget.reminderAt ?? now.add(const Duration(hours: 1));

    final pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: now,
      lastDate: now.add(const Duration(days: 365 * 5)),
    );

    if (pickedDate == null || !context.mounted) {
      return;
    }

    final pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(widget.reminderAt ?? initialDate),
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

    setState(() {
      selectedMode = ReminderPickMode.custom;
    });
    widget.onReminderAtChanged(selectedDateTime);
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final settings = ref.watch(settingsProvider);
    final locale = Localizations.localeOf(context).toString();
    final dateFormat = DateFormat('MMM d, yyyy · h:mm a', locale);
    final colorScheme = Theme.of(context).colorScheme;
    final tomorrowTimeLabel = formatReminderClockTime(
      hour: settings.defaultTomorrowReminderHour,
      minute: settings.defaultTomorrowReminderMinute,
      locale: locale,
    );
    final tomorrowOptionLabel =
        localizations.tomorrowAtDescription(tomorrowTimeLabel);

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    gradient: AppColors.subtleGradient,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.alarm_rounded,
                    size: 20,
                    color: AppColors.indigo,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  localizations.remindMe,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
            value: widget.reminderEnabled,
            onChanged: (enabled) {
              widget.onReminderEnabledChanged(enabled);
              if (enabled) {
                _selectTomorrow();
              } else {
                setState(() {
                  selectedMode = null;
                });
                widget.onReminderAtChanged(null);
              }
            },
          ),
          if (widget.reminderEnabled) ...[
            Divider(color: colorScheme.outline),
            Padding(
              padding: const EdgeInsets.only(top: 4, bottom: 8),
              child: Text(
                localizations.reminderChooseWhen,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
              ),
            ),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ChoiceChip(
                  label: Text(tomorrowOptionLabel),
                  selected: selectedMode == ReminderPickMode.tomorrow,
                  onSelected: (_) => _selectTomorrow(),
                ),
                ChoiceChip(
                  label: Text(localizations.reminderOptionCustom),
                  selected: selectedMode == ReminderPickMode.custom,
                  onSelected: (_) => _pickCustomReminder(context),
                ),
              ],
            ),
            if (widget.reminderAt != null) ...[
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                decoration: BoxDecoration(
                  color: colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(AppTheme.chipRadius),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.schedule_rounded,
                      size: 18,
                      color: colorScheme.primary,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        dateFormat.format(widget.reminderAt!),
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ),
                    if (selectedMode == ReminderPickMode.custom)
                      TextButton(
                        onPressed: () => _pickCustomReminder(context),
                        child: Text(localizations.pickTime),
                      ),
                  ],
                ),
              ),
            ],
          ],
        ],
      ),
    );
  }
}
