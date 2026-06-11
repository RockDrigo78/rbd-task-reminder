// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'Напоминание о задачах';

  @override
  String get settings => 'Настройки';

  @override
  String get active => 'Активные';

  @override
  String get completed => 'Выполненные';

  @override
  String get noTasksYet => 'Задач пока нет';

  @override
  String get tapToAddFirstTask => 'Нажмите +, чтобы добавить первую задачу';

  @override
  String get editTask => 'Редактировать задачу';

  @override
  String get addTask => 'Добавить задачу';

  @override
  String get save => 'Сохранить';

  @override
  String get title => 'Название';

  @override
  String get titleRequired => 'Название обязательно';

  @override
  String get notesOptional => 'Заметки (необязательно)';

  @override
  String get remindMe => 'Напомнить';

  @override
  String get reminderChooseWhen => 'Выберите, когда напомнить';

  @override
  String get reminderOptionCustom => 'Выбрать дату и время';

  @override
  String get defaultTomorrowReminder => 'Время напоминания на завтра';

  @override
  String get defaultTomorrowReminderDescription =>
      'Время по умолчанию для быстрого варианта «завтра» при добавлении напоминания.';

  @override
  String get pickDateAndTime => 'Выберите дату и время';

  @override
  String get pickReminderDateAndTime => 'Выберите дату и время напоминания';

  @override
  String get reminderMustBeFuture => 'Напоминание должно быть в будущем';

  @override
  String get deleteTask => 'Удалить задачу';

  @override
  String get deleteTaskQuestion => 'Удалить задачу?';

  @override
  String get deleteCannotBeUndone => 'Это действие нельзя отменить.';

  @override
  String get cancel => 'Отмена';

  @override
  String get delete => 'Удалить';

  @override
  String removeTaskConfirm(String title) {
    return 'Удалить «$title»?';
  }

  @override
  String get postponeOptions => 'Варианты отложения';

  @override
  String get postponeOptionsDescription =>
      'Появляются при отложении напоминания.';

  @override
  String get addPostponeOption => 'Добавить вариант отложения';

  @override
  String get enableNotifications => 'Включить уведомления';

  @override
  String get notificationPermissionsRequested =>
      'Запрошены разрешения на уведомления';

  @override
  String minutesFromNowDescription(int count) {
    return '$count мин. от сейчас';
  }

  @override
  String hoursFromNowDescription(int count) {
    return '$count ч. от сейчас';
  }

  @override
  String tomorrowAtDescription(String time) {
    return 'Завтра в $time';
  }

  @override
  String get deleteOptionQuestion => 'Удалить вариант?';

  @override
  String removeOptionConfirm(String label) {
    return 'Удалить «$label»?';
  }

  @override
  String get addOption => 'Добавить вариант';

  @override
  String get editOption => 'Редактировать вариант';

  @override
  String get label => 'Метка';

  @override
  String get type => 'Тип';

  @override
  String get minutesFromNowType => 'Минут от сейчас';

  @override
  String get hoursFromNowType => 'Часов от сейчас';

  @override
  String get tomorrowAtTimeType => 'Завтра в указанное время';

  @override
  String get minutes => 'Минуты';

  @override
  String get hours => 'Часы';

  @override
  String get hourRange => 'Час (0-23)';

  @override
  String get minuteRange => 'Минута (0-59)';

  @override
  String get markDone => 'Отметить выполненным';

  @override
  String get postpone => 'Отложить';

  @override
  String get postponeFor => 'Отложить на';

  @override
  String get pickTime => 'Выбрать время…';

  @override
  String reminderAt(String time) {
    return 'Напоминание: $time';
  }

  @override
  String get preset15Minutes => '15 минут';

  @override
  String get preset1Hour => '1 час';

  @override
  String get preset3Hours => '3 часа';

  @override
  String get presetTomorrowMorning => 'Завтра 9:00';

  @override
  String get language => 'Язык';

  @override
  String get languageSystem => 'Системный по умолчанию';

  @override
  String get languageEnglish => 'Английский';

  @override
  String get languageSpanish => 'Испанский';

  @override
  String get languageGerman => 'Немецкий';

  @override
  String get languageDutch => 'Нидерландский';

  @override
  String get languageFrench => 'Французский';

  @override
  String get languageItalian => 'Итальянский';

  @override
  String get languageRussian => 'Русский';

  @override
  String get languageUkrainian => 'Украинский';

  @override
  String get languagePortuguese => 'Португальский';

  @override
  String get appearance => 'Оформление';

  @override
  String get themeSystem => 'Системная тема';

  @override
  String get themeLight => 'Светлая';

  @override
  String get themeDark => 'Тёмная';

  @override
  String get notificationChannelName => 'Напоминания о задачах';

  @override
  String get notificationChannelDescription =>
      'Уведомления о напоминаниях задач';

  @override
  String get madeByRbdApps => 'Сделано RBD Apps';
}
