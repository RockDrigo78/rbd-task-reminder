import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../l10n/app_localizations.dart';
import '../providers/service_providers.dart';
import '../providers/todo_provider.dart';
import '../widgets/app_background.dart';
import '../widgets/gradient_fab.dart';
import '../widgets/reminder_picker_row.dart';

class TodoFormScreen extends ConsumerStatefulWidget {
  const TodoFormScreen({super.key, this.todoId});

  final String? todoId;

  @override
  ConsumerState<TodoFormScreen> createState() => _TodoFormScreenState();
}

class _TodoFormScreenState extends ConsumerState<TodoFormScreen> {
  final titleController = TextEditingController();
  final notesController = TextEditingController();
  bool reminderEnabled = false;
  DateTime? reminderAt;
  String? errorMessage;
  bool isSaving = false;

  bool get isEditing => widget.todoId != null;

  @override
  void initState() {
    super.initState();
    if (widget.todoId != null) {
      final todo = ref.read(todosProvider.notifier).getById(widget.todoId!);
      if (todo != null) {
        titleController.text = todo.title;
        notesController.text = todo.notes;
        reminderEnabled = todo.reminderAt != null;
        reminderAt = todo.reminderAt;
      }
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    notesController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final localizations = AppLocalizations.of(context)!;
    final title = titleController.text.trim();
    if (title.isEmpty) {
      setState(() {
        errorMessage = localizations.titleRequired;
      });
      return;
    }

    if (reminderEnabled) {
      if (reminderAt == null) {
        setState(() {
          errorMessage = localizations.pickReminderDateAndTime;
        });
        return;
      }
      if (!reminderAt!.isAfter(DateTime.now())) {
        setState(() {
          errorMessage = localizations.reminderMustBeFuture;
        });
        return;
      }
    }

    setState(() {
      errorMessage = null;
      isSaving = true;
    });

    var didPop = false;

    try {
      if (reminderEnabled) {
        final notificationService = ref.read(notificationServiceProvider);
        await notificationService.requestPermissions();
      }

      final notifier = ref.read(todosProvider.notifier);

      if (isEditing) {
        final existingTodo = notifier.getById(widget.todoId!);
        if (existingTodo == null) {
          return;
        }

        final updatedTodo = existingTodo.copyWith(
          title: title,
          notes: notesController.text.trim(),
          reminderAt: reminderEnabled ? reminderAt : null,
          clearReminder: !reminderEnabled,
        );

        await notifier.updateTodo(updatedTodo);
      } else {
        await notifier.addTodo(
          title: title,
          notes: notesController.text.trim(),
          reminderAt: reminderEnabled ? reminderAt : null,
        );
      }

      if (mounted) {
        Navigator.pop(context);
        didPop = true;
      }
    } catch (_) {
      if (mounted) {
        setState(() {
          errorMessage = localizations.saveFailed;
        });
      }
    } finally {
      if (mounted && !didPop) {
        setState(() {
          isSaving = false;
        });
      }
    }
  }

  Future<void> _delete() async {
    final localizations = AppLocalizations.of(context)!;
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(localizations.deleteTaskQuestion),
        content: Text(localizations.deleteCannotBeUndone),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(localizations.cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(localizations.delete),
          ),
        ],
      ),
    );

    if (shouldDelete == true && widget.todoId != null) {
      await ref.read(todosProvider.notifier).deleteTodo(widget.todoId!);
      if (mounted) {
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return AppBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_rounded),
          ),
          title: Text(isEditing ? localizations.editTask : localizations.addTask),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: TextButton(
                onPressed: isSaving ? null : _save,
                child: isSaving
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Text(localizations.save),
              ),
            ),
          ],
        ),
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            TextField(
              controller: titleController,
              style: Theme.of(context).textTheme.titleMedium,
              decoration: InputDecoration(
                labelText: localizations.title,
                prefixIcon: const Icon(Icons.edit_note_rounded),
              ),
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: notesController,
              decoration: InputDecoration(
                labelText: localizations.notesOptional,
                prefixIcon: const Icon(Icons.notes_rounded),
                alignLabelWithHint: true,
              ),
              minLines: 3,
              maxLines: 5,
            ),
            const SizedBox(height: 20),
            ReminderPickerRow(
              reminderEnabled: reminderEnabled,
              reminderAt: reminderAt,
              onReminderEnabledChanged: (enabled) {
                setState(() {
                  reminderEnabled = enabled;
                  errorMessage = null;
                });
              },
              onReminderAtChanged: (value) {
                setState(() {
                  reminderAt = value;
                  errorMessage = null;
                });
              },
            ),
            if (errorMessage != null) ...[
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Theme.of(context)
                      .colorScheme
                      .error
                      .withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Theme.of(context)
                        .colorScheme
                        .error
                        .withValues(alpha: 0.3),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.error_outline_rounded,
                      color: Theme.of(context).colorScheme.error,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        errorMessage!,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.error,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
            if (isEditing) ...[
              const SizedBox(height: 28),
              OutlinedButton.icon(
                onPressed: _delete,
                icon: const Icon(Icons.delete_outline_rounded),
                label: Text(localizations.deleteTask),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Theme.of(context).colorScheme.error,
                  side: BorderSide(
                    color: Theme.of(context)
                        .colorScheme
                        .error
                        .withValues(alpha: 0.4),
                  ),
                ),
              ),
            ],
          ],
        ),
        bottomNavigationBar: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
            child: GradientButton(
              onPressed: isSaving ? null : _save,
              label: localizations.save,
              icon: Icons.check_rounded,
            ),
          ),
        ),
      ),
    );
  }
}
