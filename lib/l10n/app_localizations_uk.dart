// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Ukrainian (`uk`).
class AppLocalizationsUk extends AppLocalizations {
  AppLocalizationsUk([String locale = 'uk']) : super(locale);

  @override
  String get appTitle => 'Нагадування про задачі';

  @override
  String get settings => 'Налаштування';

  @override
  String get active => 'Активні';

  @override
  String get finished => 'Завершено';

  @override
  String get taskGroupToday => 'Сьогодні';

  @override
  String get taskGroupTomorrow => 'Завтра';

  @override
  String get taskGroupUpcoming => 'Майбутні';

  @override
  String get taskGroupNoReminder => 'Без нагадування';

  @override
  String get completed => 'Виконані';

  @override
  String get noTasksYet => 'Задач поки немає';

  @override
  String get tapToAddFirstTask => 'Натисніть +, щоб додати першу задачу';

  @override
  String get editTask => 'Редагувати задачу';

  @override
  String get addTask => 'Додати задачу';

  @override
  String get save => 'Зберегти';

  @override
  String get title => 'Назва';

  @override
  String get titleRequired => 'Назва обов\'язкова';

  @override
  String get saveFailed => 'Не вдалося зберегти завдання. Спробуйте ще раз.';

  @override
  String get notesOptional => 'Нотатки (необов\'язково)';

  @override
  String get remindMe => 'Нагадати';

  @override
  String get reminderChooseWhen => 'Оберіть, коли нагадати';

  @override
  String get reminderOptionCustom => 'Обрати дату та час';

  @override
  String get defaultTomorrowReminder => 'Час нагадування на завтра';

  @override
  String get defaultTomorrowReminderDescription =>
      'Час за замовчуванням для швидкого варіанту «завтра» під час додавання нагадування.';

  @override
  String get use24HourTime => '24-годинний формат';

  @override
  String get use24HourTimeDescription =>
      'Використовувати 24-годинний формат замість AM/PM для вибору часу та нагадувань.';

  @override
  String get pickDateAndTime => 'Оберіть дату та час';

  @override
  String get pickReminderDateAndTime => 'Оберіть дату та час нагадування';

  @override
  String get reminderMustBeFuture => 'Нагадування має бути в майбутньому';

  @override
  String get deleteTask => 'Видалити задачу';

  @override
  String get deleteTaskQuestion => 'Видалити задачу?';

  @override
  String get deleteCannotBeUndone => 'Цю дію не можна скасувати.';

  @override
  String get cancel => 'Скасувати';

  @override
  String get delete => 'Видалити';

  @override
  String removeTaskConfirm(String title) {
    return 'Видалити «$title»?';
  }

  @override
  String get postponeOptions => 'Варіанти відкладення';

  @override
  String get postponeOptionsDescription =>
      'З\'являються, коли ви відкладаєте нагадування.';

  @override
  String get addPostponeOption => 'Додати варіант відкладення';

  @override
  String get enableNotifications => 'Увімкнути сповіщення';

  @override
  String get notificationPermissionsRequested =>
      'Запитано дозволи на сповіщення';

  @override
  String get reminderPermissions => 'Дозволи для нагадувань';

  @override
  String get notificationsPermissionGranted => 'Сповіщення дозволено';

  @override
  String get notificationsPermissionMissing => 'Сповіщення не дозволено';

  @override
  String get exactAlarmsPermissionGranted =>
      'Будильники та нагадування дозволено';

  @override
  String get exactAlarmsPermissionMissing =>
      'Будильники та нагадування не дозволено';

  @override
  String get enableExactAlarms => 'Дозволити будильники та нагадування';

  @override
  String get remindersMayBeLate =>
      'Нагадування можуть запізнюватися, доки ви не дозволите «Будильники та нагадування» в налаштуваннях.';

  @override
  String get reminderScheduleFailed =>
      'Не вдалося запланувати нагадування. Перевірте дозволи в налаштуваннях.';

  @override
  String get batteryOptimizationDisabled => 'Оптимізацію батареї вимкнено';

  @override
  String get batteryOptimizationEnabled =>
      'Оптимізація батареї активна (може затримувати нагадування)';

  @override
  String get disableBatteryOptimization => 'Вимкнути оптимізацію батареї';

  @override
  String get openAppBatterySettings =>
      'Відкрити налаштування батареї застосунку';

  @override
  String minutesFromNowDescription(int count) {
    return '$count хв. від зараз';
  }

  @override
  String hoursFromNowDescription(int count) {
    return '$count год. від зараз';
  }

  @override
  String tomorrowAtDescription(String time) {
    return 'Завтра о $time';
  }

  @override
  String get deleteOptionQuestion => 'Видалити варіант?';

  @override
  String removeOptionConfirm(String label) {
    return 'Видалити «$label»?';
  }

  @override
  String get addOption => 'Додати варіант';

  @override
  String get editOption => 'Редагувати варіант';

  @override
  String get label => 'Мітка';

  @override
  String get type => 'Тип';

  @override
  String get minutesFromNowType => 'Хвилин від зараз';

  @override
  String get hoursFromNowType => 'Годин від зараз';

  @override
  String get tomorrowAtTimeType => 'Завтра о вказаний час';

  @override
  String get minutes => 'Хвилини';

  @override
  String get hours => 'Години';

  @override
  String get hourRange => 'Година (0-23)';

  @override
  String get minuteRange => 'Хвилина (0-59)';

  @override
  String get markDone => 'Позначити виконаним';

  @override
  String get postpone => 'Відкласти';

  @override
  String get postponeFor => 'Відкласти на';

  @override
  String get pickTime => 'Обрати час…';

  @override
  String reminderAt(String time) {
    return 'Нагадування: $time';
  }

  @override
  String get preset15Minutes => '15 хвилин';

  @override
  String get preset1Hour => '1 година';

  @override
  String get preset3Hours => '3 години';

  @override
  String get presetTomorrowMorning => 'Завтра 9:00';

  @override
  String get language => 'Мова';

  @override
  String get languageSystem => 'Системна за замовчуванням';

  @override
  String get languageEnglish => 'Англійська';

  @override
  String get languageSpanish => 'Іспанська';

  @override
  String get languageGerman => 'Німецька';

  @override
  String get languageDutch => 'Нідерландська';

  @override
  String get languageFrench => 'Французька';

  @override
  String get languageItalian => 'Італійська';

  @override
  String get languageRussian => 'Російська';

  @override
  String get languageUkrainian => 'Українська';

  @override
  String get languagePortuguese => 'Португальська';

  @override
  String get appearance => 'Зовнішній вигляд';

  @override
  String get themeSystem => 'Системна тема';

  @override
  String get themeLight => 'Світла';

  @override
  String get themeDark => 'Темна';

  @override
  String get notificationChannelName => 'Нагадування про задачі';

  @override
  String get notificationChannelDescription =>
      'Сповіщення про нагадування задач';

  @override
  String get madeByRbdApps => 'Зроблено RBD Apps';
}
