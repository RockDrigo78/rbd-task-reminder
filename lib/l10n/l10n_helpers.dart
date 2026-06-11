import 'package:flutter/material.dart';

import 'package:task_reminder/l10n/app_localizations.dart';

import '../models/postpone_preset.dart';

const List<String> supportedLanguageCodes = [
  'en',
  'es',
  'de',
  'nl',
  'fr',
  'it',
  'ru',
  'uk',
  'pt',
];

String presetDisplayLabel(PostponePreset preset, AppLocalizations localizations) {
  switch (preset.id) {
    case 'preset-15m':
      return localizations.preset15Minutes;
    case 'preset-1h':
      return localizations.preset1Hour;
    case 'preset-3h':
      return localizations.preset3Hours;
    case 'preset-tomorrow':
      return localizations.presetTomorrowMorning;
    default:
      return preset.label;
  }
}

String presetDescription(
  PostponePreset preset,
  AppLocalizations localizations,
) {
  switch (preset.type) {
    case PostponePresetType.minutes:
      return localizations.minutesFromNowDescription(preset.amount ?? 0);
    case PostponePresetType.hours:
      return localizations.hoursFromNowDescription(preset.amount ?? 0);
    case PostponePresetType.tomorrowAt:
      final hour = preset.hour ?? 9;
      final minute = preset.minute ?? 0;
      final minuteText = minute.toString().padLeft(2, '0');
      return localizations.tomorrowAtDescription('$hour:$minuteText');
  }
}

Locale resolveAppLocale(String? languageCode) {
  if (languageCode == null) {
    return WidgetsBinding.instance.platformDispatcher.locale;
  }

  return Locale(languageCode);
}

AppLocalizations localizationsForLanguageCode(String? languageCode) {
  final locale = resolveAppLocale(languageCode);
  return lookupAppLocalizations(locale);
}

String localizedLanguageName(AppLocalizations localizations, String code) {
  switch (code) {
    case 'en':
      return localizations.languageEnglish;
    case 'es':
      return localizations.languageSpanish;
    case 'de':
      return localizations.languageGerman;
    case 'nl':
      return localizations.languageDutch;
    case 'fr':
      return localizations.languageFrench;
    case 'it':
      return localizations.languageItalian;
    case 'ru':
      return localizations.languageRussian;
    case 'uk':
      return localizations.languageUkrainian;
    case 'pt':
      return localizations.languagePortuguese;
    default:
      return code;
  }
}

String? languageSelectionValue(String? languageCode) {
  if (languageCode == null) {
    return null;
  }

  if (supportedLanguageCodes.contains(languageCode)) {
    return languageCode;
  }

  return null;
}
