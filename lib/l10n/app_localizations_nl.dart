// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Dutch Flemish (`nl`).
class AppLocalizationsNl extends AppLocalizations {
  AppLocalizationsNl([String locale = 'nl']) : super(locale);

  @override
  String get appTitle => 'Taakherinnering';

  @override
  String get settings => 'Instellingen';

  @override
  String get active => 'Actief';

  @override
  String get finished => 'Voltooid';

  @override
  String get taskGroupToday => 'Vandaag';

  @override
  String get taskGroupTomorrow => 'Morgen';

  @override
  String get taskGroupUpcoming => 'Komende';

  @override
  String get taskGroupNoReminder => 'Geen herinnering';

  @override
  String get completed => 'Voltooid';

  @override
  String get noTasksYet => 'Nog geen taken';

  @override
  String get tapToAddFirstTask => 'Tik op + om je eerste taak toe te voegen';

  @override
  String get editTask => 'Taak bewerken';

  @override
  String get addTask => 'Taak toevoegen';

  @override
  String get save => 'Opslaan';

  @override
  String get title => 'Titel';

  @override
  String get titleRequired => 'Titel is verplicht';

  @override
  String get saveFailed =>
      'Taak kon niet worden opgeslagen. Probeer het opnieuw.';

  @override
  String get notesOptional => 'Notities (optioneel)';

  @override
  String get remindMe => 'Herinner mij';

  @override
  String get reminderChooseWhen => 'Kies wanneer je herinnerd wilt worden';

  @override
  String get reminderOptionCustom => 'Datum & tijd kiezen';

  @override
  String get defaultTomorrowReminder => 'Herinneringstijd morgen';

  @override
  String get defaultTomorrowReminderDescription =>
      'Standaardtijd voor de snelle morgen-optie bij het instellen van een herinnering.';

  @override
  String get use24HourTime => '24-uursnotatie';

  @override
  String get use24HourTimeDescription =>
      'Gebruik 24-uursnotatie in plaats van AM/PM voor tijdkeuze en herinneringen.';

  @override
  String get pickDateAndTime => 'Kies datum en tijd';

  @override
  String get pickReminderDateAndTime =>
      'Kies een datum en tijd voor de herinnering';

  @override
  String get reminderMustBeFuture =>
      'De herinnering moet in de toekomst liggen';

  @override
  String get deleteTask => 'Taak verwijderen';

  @override
  String get deleteTaskQuestion => 'Taak verwijderen?';

  @override
  String get deleteCannotBeUndone => 'Dit kan niet ongedaan worden gemaakt.';

  @override
  String get cancel => 'Annuleren';

  @override
  String get delete => 'Verwijderen';

  @override
  String removeTaskConfirm(String title) {
    return '\"$title\" verwijderen?';
  }

  @override
  String get postponeOptions => 'Uitstelopties';

  @override
  String get postponeOptionsDescription =>
      'Deze verschijnen wanneer je een herinnering uitstelt.';

  @override
  String get addPostponeOption => 'Uitsteloptie toevoegen';

  @override
  String get enableNotifications => 'Meldingen inschakelen';

  @override
  String get notificationPermissionsRequested =>
      'Meldingstoestemming aangevraagd';

  @override
  String minutesFromNowDescription(int count) {
    return '$count minuten vanaf nu';
  }

  @override
  String hoursFromNowDescription(int count) {
    return '$count uur vanaf nu';
  }

  @override
  String tomorrowAtDescription(String time) {
    return 'Morgen om $time';
  }

  @override
  String get deleteOptionQuestion => 'Optie verwijderen?';

  @override
  String removeOptionConfirm(String label) {
    return '\"$label\" verwijderen?';
  }

  @override
  String get addOption => 'Optie toevoegen';

  @override
  String get editOption => 'Optie bewerken';

  @override
  String get label => 'Label';

  @override
  String get type => 'Type';

  @override
  String get minutesFromNowType => 'Minuten vanaf nu';

  @override
  String get hoursFromNowType => 'Uren vanaf nu';

  @override
  String get tomorrowAtTimeType => 'Morgen op een tijd';

  @override
  String get minutes => 'Minuten';

  @override
  String get hours => 'Uren';

  @override
  String get hourRange => 'Uur (0-23)';

  @override
  String get minuteRange => 'Minuut (0-59)';

  @override
  String get markDone => 'Markeer als klaar';

  @override
  String get postpone => 'Uitstellen';

  @override
  String get postponeFor => 'Uitstellen met';

  @override
  String get pickTime => 'Tijd kiezen…';

  @override
  String reminderAt(String time) {
    return 'Herinnering: $time';
  }

  @override
  String get preset15Minutes => '15 minuten';

  @override
  String get preset1Hour => '1 uur';

  @override
  String get preset3Hours => '3 uur';

  @override
  String get presetTomorrowMorning => 'Morgen 9:00';

  @override
  String get language => 'Taal';

  @override
  String get languageSystem => 'Systeemstandaard';

  @override
  String get languageEnglish => 'Engels';

  @override
  String get languageSpanish => 'Spaans';

  @override
  String get languageGerman => 'Duits';

  @override
  String get languageDutch => 'Nederlands';

  @override
  String get languageFrench => 'Frans';

  @override
  String get languageItalian => 'Italiaans';

  @override
  String get languageRussian => 'Russisch';

  @override
  String get languageUkrainian => 'Oekraïens';

  @override
  String get languagePortuguese => 'Portugees';

  @override
  String get appearance => 'Weergave';

  @override
  String get themeSystem => 'Systeemstandaard';

  @override
  String get themeLight => 'Licht';

  @override
  String get themeDark => 'Donker';

  @override
  String get notificationChannelName => 'Taakherinneringen';

  @override
  String get notificationChannelDescription =>
      'Meldingen voor taakherinneringen';

  @override
  String get madeByRbdApps => 'Gemaakt door RBD Apps';
}
