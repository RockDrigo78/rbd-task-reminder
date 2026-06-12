// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appTitle => 'Lembrete de tarefas';

  @override
  String get settings => 'Definições';

  @override
  String get active => 'Ativas';

  @override
  String get finished => 'Concluído';

  @override
  String get taskGroupToday => 'Hoje';

  @override
  String get taskGroupTomorrow => 'Amanhã';

  @override
  String get taskGroupUpcoming => 'Próximas';

  @override
  String get taskGroupNoReminder => 'Sem lembrete';

  @override
  String get completed => 'Concluídas';

  @override
  String get noTasksYet => 'Ainda não há tarefas';

  @override
  String get tapToAddFirstTask =>
      'Toque em + para adicionar a sua primeira tarefa';

  @override
  String get editTask => 'Editar tarefa';

  @override
  String get addTask => 'Adicionar tarefa';

  @override
  String get save => 'Guardar';

  @override
  String get title => 'Título';

  @override
  String get titleRequired => 'O título é obrigatório';

  @override
  String get saveFailed =>
      'Não foi possível guardar a tarefa. Tente novamente.';

  @override
  String get notesOptional => 'Notas (opcional)';

  @override
  String get remindMe => 'Lembrar-me';

  @override
  String get reminderChooseWhen => 'Escolha quando ser lembrado';

  @override
  String get reminderOptionCustom => 'Escolher data e hora';

  @override
  String get defaultTomorrowReminder => 'Hora do lembrete de amanhã';

  @override
  String get defaultTomorrowReminderDescription =>
      'Hora predefinida para a opção rápida amanhã ao adicionar um lembrete.';

  @override
  String get use24HourTime => 'Formato 24 horas';

  @override
  String get use24HourTimeDescription =>
      'Usar formato de 24 horas em vez de AM/PM para horas e lembretes.';

  @override
  String get pickDateAndTime => 'Escolher data e hora';

  @override
  String get pickReminderDateAndTime =>
      'Escolha uma data e hora para o lembrete';

  @override
  String get reminderMustBeFuture => 'O lembrete deve ser no futuro';

  @override
  String get deleteTask => 'Eliminar tarefa';

  @override
  String get deleteTaskQuestion => 'Eliminar tarefa?';

  @override
  String get deleteCannotBeUndone => 'Esta ação não pode ser desfeita.';

  @override
  String get cancel => 'Cancelar';

  @override
  String get delete => 'Eliminar';

  @override
  String removeTaskConfirm(String title) {
    return 'Remover \"$title\"?';
  }

  @override
  String get postponeOptions => 'Opções de adiamento';

  @override
  String get postponeOptionsDescription => 'Aparecem quando adia um lembrete.';

  @override
  String get addPostponeOption => 'Adicionar opção de adiamento';

  @override
  String get enableNotifications => 'Ativar notificações';

  @override
  String get notificationPermissionsRequested =>
      'Permissões de notificação solicitadas';

  @override
  String get reminderPermissions => 'Permissões de lembrete';

  @override
  String get notificationsPermissionGranted => 'Notificações permitidas';

  @override
  String get notificationsPermissionMissing => 'Notificações não permitidas';

  @override
  String get exactAlarmsPermissionGranted => 'Alarmes e lembretes permitidos';

  @override
  String get exactAlarmsPermissionMissing =>
      'Alarmes e lembretes não permitidos';

  @override
  String get enableExactAlarms => 'Permitir alarmes e lembretes';

  @override
  String get remindersMayBeLate =>
      'Os lembretes podem atrasar-se até permitir Alarmes e lembretes nas Definições.';

  @override
  String get reminderScheduleFailed =>
      'Não foi possível agendar o lembrete. Verifique as permissões em Definições.';

  @override
  String get batteryOptimizationDisabled => 'Otimização de bateria desativada';

  @override
  String get batteryOptimizationEnabled =>
      'Otimização de bateria ativa (pode atrasar lembretes)';

  @override
  String get disableBatteryOptimization => 'Desativar otimização de bateria';

  @override
  String get openAppBatterySettings => 'Abrir definições de bateria da app';

  @override
  String minutesFromNowDescription(int count) {
    return '$count minutos a partir de agora';
  }

  @override
  String hoursFromNowDescription(int count) {
    return '$count hora(s) a partir de agora';
  }

  @override
  String tomorrowAtDescription(String time) {
    return 'Amanhã às $time';
  }

  @override
  String get deleteOptionQuestion => 'Eliminar opção?';

  @override
  String removeOptionConfirm(String label) {
    return 'Remover \"$label\"?';
  }

  @override
  String get addOption => 'Adicionar opção';

  @override
  String get editOption => 'Editar opção';

  @override
  String get label => 'Etiqueta';

  @override
  String get type => 'Tipo';

  @override
  String get minutesFromNowType => 'Minutos a partir de agora';

  @override
  String get hoursFromNowType => 'Horas a partir de agora';

  @override
  String get tomorrowAtTimeType => 'Amanhã a uma hora';

  @override
  String get minutes => 'Minutos';

  @override
  String get hours => 'Horas';

  @override
  String get hourRange => 'Hora (0-23)';

  @override
  String get minuteRange => 'Minuto (0-59)';

  @override
  String get markDone => 'Marcar como feito';

  @override
  String get postpone => 'Adiar';

  @override
  String get postponeFor => 'Adiar por';

  @override
  String get pickTime => 'Escolher hora…';

  @override
  String reminderAt(String time) {
    return 'Lembrete: $time';
  }

  @override
  String get preset15Minutes => '15 minutos';

  @override
  String get preset1Hour => '1 hora';

  @override
  String get preset3Hours => '3 horas';

  @override
  String get presetTomorrowMorning => 'Amanhã 9:00';

  @override
  String get language => 'Idioma';

  @override
  String get languageSystem => 'Predefinição do sistema';

  @override
  String get languageEnglish => 'Inglês';

  @override
  String get languageSpanish => 'Espanhol';

  @override
  String get languageGerman => 'Alemão';

  @override
  String get languageDutch => 'Neerlandês';

  @override
  String get languageFrench => 'Francês';

  @override
  String get languageItalian => 'Italiano';

  @override
  String get languageRussian => 'Russo';

  @override
  String get languageUkrainian => 'Ucraniano';

  @override
  String get languagePortuguese => 'Português';

  @override
  String get appearance => 'Aparência';

  @override
  String get themeSystem => 'Predefinição do sistema';

  @override
  String get themeLight => 'Claro';

  @override
  String get themeDark => 'Escuro';

  @override
  String get notificationChannelName => 'Lembretes de tarefas';

  @override
  String get notificationChannelDescription =>
      'Notificações para lembretes de tarefas';

  @override
  String get madeByRbdApps => 'Feito por RBD Apps';
}
