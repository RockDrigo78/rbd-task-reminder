import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class TaskCheckbox extends StatelessWidget {
  const TaskCheckbox({
    super.key,
    required this.isCompleted,
    required this.onToggle,
  });

  final bool isCompleted;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onToggle,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOutCubic,
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: isCompleted ? AppColors.primaryGradient : null,
          color: isCompleted ? null : Colors.transparent,
          border: Border.all(
            color: isCompleted ? Colors.transparent : colorScheme.outline,
            width: 2,
          ),
          boxShadow: isCompleted
              ? [
                  BoxShadow(
                    color: AppColors.indigo.withValues(alpha: 0.35),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ]
              : null,
        ),
        child: isCompleted
            ? const Icon(Icons.check_rounded, size: 16, color: Colors.white)
            : null,
      ),
    );
  }
}
