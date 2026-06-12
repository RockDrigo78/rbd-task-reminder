import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../l10n/app_localizations.dart';
import '../l10n/l10n_helpers.dart';
import '../models/postpone_preset.dart';
import '../models/app_settings.dart';
import '../models/theme_preference.dart';
import '../providers/settings_provider.dart';
import '../models/reminder_permission_status.dart';
import '../providers/service_providers.dart';
import '../providers/todo_provider.dart';
import '../theme/app_colors.dart';
import '../utils/reminder_helpers.dart';
import '../utils/time_picker_helpers.dart';
import '../widgets/app_background.dart';
import '../widgets/app_card.dart';
import '../widgets/app_footer.dart';
import '../widgets/section_header.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    final settings = ref.watch(settingsProvider);
    final presets = settings.postponePresets;

    return AppBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_rounded),
          ),
          title: Text(localizations.settings),
        ),
        body: ListView(
          padding: const EdgeInsets.only(bottom: 32),
          children: [
            SectionHeader(title: localizations.language),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: AppCard(
                child: DropdownButtonFormField<String?>(
                  value: languageSelectionValue(settings.languageCode),
                  decoration: InputDecoration(
                    labelText: localizations.language,
                    prefixIcon: const Icon(Icons.language_rounded),
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                  ),
                  isExpanded: true,
                  items: [
                    DropdownMenuItem<String?>(
                      value: null,
                      child: Text(localizations.languageSystem),
                    ),
                    for (final languageCode in supportedLanguageCodes)
                      DropdownMenuItem<String?>(
                        value: languageCode,
                        child: Text(
                          localizedLanguageName(localizations, languageCode),
                        ),
                      ),
                  ],
                  onChanged: (languageCode) {
                    _updateLanguage(ref, languageCode);
                  },
                ),
              ),
            ),
            SectionHeader(title: localizations.appearance),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: AppCard(
                child: Column(
                  children: [
                    _SettingsOptionTile(
                      title: localizations.themeSystem,
                      icon: Icons.brightness_auto_rounded,
                      isSelected:
                          settings.themePreference == ThemePreference.system,
                      onTap: () => _updateTheme(
                        ref,
                        ThemePreference.system,
                      ),
                    ),
                    Divider(
                      height: 1,
                      color: Theme.of(context).colorScheme.outline,
                    ),
                    _SettingsOptionTile(
                      title: localizations.themeLight,
                      icon: Icons.light_mode_rounded,
                      isSelected:
                          settings.themePreference == ThemePreference.light,
                      onTap: () => _updateTheme(ref, ThemePreference.light),
                    ),
                    Divider(
                      height: 1,
                      color: Theme.of(context).colorScheme.outline,
                    ),
                    _SettingsOptionTile(
                      title: localizations.themeDark,
                      icon: Icons.dark_mode_rounded,
                      isSelected:
                          settings.themePreference == ThemePreference.dark,
                      onTap: () => _updateTheme(ref, ThemePreference.dark),
                    ),
                  ],
                ),
              ),
            ),
            SectionHeader(title: localizations.defaultTomorrowReminder),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: AppCard(
                child: SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(localizations.use24HourTime),
                  subtitle: Text(localizations.use24HourTimeDescription),
                  value: settings.use24HourTimeFormat,
                  onChanged: (enabled) {
                    ref
                        .read(settingsProvider.notifier)
                        .updateUse24HourTimeFormat(enabled);
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    localizations.defaultTomorrowReminderDescription,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 12),
                  AppCard(
                    onTap: () => _pickDefaultTomorrowTime(context, ref, settings),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            gradient: AppColors.subtleGradient,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: const Icon(
                            Icons.wb_sunny_rounded,
                            color: AppColors.indigo,
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Text(
                            localizations.tomorrowAtDescription(
                              _formatTomorrowTime(context, settings),
                            ),
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                        Icon(
                          Icons.chevron_right_rounded,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SectionHeader(title: localizations.postponeOptions),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                localizations.postponeOptionsDescription,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            const SizedBox(height: 12),
            ReorderableListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: presets.length,
              onReorderItem: (oldIndex, newIndex) {
                ref
                    .read(settingsProvider.notifier)
                    .reorderPresets(oldIndex, newIndex);
              },
              itemBuilder: (context, index) {
                final preset = presets[index];
                return Padding(
                  key: ValueKey(preset.id),
                  padding: const EdgeInsets.only(bottom: 10),
                  child: AppCard(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(
                        Icons.drag_handle_rounded,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                      title: Text(presetDisplayLabel(preset, localizations)),
                      subtitle: Text(presetDescription(preset, localizations)),
                      trailing: IconButton(
                        icon: const Icon(Icons.edit_outlined),
                        onPressed: () => _showPresetEditor(
                          context: context,
                          ref: ref,
                          preset: preset,
                        ),
                      ),
                      onLongPress: presets.length > 1
                          ? () => _confirmDeletePreset(context, ref, preset)
                          : null,
                    ),
                  ),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: OutlinedButton.icon(
                onPressed: () => _showPresetEditor(context: context, ref: ref),
                icon: const Icon(Icons.add_rounded),
                label: Text(localizations.addPostponeOption),
              ),
            ),
            const SizedBox(height: 24),
            SectionHeader(title: localizations.reminderPermissions),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: _ReminderPermissionsCard(localizations: localizations),
            ),
            const AppFooter(),
          ],
        ),
      ),
    );
  }

  Future<void> _updateLanguage(WidgetRef ref, String? languageCode) async {
    await ref.read(settingsProvider.notifier).updateLanguageCode(languageCode);
    await ref.read(todosProvider.notifier).rescheduleAllReminders();
  }

  Future<void> _updateTheme(
    WidgetRef ref,
    ThemePreference themePreference,
  ) async {
    await ref
        .read(settingsProvider.notifier)
        .updateThemePreference(themePreference);
  }

  String _formatTomorrowTime(BuildContext context, AppSettings settings) {
    return formatReminderClockTime(
      hour: settings.defaultTomorrowReminderHour,
      minute: settings.defaultTomorrowReminderMinute,
      locale: Localizations.localeOf(context).toString(),
      use24HourFormat: settings.use24HourTimeFormat,
    );
  }

  Future<void> _pickDefaultTomorrowTime(
    BuildContext context,
    WidgetRef ref,
    AppSettings settings,
  ) async {
    final pickedTime = await showConfiguredTimePicker(
      context: context,
      initialTime: TimeOfDay(
        hour: settings.defaultTomorrowReminderHour,
        minute: settings.defaultTomorrowReminderMinute,
      ),
      use24HourFormat: settings.use24HourTimeFormat,
    );

    if (pickedTime == null) {
      return;
    }

    await ref.read(settingsProvider.notifier).updateDefaultTomorrowReminderTime(
          hour: pickedTime.hour,
          minute: pickedTime.minute,
        );
  }

  Future<void> _confirmDeletePreset(
    BuildContext context,
    WidgetRef ref,
    PostponePreset preset,
  ) async {
    final localizations = AppLocalizations.of(context)!;
    final presetLabel = presetDisplayLabel(preset, localizations);
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(localizations.deleteOptionQuestion),
        content: Text(localizations.removeOptionConfirm(presetLabel)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(localizations.cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(localizations.delete),
          ),
        ],
      ),
    );

    if (shouldDelete == true) {
      await ref.read(settingsProvider.notifier).deletePreset(preset.id);
    }
  }

  Future<void> _showPresetEditor({
    required BuildContext context,
    required WidgetRef ref,
    PostponePreset? preset,
  }) async {
    final localizations = AppLocalizations.of(context)!;
    final initialLabel = preset == null
        ? ''
        : presetDisplayLabel(preset, localizations);
    final labelController = TextEditingController(text: initialLabel);
    PostponePresetType selectedType =
        preset?.type ?? PostponePresetType.minutes;
    final amountController = TextEditingController(
      text: (preset?.amount ?? 15).toString(),
    );
    final hourController = TextEditingController(
      text: (preset?.hour ?? 9).toString(),
    );
    final minuteController = TextEditingController(
      text: (preset?.minute ?? 0).toString(),
    );

    await showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setState) {
            final dialogLocalizations = AppLocalizations.of(context)!;

            return AlertDialog(
              title: Text(
                preset == null
                    ? dialogLocalizations.addOption
                    : dialogLocalizations.editOption,
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: labelController,
                      decoration: InputDecoration(
                        labelText: dialogLocalizations.label,
                      ),
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<PostponePresetType>(
                      value: selectedType,
                      decoration: InputDecoration(
                        labelText: dialogLocalizations.type,
                      ),
                      items: [
                        DropdownMenuItem(
                          value: PostponePresetType.minutes,
                          child: Text(dialogLocalizations.minutesFromNowType),
                        ),
                        DropdownMenuItem(
                          value: PostponePresetType.hours,
                          child: Text(dialogLocalizations.hoursFromNowType),
                        ),
                        DropdownMenuItem(
                          value: PostponePresetType.tomorrowAt,
                          child: Text(dialogLocalizations.tomorrowAtTimeType),
                        ),
                      ],
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            selectedType = value;
                          });
                        }
                      },
                    ),
                    const SizedBox(height: 12),
                    if (selectedType == PostponePresetType.minutes ||
                        selectedType == PostponePresetType.hours)
                      TextField(
                        controller: amountController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: selectedType == PostponePresetType.minutes
                              ? dialogLocalizations.minutes
                              : dialogLocalizations.hours,
                        ),
                      ),
                    if (selectedType == PostponePresetType.tomorrowAt) ...[
                      TextField(
                        controller: hourController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: dialogLocalizations.hourRange,
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: minuteController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: dialogLocalizations.minuteRange,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              actions: [
                if (preset != null &&
                    ref.read(settingsProvider).postponePresets.length > 1)
                  TextButton(
                    onPressed: () async {
                      await ref
                          .read(settingsProvider.notifier)
                          .deletePreset(preset.id);
                      if (dialogContext.mounted) {
                        Navigator.pop(dialogContext);
                      }
                    },
                    child: Text(dialogLocalizations.delete),
                  ),
                TextButton(
                  onPressed: () => Navigator.pop(dialogContext),
                  child: Text(dialogLocalizations.cancel),
                ),
                FilledButton(
                  onPressed: () async {
                    final label = labelController.text.trim();
                    if (label.isEmpty) {
                      return;
                    }

                    final amount = int.tryParse(amountController.text);
                    final hour = int.tryParse(hourController.text);
                    final minute = int.tryParse(minuteController.text);

                    final updatedPreset = PostponePreset(
                      id: preset?.id ??
                          DateTime.now().microsecondsSinceEpoch.toString(),
                      label: label,
                      type: selectedType,
                      amount: selectedType == PostponePresetType.tomorrowAt
                          ? null
                          : amount,
                      hour: selectedType == PostponePresetType.tomorrowAt
                          ? hour
                          : null,
                      minute: selectedType == PostponePresetType.tomorrowAt
                          ? minute
                          : null,
                    );

                    if (preset == null) {
                      await ref
                          .read(settingsProvider.notifier)
                          .addPreset(updatedPreset);
                    } else {
                      await ref
                          .read(settingsProvider.notifier)
                          .updatePreset(updatedPreset);
                    }

                    if (dialogContext.mounted) {
                      Navigator.pop(dialogContext);
                    }
                  },
                  child: Text(dialogLocalizations.save),
                ),
              ],
            );
          },
        );
      },
    );

    labelController.dispose();
    amountController.dispose();
    hourController.dispose();
    minuteController.dispose();
  }
}

class _SettingsOptionTile extends StatelessWidget {
  const _SettingsOptionTile({
    required this.title,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  final String title;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return ListTile(
      onTap: onTap,
      contentPadding: EdgeInsets.zero,
      leading: Icon(
        icon,
        color: isSelected ? AppColors.indigo : colorScheme.onSurfaceVariant,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
          color: isSelected ? AppColors.indigo : colorScheme.onSurface,
        ),
      ),
      trailing: isSelected
          ? const Icon(Icons.check_circle_rounded, color: AppColors.indigo)
          : null,
    );
  }
}

class _ReminderPermissionsCard extends ConsumerStatefulWidget {
  const _ReminderPermissionsCard({required this.localizations});

  final AppLocalizations localizations;

  @override
  ConsumerState<_ReminderPermissionsCard> createState() =>
      _ReminderPermissionsCardState();
}

class _ReminderPermissionsCardState
    extends ConsumerState<_ReminderPermissionsCard>
    with WidgetsBindingObserver {
  late Future<ReminderPermissionStatus> _permissionStatusFuture;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _permissionStatusFuture = _loadPermissionStatus();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      unawaited(_refreshPermissionStatus());
    }
  }

  Future<ReminderPermissionStatus> _loadPermissionStatus() {
    return ref.read(notificationServiceProvider).getReminderPermissionStatus();
  }

  Future<void> _refreshPermissionStatus() async {
    setState(() {
      _permissionStatusFuture = _loadPermissionStatus();
    });
    await _permissionStatusFuture;
  }

  @override
  Widget build(BuildContext context) {
    final localizations = widget.localizations;
    final colorScheme = Theme.of(context).colorScheme;

    return FutureBuilder<ReminderPermissionStatus>(
      future: _permissionStatusFuture,
      builder: (context, snapshot) {
        final status = snapshot.data;

        return AppCard(
          child: Column(
            children: [
              _PermissionStatusRow(
                label: status?.notificationsEnabled == true
                    ? localizations.notificationsPermissionGranted
                    : localizations.notificationsPermissionMissing,
                isGranted: status?.notificationsEnabled == true,
              ),
              Divider(color: colorScheme.outline),
              _PermissionStatusRow(
                label: status?.exactAlarmsEnabled == true
                    ? localizations.exactAlarmsPermissionGranted
                    : localizations.exactAlarmsPermissionMissing,
                isGranted: status?.exactAlarmsEnabled == true,
              ),
              Divider(color: colorScheme.outline),
              _PermissionStatusRow(
                label: status?.batteryOptimizationDisabled == true
                    ? localizations.batteryOptimizationDisabled
                    : localizations.batteryOptimizationEnabled,
                isGranted: status?.batteryOptimizationDisabled == true,
              ),
              if (status != null && !status.isReliable) ...[
                Divider(color: colorScheme.outline),
                Padding(
                  padding: const EdgeInsets.only(top: 4, bottom: 8),
                  child: Text(
                    localizations.remindersMayBeLate,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: colorScheme.error,
                        ),
                  ),
                ),
              ],
              const SizedBox(height: 8),
              if (status?.notificationsEnabled != true)
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () async {
                      await ref
                          .read(notificationServiceProvider)
                          .requestPermissions();
                      await _refreshPermissionStatus();
                    },
                    icon: const Icon(Icons.notifications_active_rounded),
                    label: Text(localizations.enableNotifications),
                  ),
                ),
              if (status?.exactAlarmsEnabled != true) ...[
                if (status?.notificationsEnabled != true)
                  const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed: () async {
                      await ref
                          .read(notificationServiceProvider)
                          .openExactAlarmSettings();
                      await _refreshPermissionStatus();
                    },
                    icon: const Icon(Icons.alarm_rounded),
                    label: Text(localizations.enableExactAlarms),
                  ),
                ),
              ],
              if (status?.batteryOptimizationDisabled != true) ...[
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () async {
                      await ref
                          .read(notificationServiceProvider)
                          .requestBatteryOptimizationExemption();
                      await _refreshPermissionStatus();
                    },
                    icon: const Icon(Icons.battery_charging_full_rounded),
                    label: Text(localizations.disableBatteryOptimization),
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: TextButton.icon(
                    onPressed: () async {
                      await ref
                          .read(notificationServiceProvider)
                          .openAppSettingsPage();
                      await _refreshPermissionStatus();
                    },
                    icon: const Icon(Icons.settings_rounded),
                    label: Text(localizations.openAppBatterySettings),
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}

class _PermissionStatusRow extends StatelessWidget {
  const _PermissionStatusRow({
    required this.label,
    required this.isGranted,
  });

  final String label;
  final bool isGranted;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(
            isGranted ? Icons.check_circle_rounded : Icons.error_outline_rounded,
            color: isGranted ? AppColors.indigo : Theme.of(context).colorScheme.error,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}
