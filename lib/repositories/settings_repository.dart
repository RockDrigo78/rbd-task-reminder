import 'package:hive_flutter/hive_flutter.dart';

import '../models/app_settings.dart';

const String settingsBoxName = 'settings';
const String settingsKey = 'app_settings';

class SettingsRepository {
  Box<Map>? _box;

  Future<void> init() async {
    _box = await Hive.openBox<Map>(settingsBoxName);
  }

  AppSettings getSettings() {
    final box = _box;
    if (box == null) {
      return AppSettings.defaults();
    }

    final value = box.get(settingsKey);
    if (value == null) {
      return AppSettings.defaults();
    }

    return AppSettings.fromMap(value);
  }

  Future<void> saveSettings(AppSettings settings) async {
    await _box?.put(settingsKey, settings.toMap());
  }
}
