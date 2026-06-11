import 'postpone_preset.dart';
import 'theme_preference.dart';

class AppSettings {
  const AppSettings({
    required this.postponePresets,
    this.languageCode,
    this.themePreference = ThemePreference.system,
    this.defaultTomorrowReminderHour = 9,
    this.defaultTomorrowReminderMinute = 0,
  });

  final List<PostponePreset> postponePresets;
  final String? languageCode;
  final ThemePreference themePreference;
  final int defaultTomorrowReminderHour;
  final int defaultTomorrowReminderMinute;

  AppSettings copyWith({
    List<PostponePreset>? postponePresets,
    String? languageCode,
    bool clearLanguageCode = false,
    ThemePreference? themePreference,
    int? defaultTomorrowReminderHour,
    int? defaultTomorrowReminderMinute,
  }) {
    return AppSettings(
      postponePresets: postponePresets ?? this.postponePresets,
      languageCode:
          clearLanguageCode ? null : (languageCode ?? this.languageCode),
      themePreference: themePreference ?? this.themePreference,
      defaultTomorrowReminderHour:
          defaultTomorrowReminderHour ?? this.defaultTomorrowReminderHour,
      defaultTomorrowReminderMinute:
          defaultTomorrowReminderMinute ?? this.defaultTomorrowReminderMinute,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'postponePresets':
          postponePresets.map((preset) => preset.toMap()).toList(),
      'languageCode': languageCode,
      'themePreference': themePreference.storageValue,
      'defaultTomorrowReminderHour': defaultTomorrowReminderHour,
      'defaultTomorrowReminderMinute': defaultTomorrowReminderMinute,
    };
  }

  factory AppSettings.fromMap(Map<dynamic, dynamic> map) {
    final presetsRaw = map['postponePresets'] as List<dynamic>? ?? [];
    return AppSettings(
      postponePresets: presetsRaw
          .map(
            (preset) => PostponePreset.fromMap(preset as Map<dynamic, dynamic>),
          )
          .toList(),
      languageCode: map['languageCode'] as String?,
      themePreference: ThemePreference.fromStorage(
        map['themePreference'] as String?,
      ),
      defaultTomorrowReminderHour:
          map['defaultTomorrowReminderHour'] as int? ?? 9,
      defaultTomorrowReminderMinute:
          map['defaultTomorrowReminderMinute'] as int? ?? 0,
    );
  }

  static AppSettings defaults() {
    return AppSettings(
      postponePresets: PostponePreset.defaultPresets(),
    );
  }
}
