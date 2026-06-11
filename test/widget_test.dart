import 'package:flutter_test/flutter_test.dart';
import 'package:task_reminder/models/postpone_preset.dart';

void main() {
  test('minutes preset resolves from a base time', () {
    final preset = PostponePreset.defaultPresets().first;
    final baseTime = DateTime(2026, 6, 11, 12, 0);
    final target = preset.resolveTarget(baseTime);

    expect(target, DateTime(2026, 6, 11, 12, 15));
  });

  test('tomorrow preset resolves to next day at configured time', () {
    final preset = PostponePreset.defaultPresets().last;
    final baseTime = DateTime(2026, 6, 11, 22, 0);
    final target = preset.resolveTarget(baseTime);

    expect(target, DateTime(2026, 6, 12, 9, 0));
  });
}
