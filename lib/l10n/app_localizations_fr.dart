// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Rappel de tâches';

  @override
  String get settings => 'Paramètres';

  @override
  String get active => 'Actives';

  @override
  String get finished => 'Terminé';

  @override
  String get taskGroupToday => 'Aujourd\'hui';

  @override
  String get taskGroupTomorrow => 'Demain';

  @override
  String get taskGroupUpcoming => 'À venir';

  @override
  String get taskGroupNoReminder => 'Sans rappel';

  @override
  String get completed => 'Terminées';

  @override
  String get noTasksYet => 'Aucune tâche pour l\'instant';

  @override
  String get tapToAddFirstTask =>
      'Appuyez sur + pour ajouter votre première tâche';

  @override
  String get editTask => 'Modifier la tâche';

  @override
  String get addTask => 'Ajouter une tâche';

  @override
  String get save => 'Enregistrer';

  @override
  String get title => 'Titre';

  @override
  String get titleRequired => 'Le titre est obligatoire';

  @override
  String get saveFailed => 'Impossible d\'enregistrer la tâche. Réessayez.';

  @override
  String get notesOptional => 'Notes (facultatif)';

  @override
  String get remindMe => 'Me rappeler';

  @override
  String get reminderChooseWhen => 'Choisissez quand vous rappeler';

  @override
  String get reminderOptionCustom => 'Choisir date et heure';

  @override
  String get defaultTomorrowReminder => 'Heure du rappel demain';

  @override
  String get defaultTomorrowReminderDescription =>
      'Heure par défaut pour l\'option rapide demain lors de l\'ajout d\'un rappel.';

  @override
  String get use24HourTime => 'Format 24 heures';

  @override
  String get use24HourTimeDescription =>
      'Utiliser le format 24 heures au lieu de AM/PM pour les sélecteurs d\'heure et les rappels.';

  @override
  String get pickDateAndTime => 'Choisir la date et l\'heure';

  @override
  String get pickReminderDateAndTime =>
      'Choisissez une date et une heure pour le rappel';

  @override
  String get reminderMustBeFuture => 'Le rappel doit être dans le futur';

  @override
  String get deleteTask => 'Supprimer la tâche';

  @override
  String get deleteTaskQuestion => 'Supprimer la tâche ?';

  @override
  String get deleteCannotBeUndone => 'Cette action est irréversible.';

  @override
  String get cancel => 'Annuler';

  @override
  String get delete => 'Supprimer';

  @override
  String removeTaskConfirm(String title) {
    return 'Supprimer « $title » ?';
  }

  @override
  String get postponeOptions => 'Options de report';

  @override
  String get postponeOptionsDescription =>
      'Elles apparaissent lorsque vous reportez un rappel.';

  @override
  String get addPostponeOption => 'Ajouter une option de report';

  @override
  String get enableNotifications => 'Activer les notifications';

  @override
  String get notificationPermissionsRequested =>
      'Autorisations de notification demandées';

  @override
  String get reminderPermissions => 'Autorisations de rappel';

  @override
  String get notificationsPermissionGranted => 'Notifications autorisées';

  @override
  String get notificationsPermissionMissing => 'Notifications non autorisées';

  @override
  String get exactAlarmsPermissionGranted => 'Alarmes et rappels autorisés';

  @override
  String get exactAlarmsPermissionMissing => 'Alarmes et rappels non autorisés';

  @override
  String get enableExactAlarms => 'Autoriser alarmes et rappels';

  @override
  String get remindersMayBeLate =>
      'Les rappels peuvent être retardés tant que vous n\'autorisez pas Alarmes et rappels dans les réglages.';

  @override
  String get reminderScheduleFailed =>
      'Impossible de planifier le rappel. Vérifiez les autorisations dans Réglages.';

  @override
  String get batteryOptimizationDisabled => 'Optimisation batterie désactivée';

  @override
  String get batteryOptimizationEnabled =>
      'Optimisation batterie active (peut retarder les rappels)';

  @override
  String get disableBatteryOptimization =>
      'Désactiver l\'optimisation batterie';

  @override
  String get openAppBatterySettings => 'Ouvrir les réglages batterie de l\'app';

  @override
  String minutesFromNowDescription(int count) {
    return '$count minutes à partir de maintenant';
  }

  @override
  String hoursFromNowDescription(int count) {
    return '$count heure(s) à partir de maintenant';
  }

  @override
  String tomorrowAtDescription(String time) {
    return 'Demain à $time';
  }

  @override
  String get deleteOptionQuestion => 'Supprimer l\'option ?';

  @override
  String removeOptionConfirm(String label) {
    return 'Supprimer « $label » ?';
  }

  @override
  String get addOption => 'Ajouter une option';

  @override
  String get editOption => 'Modifier l\'option';

  @override
  String get label => 'Libellé';

  @override
  String get type => 'Type';

  @override
  String get minutesFromNowType => 'Minutes à partir de maintenant';

  @override
  String get hoursFromNowType => 'Heures à partir de maintenant';

  @override
  String get tomorrowAtTimeType => 'Demain à une heure';

  @override
  String get minutes => 'Minutes';

  @override
  String get hours => 'Heures';

  @override
  String get hourRange => 'Heure (0-23)';

  @override
  String get minuteRange => 'Minute (0-59)';

  @override
  String get markDone => 'Marquer comme fait';

  @override
  String get postpone => 'Reporter';

  @override
  String get postponeFor => 'Reporter de';

  @override
  String get pickTime => 'Choisir l\'heure…';

  @override
  String reminderAt(String time) {
    return 'Rappel : $time';
  }

  @override
  String get preset15Minutes => '15 minutes';

  @override
  String get preset1Hour => '1 heure';

  @override
  String get preset3Hours => '3 heures';

  @override
  String get presetTomorrowMorning => 'Demain 9:00';

  @override
  String get language => 'Langue';

  @override
  String get languageSystem => 'Par défaut du système';

  @override
  String get languageEnglish => 'Anglais';

  @override
  String get languageSpanish => 'Espagnol';

  @override
  String get languageGerman => 'Allemand';

  @override
  String get languageDutch => 'Néerlandais';

  @override
  String get languageFrench => 'Français';

  @override
  String get languageItalian => 'Italien';

  @override
  String get languageRussian => 'Russe';

  @override
  String get languageUkrainian => 'Ukrainien';

  @override
  String get languagePortuguese => 'Portugais';

  @override
  String get appearance => 'Apparence';

  @override
  String get themeSystem => 'Par défaut du système';

  @override
  String get themeLight => 'Clair';

  @override
  String get themeDark => 'Sombre';

  @override
  String get notificationChannelName => 'Rappels de tâches';

  @override
  String get notificationChannelDescription =>
      'Notifications pour les rappels de tâches';

  @override
  String get madeByRbdApps => 'Créé par RBD Apps';
}
