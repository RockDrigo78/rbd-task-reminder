enum PostponePresetType {
  minutes,
  hours,
  tomorrowAt,
}

class PostponePreset {
  const PostponePreset({
    required this.id,
    required this.label,
    required this.type,
    this.amount,
    this.hour,
    this.minute,
  });

  final String id;
  final String label;
  final PostponePresetType type;
  final int? amount;
  final int? hour;
  final int? minute;

  DateTime resolveTarget(DateTime from) {
    switch (type) {
      case PostponePresetType.minutes:
        return from.add(Duration(minutes: amount ?? 0));
      case PostponePresetType.hours:
        return from.add(Duration(hours: amount ?? 0));
      case PostponePresetType.tomorrowAt:
        final tomorrow = DateTime(from.year, from.month, from.day + 1);
        return DateTime(
          tomorrow.year,
          tomorrow.month,
          tomorrow.day,
          hour ?? 9,
          minute ?? 0,
        );
    }
  }

  PostponePreset copyWith({
    String? id,
    String? label,
    PostponePresetType? type,
    int? amount,
    int? hour,
    int? minute,
  }) {
    return PostponePreset(
      id: id ?? this.id,
      label: label ?? this.label,
      type: type ?? this.type,
      amount: amount ?? this.amount,
      hour: hour ?? this.hour,
      minute: minute ?? this.minute,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'label': label,
      'type': type.index,
      'amount': amount,
      'hour': hour,
      'minute': minute,
    };
  }

  factory PostponePreset.fromMap(Map<dynamic, dynamic> map) {
    return PostponePreset(
      id: map['id'] as String,
      label: map['label'] as String,
      type: PostponePresetType.values[map['type'] as int],
      amount: map['amount'] as int?,
      hour: map['hour'] as int?,
      minute: map['minute'] as int?,
    );
  }

  static List<PostponePreset> defaultPresets() {
    return [
      PostponePreset(
        id: 'preset-15m',
        label: '15 minutes',
        type: PostponePresetType.minutes,
        amount: 15,
      ),
      PostponePreset(
        id: 'preset-1h',
        label: '1 hour',
        type: PostponePresetType.hours,
        amount: 1,
      ),
      PostponePreset(
        id: 'preset-3h',
        label: '3 hours',
        type: PostponePresetType.hours,
        amount: 3,
      ),
      PostponePreset(
        id: 'preset-tomorrow',
        label: 'Tomorrow 9:00 AM',
        type: PostponePresetType.tomorrowAt,
        hour: 9,
        minute: 0,
      ),
    ];
  }
}
