import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../l10n/app_localizations.dart';
import '../models/todo.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import 'app_card.dart';
import 'task_checkbox.dart';

class TodoListItem extends StatelessWidget {
  const TodoListItem({
    super.key,
    required this.todo,
    required this.onToggleComplete,
    required this.onTap,
    required this.onDelete,
  });

  final Todo todo;
  final VoidCallback onToggleComplete;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  Future<bool> _confirmDelete(BuildContext context) async {
    final localizations = AppLocalizations.of(context)!;

    return await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(localizations.deleteTaskQuestion),
            content: Text(localizations.removeTaskConfirm(todo.title)),
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
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context).toString();
    final dateFormat = DateFormat('MMM d, h:mm a', locale);
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      child: Dismissible(
        key: ValueKey(todo.id),
        direction: DismissDirection.endToStart,
        background: Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 24),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                colorScheme.error.withValues(alpha: 0.2),
                colorScheme.error,
              ],
            ),
            borderRadius: BorderRadius.circular(AppTheme.cardRadius),
          ),
          child: const Icon(Icons.delete_rounded, color: Colors.white),
        ),
        confirmDismiss: (_) => _confirmDelete(context),
        onDismissed: (_) => onDelete(),
        child: AppCard(
          onTap: onTap,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 2),
                child: TaskCheckbox(
                  isCompleted: todo.isCompleted,
                  onToggle: onToggleComplete,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      todo.title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            decoration: todo.isCompleted
                                ? TextDecoration.lineThrough
                                : null,
                            color: todo.isCompleted
                                ? colorScheme.onSurfaceVariant
                                : colorScheme.onSurface,
                          ),
                    ),
                    if (todo.reminderAt != null && !todo.isCompleted) ...[
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          gradient: AppColors.subtleGradient,
                          borderRadius:
                              BorderRadius.circular(AppTheme.chipRadius),
                          border: Border.all(
                            color: AppColors.indigo.withValues(alpha: 0.25),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.notifications_active_rounded,
                              size: 14,
                              color: AppColors.indigo,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              dateFormat.format(todo.reminderAt!),
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium
                                  ?.copyWith(
                                    color: AppColors.indigo,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ] else if (todo.notes.isNotEmpty) ...[
                      const SizedBox(height: 6),
                      Text(
                        todo.notes,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ],
                ),
              ),
              if (todo.isCompleted)
                IconButton(
                  onPressed: () async {
                    final shouldDelete = await _confirmDelete(context);
                    if (shouldDelete && context.mounted) {
                      onDelete();
                    }
                  },
                  tooltip: localizations.delete,
                  style: IconButton.styleFrom(
                    backgroundColor:
                        colorScheme.error.withValues(alpha: 0.12),
                    foregroundColor: colorScheme.error,
                  ),
                  icon: const Icon(Icons.delete_outline_rounded, size: 20),
                )
              else
                Icon(
                  Icons.chevron_right_rounded,
                  color: colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
