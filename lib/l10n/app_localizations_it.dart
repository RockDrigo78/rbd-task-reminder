// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get appTitle => 'Promemoria attività';

  @override
  String get settings => 'Impostazioni';

  @override
  String get active => 'Attive';

  @override
  String get completed => 'Completate';

  @override
  String get noTasksYet => 'Nessuna attività';

  @override
  String get tapToAddFirstTask =>
      'Tocca + per aggiungere la tua prima attività';

  @override
  String get editTask => 'Modifica attività';

  @override
  String get addTask => 'Aggiungi attività';

  @override
  String get save => 'Salva';

  @override
  String get title => 'Titolo';

  @override
  String get titleRequired => 'Il titolo è obbligatorio';

  @override
  String get notesOptional => 'Note (facoltativo)';

  @override
  String get remindMe => 'Ricordami';

  @override
  String get reminderChooseWhen => 'Scegli quando ricordarti';

  @override
  String get reminderOptionCustom => 'Scegli data e ora';

  @override
  String get defaultTomorrowReminder => 'Ora promemoria di domani';

  @override
  String get defaultTomorrowReminderDescription =>
      'Ora predefinita per l\'opzione rapida domani quando aggiungi un promemoria.';

  @override
  String get pickDateAndTime => 'Scegli data e ora';

  @override
  String get pickReminderDateAndTime => 'Scegli data e ora per il promemoria';

  @override
  String get reminderMustBeFuture => 'Il promemoria deve essere nel futuro';

  @override
  String get deleteTask => 'Elimina attività';

  @override
  String get deleteTaskQuestion => 'Eliminare l\'attività?';

  @override
  String get deleteCannotBeUndone => 'Questa azione non può essere annullata.';

  @override
  String get cancel => 'Annulla';

  @override
  String get delete => 'Elimina';

  @override
  String removeTaskConfirm(String title) {
    return 'Rimuovere \"$title\"?';
  }

  @override
  String get postponeOptions => 'Opzioni di posticipo';

  @override
  String get postponeOptionsDescription =>
      'Compaiono quando posticipi un promemoria.';

  @override
  String get addPostponeOption => 'Aggiungi opzione di posticipo';

  @override
  String get enableNotifications => 'Attiva notifiche';

  @override
  String get notificationPermissionsRequested =>
      'Permessi di notifica richiesti';

  @override
  String minutesFromNowDescription(int count) {
    return '$count minuti da adesso';
  }

  @override
  String hoursFromNowDescription(int count) {
    return '$count ora/e da adesso';
  }

  @override
  String tomorrowAtDescription(String time) {
    return 'Domani alle $time';
  }

  @override
  String get deleteOptionQuestion => 'Eliminare l\'opzione?';

  @override
  String removeOptionConfirm(String label) {
    return 'Rimuovere \"$label\"?';
  }

  @override
  String get addOption => 'Aggiungi opzione';

  @override
  String get editOption => 'Modifica opzione';

  @override
  String get label => 'Etichetta';

  @override
  String get type => 'Tipo';

  @override
  String get minutesFromNowType => 'Minuti da adesso';

  @override
  String get hoursFromNowType => 'Ore da adesso';

  @override
  String get tomorrowAtTimeType => 'Domani a un\'ora';

  @override
  String get minutes => 'Minuti';

  @override
  String get hours => 'Ore';

  @override
  String get hourRange => 'Ora (0-23)';

  @override
  String get minuteRange => 'Minuto (0-59)';

  @override
  String get markDone => 'Segna come fatto';

  @override
  String get postpone => 'Posticipa';

  @override
  String get postponeFor => 'Posticipa di';

  @override
  String get pickTime => 'Scegli ora…';

  @override
  String reminderAt(String time) {
    return 'Promemoria: $time';
  }

  @override
  String get preset15Minutes => '15 minuti';

  @override
  String get preset1Hour => '1 ora';

  @override
  String get preset3Hours => '3 ore';

  @override
  String get presetTomorrowMorning => 'Domani 9:00';

  @override
  String get language => 'Lingua';

  @override
  String get languageSystem => 'Predefinito di sistema';

  @override
  String get languageEnglish => 'Inglese';

  @override
  String get languageSpanish => 'Spagnolo';

  @override
  String get languageGerman => 'Tedesco';

  @override
  String get languageDutch => 'Olandese';

  @override
  String get languageFrench => 'Francese';

  @override
  String get languageItalian => 'Italiano';

  @override
  String get languageRussian => 'Russo';

  @override
  String get languageUkrainian => 'Ucraino';

  @override
  String get languagePortuguese => 'Portoghese';

  @override
  String get appearance => 'Aspetto';

  @override
  String get themeSystem => 'Predefinito di sistema';

  @override
  String get themeLight => 'Chiaro';

  @override
  String get themeDark => 'Scuro';

  @override
  String get notificationChannelName => 'Promemoria attività';

  @override
  String get notificationChannelDescription =>
      'Notifiche per i promemoria delle attività';

  @override
  String get madeByRbdApps => 'Creato da RBD Apps';
}
