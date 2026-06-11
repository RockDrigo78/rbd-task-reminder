class Todo {
  const Todo({
    required this.id,
    required this.title,
    this.notes = '',
    this.isCompleted = false,
    this.reminderAt,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final String title;
  final String notes;
  final bool isCompleted;
  final DateTime? reminderAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  Todo copyWith({
    String? id,
    String? title,
    String? notes,
    bool? isCompleted,
    DateTime? reminderAt,
    bool clearReminder = false,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Todo(
      id: id ?? this.id,
      title: title ?? this.title,
      notes: notes ?? this.notes,
      isCompleted: isCompleted ?? this.isCompleted,
      reminderAt: clearReminder ? null : (reminderAt ?? this.reminderAt),
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'notes': notes,
      'isCompleted': isCompleted,
      'reminderAt': reminderAt?.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory Todo.fromMap(Map<dynamic, dynamic> map) {
    return Todo(
      id: map['id'] as String,
      title: map['title'] as String,
      notes: map['notes'] as String? ?? '',
      isCompleted: map['isCompleted'] as bool? ?? false,
      reminderAt: map['reminderAt'] != null
          ? DateTime.parse(map['reminderAt'] as String)
          : null,
      createdAt: DateTime.parse(map['createdAt'] as String),
      updatedAt: DateTime.parse(map['updatedAt'] as String),
    );
  }
}
