class ReminderPermissionStatus {
  const ReminderPermissionStatus({
    required this.notificationsEnabled,
    required this.exactAlarmsEnabled,
    required this.batteryOptimizationDisabled,
  });

  final bool notificationsEnabled;
  final bool exactAlarmsEnabled;
  final bool batteryOptimizationDisabled;

  bool get isReliable =>
      notificationsEnabled &&
      exactAlarmsEnabled &&
      batteryOptimizationDisabled;
}
