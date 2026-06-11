import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../l10n/app_localizations.dart';
import '../models/todo.dart';
import '../providers/todo_provider.dart';
import '../utils/todo_sorting.dart';
import '../widgets/app_background.dart';
import '../widgets/empty_state.dart';
import '../widgets/gradient_fab.dart';
import '../widgets/section_header.dart';
import '../widgets/stats_summary_card.dart';
import '../widgets/todo_list_item.dart';
import 'settings_screen.dart';
import 'todo_form_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    final todos = ref.watch(todosProvider);
    final groupedActiveTodos = groupActiveTodos(todos);
    final completedTodos = todos.where((todo) => todo.isCompleted).toList();

    return AppBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: todos.isEmpty
              ? CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: _HomeHeader(localizations: localizations),
                    ),
                    const SliverFillRemaining(
                      hasScrollBody: false,
                      child: EmptyState(),
                    ),
                  ],
                )
              : CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: _HomeHeader(localizations: localizations),
                    ),
                    SliverToBoxAdapter(
                      child: StatsSummaryCard(
                        activeCount: groupedActiveTodos.today.length +
                            groupedActiveTodos.tomorrow.length +
                            groupedActiveTodos.later.length +
                            groupedActiveTodos.withoutReminder.length,
                        completedCount: completedTodos.length,
                        activeLabel: localizations.active,
                        finishedLabel: localizations.finished,
                      ),
                    ),
                    ..._buildActiveTodoSections(
                      context: context,
                      ref: ref,
                      groupedActiveTodos: groupedActiveTodos,
                      localizations: localizations,
                    ),
                    if (completedTodos.isNotEmpty) ...[
                      SliverToBoxAdapter(
                        child: SectionHeader(
                          title: localizations.completed,
                          trailing: '${completedTodos.length}',
                          muted: true,
                        ),
                      ),
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) => TodoListItem(
                            todo: completedTodos[index],
                            onToggleComplete: () {
                              ref
                                  .read(todosProvider.notifier)
                                  .toggleComplete(completedTodos[index].id);
                            },
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute<void>(
                                  builder: (_) => TodoFormScreen(
                                    todoId: completedTodos[index].id,
                                  ),
                                ),
                              );
                            },
                            onDelete: () {
                              ref
                                  .read(todosProvider.notifier)
                                  .deleteTodo(completedTodos[index].id);
                            },
                          ),
                          childCount: completedTodos.length,
                        ),
                      ),
                    ],
                    const SliverToBoxAdapter(child: SizedBox(height: 88)),
                  ],
                ),
        ),
        floatingActionButton: GradientFab(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (_) => const TodoFormScreen(),
              ),
            );
          },
          icon: Icons.add_rounded,
        ),
      ),
    );
  }
}

List<Widget> _buildActiveTodoSections({
  required BuildContext context,
  required WidgetRef ref,
  required GroupedActiveTodos groupedActiveTodos,
  required AppLocalizations localizations,
}) {
  final sections = <({String title, List<Todo> todos})>[
    (title: localizations.taskGroupToday, todos: groupedActiveTodos.today),
    (
      title: localizations.taskGroupTomorrow,
      todos: groupedActiveTodos.tomorrow,
    ),
    (title: localizations.taskGroupUpcoming, todos: groupedActiveTodos.later),
    (
      title: localizations.taskGroupNoReminder,
      todos: groupedActiveTodos.withoutReminder,
    ),
  ];

  return sections
      .where((section) => section.todos.isNotEmpty)
      .expand((section) {
        return [
          SliverToBoxAdapter(
            child: SectionHeader(
              title: section.title,
              trailing: '${section.todos.length}',
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final todo = section.todos[index];
                return TodoListItem(
                  todo: todo,
                  onToggleComplete: () {
                    ref.read(todosProvider.notifier).toggleComplete(todo.id);
                  },
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (_) => TodoFormScreen(todoId: todo.id),
                      ),
                    );
                  },
                  onDelete: () {
                    ref.read(todosProvider.notifier).deleteTodo(todo.id);
                  },
                );
              },
              childCount: section.todos.length,
            ),
          ),
        ];
      })
      .toList();
}

class _HomeHeader extends StatelessWidget {
  const _HomeHeader({required this.localizations});

  final AppLocalizations localizations;

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context).toString();

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 12, 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  localizations.appTitle,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 4),
                Text(
                  DateFormat.yMMMEd(locale).format(DateTime.now()),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (_) => const SettingsScreen(),
                ),
              );
            },
            style: IconButton.styleFrom(
              backgroundColor:
                  Theme.of(context).colorScheme.surfaceContainerHighest,
            ),
            icon: const Icon(Icons.tune_rounded),
          ),
        ],
      ),
    );
  }
}
