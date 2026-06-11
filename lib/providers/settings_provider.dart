import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/app_settings.dart';
import '../models/postpone_preset.dart';
import '../models/theme_preference.dart';
import '../repositories/settings_repository.dart';

final settingsRepositoryProvider = Provider<SettingsRepository>((ref) {
  throw UnimplementedError('SettingsRepository must be overridden');
});

final settingsProvider =
    StateNotifierProvider<SettingsNotifier, AppSettings>((ref) {
  final repository = ref.watch(settingsRepositoryProvider);
  return SettingsNotifier(repository);
});

class SettingsNotifier extends StateNotifier<AppSettings> {
  SettingsNotifier(this._repository) : super(_repository.getSettings());

  final SettingsRepository _repository;

  Future<void> updatePresets(List<PostponePreset> presets) async {
    final updatedSettings = state.copyWith(postponePresets: presets);
    state = updatedSettings;
    await _repository.saveSettings(updatedSettings);
  }

  Future<void> addPreset(PostponePreset preset) async {
    await updatePresets([...state.postponePresets, preset]);
  }

  Future<void> updatePreset(PostponePreset preset) async {
    final updatedPresets = state.postponePresets
        .map((existing) => existing.id == preset.id ? preset : existing)
        .toList();
    await updatePresets(updatedPresets);
  }

  Future<void> deletePreset(String presetId) async {
    final updatedPresets = state.postponePresets
        .where((preset) => preset.id != presetId)
        .toList();
    await updatePresets(updatedPresets);
  }

  Future<void> reorderPresets(int oldIndex, int newIndex) async {
    final presets = [...state.postponePresets];
    final movedPreset = presets.removeAt(oldIndex);
    presets.insert(newIndex, movedPreset);
    await updatePresets(presets);
  }

  Future<void> updateLanguageCode(String? languageCode) async {
    final updatedSettings = state.copyWith(
      languageCode: languageCode,
      clearLanguageCode: languageCode == null,
    );
    state = updatedSettings;
    await _repository.saveSettings(updatedSettings);
  }

  Future<void> updateThemePreference(ThemePreference themePreference) async {
    final updatedSettings = state.copyWith(themePreference: themePreference);
    state = updatedSettings;
    await _repository.saveSettings(updatedSettings);
  }

  Future<void> updateDefaultTomorrowReminderTime({
    required int hour,
    required int minute,
  }) async {
    final updatedSettings = state.copyWith(
      defaultTomorrowReminderHour: hour,
      defaultTomorrowReminderMinute: minute,
    );
    state = updatedSettings;
    await _repository.saveSettings(updatedSettings);
  }
}
