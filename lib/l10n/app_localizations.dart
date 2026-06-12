import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_it.dart';
import 'app_localizations_nl.dart';
import 'app_localizations_pt.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_uk.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('it'),
    Locale('nl'),
    Locale('pt'),
    Locale('ru'),
    Locale('uk'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Task reminder'**
  String get appTitle;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @active.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get active;

  /// No description provided for @finished.
  ///
  /// In en, this message translates to:
  /// **'Finished'**
  String get finished;

  /// No description provided for @taskGroupToday.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get taskGroupToday;

  /// No description provided for @taskGroupTomorrow.
  ///
  /// In en, this message translates to:
  /// **'Tomorrow'**
  String get taskGroupTomorrow;

  /// No description provided for @taskGroupUpcoming.
  ///
  /// In en, this message translates to:
  /// **'Upcoming'**
  String get taskGroupUpcoming;

  /// No description provided for @taskGroupNoReminder.
  ///
  /// In en, this message translates to:
  /// **'No reminder'**
  String get taskGroupNoReminder;

  /// No description provided for @completed.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get completed;

  /// No description provided for @noTasksYet.
  ///
  /// In en, this message translates to:
  /// **'No tasks yet'**
  String get noTasksYet;

  /// No description provided for @tapToAddFirstTask.
  ///
  /// In en, this message translates to:
  /// **'Tap + to add your first task'**
  String get tapToAddFirstTask;

  /// No description provided for @editTask.
  ///
  /// In en, this message translates to:
  /// **'Edit task'**
  String get editTask;

  /// No description provided for @addTask.
  ///
  /// In en, this message translates to:
  /// **'Add task'**
  String get addTask;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @title.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get title;

  /// No description provided for @titleRequired.
  ///
  /// In en, this message translates to:
  /// **'Title is required'**
  String get titleRequired;

  /// No description provided for @saveFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not save the task. Please try again.'**
  String get saveFailed;

  /// No description provided for @notesOptional.
  ///
  /// In en, this message translates to:
  /// **'Notes (optional)'**
  String get notesOptional;

  /// No description provided for @remindMe.
  ///
  /// In en, this message translates to:
  /// **'Remind me'**
  String get remindMe;

  /// No description provided for @reminderChooseWhen.
  ///
  /// In en, this message translates to:
  /// **'Choose when to remind you'**
  String get reminderChooseWhen;

  /// No description provided for @reminderOptionCustom.
  ///
  /// In en, this message translates to:
  /// **'Pick date & time'**
  String get reminderOptionCustom;

  /// No description provided for @defaultTomorrowReminder.
  ///
  /// In en, this message translates to:
  /// **'Tomorrow reminder time'**
  String get defaultTomorrowReminder;

  /// No description provided for @defaultTomorrowReminderDescription.
  ///
  /// In en, this message translates to:
  /// **'Default time for the quick tomorrow option when adding a reminder.'**
  String get defaultTomorrowReminderDescription;

  /// No description provided for @use24HourTime.
  ///
  /// In en, this message translates to:
  /// **'24-hour time'**
  String get use24HourTime;

  /// No description provided for @use24HourTimeDescription.
  ///
  /// In en, this message translates to:
  /// **'Use 24-hour format instead of AM/PM for time pickers and reminders.'**
  String get use24HourTimeDescription;

  /// No description provided for @pickDateAndTime.
  ///
  /// In en, this message translates to:
  /// **'Pick date and time'**
  String get pickDateAndTime;

  /// No description provided for @pickReminderDateAndTime.
  ///
  /// In en, this message translates to:
  /// **'Pick a reminder date and time'**
  String get pickReminderDateAndTime;

  /// No description provided for @reminderMustBeFuture.
  ///
  /// In en, this message translates to:
  /// **'Reminder must be in the future'**
  String get reminderMustBeFuture;

  /// No description provided for @deleteTask.
  ///
  /// In en, this message translates to:
  /// **'Delete task'**
  String get deleteTask;

  /// No description provided for @deleteTaskQuestion.
  ///
  /// In en, this message translates to:
  /// **'Delete task?'**
  String get deleteTaskQuestion;

  /// No description provided for @deleteCannotBeUndone.
  ///
  /// In en, this message translates to:
  /// **'This cannot be undone.'**
  String get deleteCannotBeUndone;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @removeTaskConfirm.
  ///
  /// In en, this message translates to:
  /// **'Remove \"{title}\"?'**
  String removeTaskConfirm(String title);

  /// No description provided for @postponeOptions.
  ///
  /// In en, this message translates to:
  /// **'Postpone options'**
  String get postponeOptions;

  /// No description provided for @postponeOptionsDescription.
  ///
  /// In en, this message translates to:
  /// **'These appear when you postpone a reminder.'**
  String get postponeOptionsDescription;

  /// No description provided for @addPostponeOption.
  ///
  /// In en, this message translates to:
  /// **'Add postpone option'**
  String get addPostponeOption;

  /// No description provided for @enableNotifications.
  ///
  /// In en, this message translates to:
  /// **'Enable notifications'**
  String get enableNotifications;

  /// No description provided for @notificationPermissionsRequested.
  ///
  /// In en, this message translates to:
  /// **'Notification permissions requested'**
  String get notificationPermissionsRequested;

  /// No description provided for @reminderPermissions.
  ///
  /// In en, this message translates to:
  /// **'Reminder permissions'**
  String get reminderPermissions;

  /// No description provided for @notificationsPermissionGranted.
  ///
  /// In en, this message translates to:
  /// **'Notifications allowed'**
  String get notificationsPermissionGranted;

  /// No description provided for @notificationsPermissionMissing.
  ///
  /// In en, this message translates to:
  /// **'Notifications not allowed'**
  String get notificationsPermissionMissing;

  /// No description provided for @exactAlarmsPermissionGranted.
  ///
  /// In en, this message translates to:
  /// **'Alarms & reminders allowed'**
  String get exactAlarmsPermissionGranted;

  /// No description provided for @exactAlarmsPermissionMissing.
  ///
  /// In en, this message translates to:
  /// **'Alarms & reminders not allowed'**
  String get exactAlarmsPermissionMissing;

  /// No description provided for @enableExactAlarms.
  ///
  /// In en, this message translates to:
  /// **'Allow alarms & reminders'**
  String get enableExactAlarms;

  /// No description provided for @remindersMayBeLate.
  ///
  /// In en, this message translates to:
  /// **'Reminders may be delayed until you allow Alarms & reminders in Settings.'**
  String get remindersMayBeLate;

  /// No description provided for @reminderScheduleFailed.
  ///
  /// In en, this message translates to:
  /// **'Reminder could not be scheduled. Check permissions in Settings.'**
  String get reminderScheduleFailed;

  /// No description provided for @batteryOptimizationDisabled.
  ///
  /// In en, this message translates to:
  /// **'Battery optimization disabled'**
  String get batteryOptimizationDisabled;

  /// No description provided for @batteryOptimizationEnabled.
  ///
  /// In en, this message translates to:
  /// **'Battery optimization active (may delay reminders)'**
  String get batteryOptimizationEnabled;

  /// No description provided for @disableBatteryOptimization.
  ///
  /// In en, this message translates to:
  /// **'Disable battery optimization'**
  String get disableBatteryOptimization;

  /// No description provided for @openAppBatterySettings.
  ///
  /// In en, this message translates to:
  /// **'Open app battery settings'**
  String get openAppBatterySettings;

  /// No description provided for @minutesFromNowDescription.
  ///
  /// In en, this message translates to:
  /// **'{count} minutes from now'**
  String minutesFromNowDescription(int count);

  /// No description provided for @hoursFromNowDescription.
  ///
  /// In en, this message translates to:
  /// **'{count} hour(s) from now'**
  String hoursFromNowDescription(int count);

  /// No description provided for @tomorrowAtDescription.
  ///
  /// In en, this message translates to:
  /// **'Tomorrow at {time}'**
  String tomorrowAtDescription(String time);

  /// No description provided for @deleteOptionQuestion.
  ///
  /// In en, this message translates to:
  /// **'Delete option?'**
  String get deleteOptionQuestion;

  /// No description provided for @removeOptionConfirm.
  ///
  /// In en, this message translates to:
  /// **'Remove \"{label}\"?'**
  String removeOptionConfirm(String label);

  /// No description provided for @addOption.
  ///
  /// In en, this message translates to:
  /// **'Add option'**
  String get addOption;

  /// No description provided for @editOption.
  ///
  /// In en, this message translates to:
  /// **'Edit option'**
  String get editOption;

  /// No description provided for @label.
  ///
  /// In en, this message translates to:
  /// **'Label'**
  String get label;

  /// No description provided for @type.
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get type;

  /// No description provided for @minutesFromNowType.
  ///
  /// In en, this message translates to:
  /// **'Minutes from now'**
  String get minutesFromNowType;

  /// No description provided for @hoursFromNowType.
  ///
  /// In en, this message translates to:
  /// **'Hours from now'**
  String get hoursFromNowType;

  /// No description provided for @tomorrowAtTimeType.
  ///
  /// In en, this message translates to:
  /// **'Tomorrow at time'**
  String get tomorrowAtTimeType;

  /// No description provided for @minutes.
  ///
  /// In en, this message translates to:
  /// **'Minutes'**
  String get minutes;

  /// No description provided for @hours.
  ///
  /// In en, this message translates to:
  /// **'Hours'**
  String get hours;

  /// No description provided for @hourRange.
  ///
  /// In en, this message translates to:
  /// **'Hour (0-23)'**
  String get hourRange;

  /// No description provided for @minuteRange.
  ///
  /// In en, this message translates to:
  /// **'Minute (0-59)'**
  String get minuteRange;

  /// No description provided for @markDone.
  ///
  /// In en, this message translates to:
  /// **'Mark done'**
  String get markDone;

  /// No description provided for @postpone.
  ///
  /// In en, this message translates to:
  /// **'Postpone'**
  String get postpone;

  /// No description provided for @postponeFor.
  ///
  /// In en, this message translates to:
  /// **'Postpone for'**
  String get postponeFor;

  /// No description provided for @pickTime.
  ///
  /// In en, this message translates to:
  /// **'Pick time…'**
  String get pickTime;

  /// No description provided for @reminderAt.
  ///
  /// In en, this message translates to:
  /// **'Reminder: {time}'**
  String reminderAt(String time);

  /// No description provided for @preset15Minutes.
  ///
  /// In en, this message translates to:
  /// **'15 minutes'**
  String get preset15Minutes;

  /// No description provided for @preset1Hour.
  ///
  /// In en, this message translates to:
  /// **'1 hour'**
  String get preset1Hour;

  /// No description provided for @preset3Hours.
  ///
  /// In en, this message translates to:
  /// **'3 hours'**
  String get preset3Hours;

  /// No description provided for @presetTomorrowMorning.
  ///
  /// In en, this message translates to:
  /// **'Tomorrow 9:00 AM'**
  String get presetTomorrowMorning;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @languageSystem.
  ///
  /// In en, this message translates to:
  /// **'System default'**
  String get languageSystem;

  /// No description provided for @languageEnglish.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get languageEnglish;

  /// No description provided for @languageSpanish.
  ///
  /// In en, this message translates to:
  /// **'Spanish'**
  String get languageSpanish;

  /// No description provided for @languageGerman.
  ///
  /// In en, this message translates to:
  /// **'German'**
  String get languageGerman;

  /// No description provided for @languageDutch.
  ///
  /// In en, this message translates to:
  /// **'Dutch'**
  String get languageDutch;

  /// No description provided for @languageFrench.
  ///
  /// In en, this message translates to:
  /// **'French'**
  String get languageFrench;

  /// No description provided for @languageItalian.
  ///
  /// In en, this message translates to:
  /// **'Italian'**
  String get languageItalian;

  /// No description provided for @languageRussian.
  ///
  /// In en, this message translates to:
  /// **'Russian'**
  String get languageRussian;

  /// No description provided for @languageUkrainian.
  ///
  /// In en, this message translates to:
  /// **'Ukrainian'**
  String get languageUkrainian;

  /// No description provided for @languagePortuguese.
  ///
  /// In en, this message translates to:
  /// **'Portuguese'**
  String get languagePortuguese;

  /// No description provided for @appearance.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get appearance;

  /// No description provided for @themeSystem.
  ///
  /// In en, this message translates to:
  /// **'System default'**
  String get themeSystem;

  /// No description provided for @themeLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get themeLight;

  /// No description provided for @themeDark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get themeDark;

  /// No description provided for @notificationChannelName.
  ///
  /// In en, this message translates to:
  /// **'Task reminders'**
  String get notificationChannelName;

  /// No description provided for @notificationChannelDescription.
  ///
  /// In en, this message translates to:
  /// **'Notifications for task reminders'**
  String get notificationChannelDescription;

  /// No description provided for @madeByRbdApps.
  ///
  /// In en, this message translates to:
  /// **'Made by RBD Apps'**
  String get madeByRbdApps;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'de',
    'en',
    'es',
    'fr',
    'it',
    'nl',
    'pt',
    'ru',
    'uk',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'it':
      return AppLocalizationsIt();
    case 'nl':
      return AppLocalizationsNl();
    case 'pt':
      return AppLocalizationsPt();
    case 'ru':
      return AppLocalizationsRu();
    case 'uk':
      return AppLocalizationsUk();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
