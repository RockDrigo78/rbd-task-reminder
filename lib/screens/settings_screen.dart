import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../l10n/app_localizations.dart';
import '../l10n/l10n_helpers.dart';
import '../models/postpone_preset.dart';
import '../models/app_settings.dart';
import '../models/theme_preference.dart';
import '../providers/settings_provider.dart';
import '../providers/service_providers.dart';
import '../providers/todo_provider.dart';
import '../theme/app_colors.dart';
import '../utils/reminder_helpers.dart';
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: AppColors.subtleGradient,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: AppColors.indigo.withValues(alpha: 0.2),
                  ),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () async {
                      final notificationService =
                          ref.read(notificationServiceProvider);
                      await notificationService.requestPermissions();
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              localizations.notificationPermissionsRequested,
                            ),
                          ),
                        );
                      }
                    },
                    borderRadius: BorderRadius.circular(20),
                    child: Padding(
                      padding: const EdgeInsets.all(18),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              gradient: AppColors.primaryGradient,
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: const Icon(
                              Icons.notifications_active_rounded,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Text(
                              localizations.enableNotifications,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                          const Icon(Icons.chevron_right_rounded),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
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
    );
  }

  Future<void> _pickDefaultTomorrowTime(
    BuildContext context,
    WidgetRef ref,
    AppSettings settings,
  ) async {
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(
        hour: settings.defaultTomorrowReminderHour,
        minute: settings.defaultTomorrowReminderMinute,
      ),
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
