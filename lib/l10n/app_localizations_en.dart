// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Task reminder';

  @override
  String get settings => 'Settings';

  @override
  String get active => 'Active';

  @override
  String get completed => 'Completed';

  @override
  String get noTasksYet => 'No tasks yet';

  @override
  String get tapToAddFirstTask => 'Tap + to add your first task';

  @override
  String get editTask => 'Edit task';

  @override
  String get addTask => 'Add task';

  @override
  String get save => 'Save';

  @override
  String get title => 'Title';

  @override
  String get titleRequired => 'Title is required';

  @override
  String get notesOptional => 'Notes (optional)';

  @override
  String get remindMe => 'Remind me';

  @override
  String get reminderChooseWhen => 'Choose when to remind you';

  @override
  String get reminderOptionCustom => 'Pick date & time';

  @override
  String get defaultTomorrowReminder => 'Tomorrow reminder time';

  @override
  String get defaultTomorrowReminderDescription =>
      'Default time for the quick tomorrow option when adding a reminder.';

  @override
  String get pickDateAndTime => 'Pick date and time';

  @override
  String get pickReminderDateAndTime => 'Pick a reminder date and time';

  @override
  String get reminderMustBeFuture => 'Reminder must be in the future';

  @override
  String get deleteTask => 'Delete task';

  @override
  String get deleteTaskQuestion => 'Delete task?';

  @override
  String get deleteCannotBeUndone => 'This cannot be undone.';

  @override
  String get cancel => 'Cancel';

  @override
  String get delete => 'Delete';

  @override
  String removeTaskConfirm(String title) {
    return 'Remove \"$title\"?';
  }

  @override
  String get postponeOptions => 'Postpone options';

  @override
  String get postponeOptionsDescription =>
      'These appear when you postpone a reminder.';

  @override
  String get addPostponeOption => 'Add postpone option';

  @override
  String get enableNotifications => 'Enable notifications';

  @override
  String get notificationPermissionsRequested =>
      'Notification permissions requested';

  @override
  String minutesFromNowDescription(int count) {
    return '$count minutes from now';
  }

  @override
  String hoursFromNowDescription(int count) {
    return '$count hour(s) from now';
  }

  @override
  String tomorrowAtDescription(String time) {
    return 'Tomorrow at $time';
  }

  @override
  String get deleteOptionQuestion => 'Delete option?';

  @override
  String removeOptionConfirm(String label) {
    return 'Remove \"$label\"?';
  }

  @override
  String get addOption => 'Add option';

  @override
  String get editOption => 'Edit option';

  @override
  String get label => 'Label';

  @override
  String get type => 'Type';

  @override
  String get minutesFromNowType => 'Minutes from now';

  @override
  String get hoursFromNowType => 'Hours from now';

  @override
  String get tomorrowAtTimeType => 'Tomorrow at time';

  @override
  String get minutes => 'Minutes';

  @override
  String get hours => 'Hours';

  @override
  String get hourRange => 'Hour (0-23)';

  @override
  String get minuteRange => 'Minute (0-59)';

  @override
  String get markDone => 'Mark done';

  @override
  String get postpone => 'Postpone';

  @override
  String get postponeFor => 'Postpone for';

  @override
  String get pickTime => 'Pick time…';

  @override
  String reminderAt(String time) {
    return 'Reminder: $time';
  }

  @override
  String get preset15Minutes => '15 minutes';

  @override
  String get preset1Hour => '1 hour';

  @override
  String get preset3Hours => '3 hours';

  @override
  String get presetTomorrowMorning => 'Tomorrow 9:00 AM';

  @override
  String get language => 'Language';

  @override
  String get languageSystem => 'System default';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageSpanish => 'Spanish';

  @override
  String get languageGerman => 'German';

  @override
  String get languageDutch => 'Dutch';

  @override
  String get languageFrench => 'French';

  @override
  String get languageItalian => 'Italian';

  @override
  String get languageRussian => 'Russian';

  @override
  String get languageUkrainian => 'Ukrainian';

  @override
  String get languagePortuguese => 'Portuguese';

  @override
  String get appearance => 'Appearance';

  @override
  String get themeSystem => 'System default';

  @override
  String get themeLight => 'Light';

  @override
  String get themeDark => 'Dark';

  @override
  String get notificationChannelName => 'Task reminders';

  @override
  String get notificationChannelDescription =>
      'Notifications for task reminders';

  @override
  String get madeByRbdApps => 'Made by RBD Apps';
}
