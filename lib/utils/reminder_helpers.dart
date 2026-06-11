import 'package:intl/intl.dart';

DateTime tomorrowReminderAt({
  required int hour,
  required int minute,
}) {
  final now = DateTime.now();
  var target = DateTime(now.year, now.month, now.day + 1, hour, minute);

  if (!target.isAfter(now)) {
    target = target.add(const Duration(days: 1));
  }

  return target;
}

String formatReminderClockTime({
  required int hour,
  required int minute,
  required String locale,
  required bool use24HourFormat,
}) {
  final sample = DateTime(2000, 1, 1, hour, minute);
  if (use24HourFormat) {
    return DateFormat('HH:mm', locale).format(sample);
  }
  return DateFormat('h:mm a', 'en_US').format(sample);
}

bool isSameReminderMinute(DateTime first, DateTime second) {
  return first.year == second.year &&
      first.month == second.month &&
      first.day == second.day &&
      first.hour == second.hour &&
      first.minute == second.minute;
}
