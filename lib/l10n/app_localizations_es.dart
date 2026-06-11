// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Recordatorio de tareas';

  @override
  String get settings => 'Ajustes';

  @override
  String get active => 'Activas';

  @override
  String get finished => 'Finalizado';

  @override
  String get taskGroupToday => 'Hoy';

  @override
  String get taskGroupTomorrow => 'Mañana';

  @override
  String get taskGroupUpcoming => 'Próximas';

  @override
  String get taskGroupNoReminder => 'Sin recordatorio';

  @override
  String get completed => 'Completadas';

  @override
  String get noTasksYet => 'Aún no hay tareas';

  @override
  String get tapToAddFirstTask => 'Toca + para añadir tu primera tarea';

  @override
  String get editTask => 'Editar tarea';

  @override
  String get addTask => 'Añadir tarea';

  @override
  String get save => 'Guardar';

  @override
  String get title => 'Título';

  @override
  String get titleRequired => 'El título es obligatorio';

  @override
  String get saveFailed => 'No se pudo guardar la tarea. Inténtalo de nuevo.';

  @override
  String get notesOptional => 'Notas (opcional)';

  @override
  String get remindMe => 'Recordarme';

  @override
  String get reminderChooseWhen => 'Elige cuándo recordarte';

  @override
  String get reminderOptionCustom => 'Elegir fecha y hora';

  @override
  String get defaultTomorrowReminder => 'Hora del recordatorio de mañana';

  @override
  String get defaultTomorrowReminderDescription =>
      'Hora predeterminada para la opción rápida de mañana al añadir un recordatorio.';

  @override
  String get use24HourTime => 'Formato 24 horas';

  @override
  String get use24HourTimeDescription =>
      'Usar formato de 24 horas en lugar de AM/PM para horas y recordatorios.';

  @override
  String get pickDateAndTime => 'Elegir fecha y hora';

  @override
  String get pickReminderDateAndTime =>
      'Elige una fecha y hora para el recordatorio';

  @override
  String get reminderMustBeFuture => 'El recordatorio debe ser en el futuro';

  @override
  String get deleteTask => 'Eliminar tarea';

  @override
  String get deleteTaskQuestion => '¿Eliminar tarea?';

  @override
  String get deleteCannotBeUndone => 'Esta acción no se puede deshacer.';

  @override
  String get cancel => 'Cancelar';

  @override
  String get delete => 'Eliminar';

  @override
  String removeTaskConfirm(String title) {
    return '¿Eliminar \"$title\"?';
  }

  @override
  String get postponeOptions => 'Opciones de posponer';

  @override
  String get postponeOptionsDescription =>
      'Aparecen cuando pospones un recordatorio.';

  @override
  String get addPostponeOption => 'Añadir opción de posponer';

  @override
  String get enableNotifications => 'Activar notificaciones';

  @override
  String get notificationPermissionsRequested =>
      'Permisos de notificación solicitados';

  @override
  String minutesFromNowDescription(int count) {
    return '$count minutos desde ahora';
  }

  @override
  String hoursFromNowDescription(int count) {
    return '$count hora(s) desde ahora';
  }

  @override
  String tomorrowAtDescription(String time) {
    return 'Mañana a las $time';
  }

  @override
  String get deleteOptionQuestion => '¿Eliminar opción?';

  @override
  String removeOptionConfirm(String label) {
    return '¿Eliminar \"$label\"?';
  }

  @override
  String get addOption => 'Añadir opción';

  @override
  String get editOption => 'Editar opción';

  @override
  String get label => 'Etiqueta';

  @override
  String get type => 'Tipo';

  @override
  String get minutesFromNowType => 'Minutos desde ahora';

  @override
  String get hoursFromNowType => 'Horas desde ahora';

  @override
  String get tomorrowAtTimeType => 'Mañana a una hora';

  @override
  String get minutes => 'Minutos';

  @override
  String get hours => 'Horas';

  @override
  String get hourRange => 'Hora (0-23)';

  @override
  String get minuteRange => 'Minuto (0-59)';

  @override
  String get markDone => 'Marcar hecho';

  @override
  String get postpone => 'Posponer';

  @override
  String get postponeFor => 'Posponer por';

  @override
  String get pickTime => 'Elegir hora…';

  @override
  String reminderAt(String time) {
    return 'Recordatorio: $time';
  }

  @override
  String get preset15Minutes => '15 minutos';

  @override
  String get preset1Hour => '1 hora';

  @override
  String get preset3Hours => '3 horas';

  @override
  String get presetTomorrowMorning => 'Mañana 9:00';

  @override
  String get language => 'Idioma';

  @override
  String get languageSystem => 'Predeterminado del sistema';

  @override
  String get languageEnglish => 'Inglés';

  @override
  String get languageSpanish => 'Español';

  @override
  String get languageGerman => 'Alemán';

  @override
  String get languageDutch => 'Neerlandés';

  @override
  String get languageFrench => 'Francés';

  @override
  String get languageItalian => 'Italiano';

  @override
  String get languageRussian => 'Ruso';

  @override
  String get languageUkrainian => 'Ucraniano';

  @override
  String get languagePortuguese => 'Portugués';

  @override
  String get appearance => 'Apariencia';

  @override
  String get themeSystem => 'Predeterminado del sistema';

  @override
  String get themeLight => 'Claro';

  @override
  String get themeDark => 'Oscuro';

  @override
  String get notificationChannelName => 'Recordatorios de tareas';

  @override
  String get notificationChannelDescription =>
      'Notificaciones para recordatorios de tareas';

  @override
  String get madeByRbdApps => 'Hecho por RBD Apps';
}
