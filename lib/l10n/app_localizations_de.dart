// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'Aufgaben-Erinnerung';

  @override
  String get settings => 'Einstellungen';

  @override
  String get active => 'Aktiv';

  @override
  String get completed => 'Erledigt';

  @override
  String get noTasksYet => 'Noch keine Aufgaben';

  @override
  String get tapToAddFirstTask =>
      'Tippe auf +, um deine erste Aufgabe hinzuzufügen';

  @override
  String get editTask => 'Aufgabe bearbeiten';

  @override
  String get addTask => 'Aufgabe hinzufügen';

  @override
  String get save => 'Speichern';

  @override
  String get title => 'Titel';

  @override
  String get titleRequired => 'Titel ist erforderlich';

  @override
  String get notesOptional => 'Notizen (optional)';

  @override
  String get remindMe => 'Erinnere mich';

  @override
  String get reminderChooseWhen => 'Wähle, wann du erinnert werden möchtest';

  @override
  String get reminderOptionCustom => 'Datum & Uhrzeit wählen';

  @override
  String get defaultTomorrowReminder => 'Morgen-Erinnerungszeit';

  @override
  String get defaultTomorrowReminderDescription =>
      'Standardzeit für die Schnelloption „Morgen“ beim Hinzufügen einer Erinnerung.';

  @override
  String get pickDateAndTime => 'Datum und Uhrzeit wählen';

  @override
  String get pickReminderDateAndTime =>
      'Datum und Uhrzeit für die Erinnerung wählen';

  @override
  String get reminderMustBeFuture =>
      'Die Erinnerung muss in der Zukunft liegen';

  @override
  String get deleteTask => 'Aufgabe löschen';

  @override
  String get deleteTaskQuestion => 'Aufgabe löschen?';

  @override
  String get deleteCannotBeUndone =>
      'Dies kann nicht rückgängig gemacht werden.';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get delete => 'Löschen';

  @override
  String removeTaskConfirm(String title) {
    return '\"$title\" entfernen?';
  }

  @override
  String get postponeOptions => 'Verschiebe-Optionen';

  @override
  String get postponeOptionsDescription =>
      'Diese erscheinen, wenn du eine Erinnerung verschiebst.';

  @override
  String get addPostponeOption => 'Verschiebe-Option hinzufügen';

  @override
  String get enableNotifications => 'Benachrichtigungen aktivieren';

  @override
  String get notificationPermissionsRequested =>
      'Benachrichtigungsberechtigungen angefordert';

  @override
  String minutesFromNowDescription(int count) {
    return '$count Minuten ab jetzt';
  }

  @override
  String hoursFromNowDescription(int count) {
    return '$count Stunde(n) ab jetzt';
  }

  @override
  String tomorrowAtDescription(String time) {
    return 'Morgen um $time';
  }

  @override
  String get deleteOptionQuestion => 'Option löschen?';

  @override
  String removeOptionConfirm(String label) {
    return '\"$label\" entfernen?';
  }

  @override
  String get addOption => 'Option hinzufügen';

  @override
  String get editOption => 'Option bearbeiten';

  @override
  String get label => 'Bezeichnung';

  @override
  String get type => 'Typ';

  @override
  String get minutesFromNowType => 'Minuten ab jetzt';

  @override
  String get hoursFromNowType => 'Stunden ab jetzt';

  @override
  String get tomorrowAtTimeType => 'Morgen zu einer Uhrzeit';

  @override
  String get minutes => 'Minuten';

  @override
  String get hours => 'Stunden';

  @override
  String get hourRange => 'Stunde (0-23)';

  @override
  String get minuteRange => 'Minute (0-59)';

  @override
  String get markDone => 'Als erledigt markieren';

  @override
  String get postpone => 'Verschieben';

  @override
  String get postponeFor => 'Verschieben um';

  @override
  String get pickTime => 'Uhrzeit wählen…';

  @override
  String reminderAt(String time) {
    return 'Erinnerung: $time';
  }

  @override
  String get preset15Minutes => '15 Minuten';

  @override
  String get preset1Hour => '1 Stunde';

  @override
  String get preset3Hours => '3 Stunden';

  @override
  String get presetTomorrowMorning => 'Morgen 9:00';

  @override
  String get language => 'Sprache';

  @override
  String get languageSystem => 'Systemstandard';

  @override
  String get languageEnglish => 'Englisch';

  @override
  String get languageSpanish => 'Spanisch';

  @override
  String get languageGerman => 'Deutsch';

  @override
  String get languageDutch => 'Niederländisch';

  @override
  String get languageFrench => 'Französisch';

  @override
  String get languageItalian => 'Italienisch';

  @override
  String get languageRussian => 'Russisch';

  @override
  String get languageUkrainian => 'Ukrainisch';

  @override
  String get languagePortuguese => 'Portugiesisch';

  @override
  String get appearance => 'Erscheinungsbild';

  @override
  String get themeSystem => 'Systemstandard';

  @override
  String get themeLight => 'Hell';

  @override
  String get themeDark => 'Dunkel';

  @override
  String get notificationChannelName => 'Aufgaben-Erinnerungen';

  @override
  String get notificationChannelDescription =>
      'Benachrichtigungen für Aufgaben-Erinnerungen';

  @override
  String get madeByRbdApps => 'Erstellt von RBD Apps';
}
