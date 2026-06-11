import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

Future<TimeOfDay?> showConfiguredTimePicker({
  required BuildContext context,
  required TimeOfDay initialTime,
  required bool use24HourFormat,
}) {
  return showTimePicker(
    context: context,
    initialTime: initialTime,
    builder: (context, child) {
      final timePicker = MediaQuery(
        data: MediaQuery.of(context).copyWith(
          alwaysUse24HourFormat: use24HourFormat,
        ),
        child: child!,
      );

      if (use24HourFormat) {
        return timePicker;
      }

      return Localizations.override(
        context: context,
        locale: const Locale('en', 'US'),
        delegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        child: timePicker,
      );
    },
  );
}
