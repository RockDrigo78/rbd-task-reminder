import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import 'app_card.dart';

class StatsSummaryCard extends StatelessWidget {
  const StatsSummaryCard({
    super.key,
    required this.activeCount,
    required this.completedCount,
    required this.activeLabel,
  });

  final int activeCount;
  final int completedCount;
  final String activeLabel;

  @override
  Widget build(BuildContext context) {
    final total = activeCount + completedCount;
    final progress = total == 0 ? 0.0 : completedCount / total;
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
      child: AppCard(
        gradient: AppColors.subtleGradient,
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$activeCount',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          foreground: Paint()
                            ..shader = AppColors.primaryGradient.createShader(
                              const Rect.fromLTWH(0, 0, 120, 40),
                            ),
                        ),
                  ),
                  Text(
                    activeLabel.toLowerCase(),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 12),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(AppTheme.chipRadius),
                    child: LinearProgressIndicator(
                      value: progress,
                      minHeight: 8,
                      backgroundColor: colorScheme.surfaceContainerHighest,
                      color: AppColors.indigo,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 20),
            SizedBox(
              width: 72,
              height: 72,
              child: CustomPaint(
                painter: _RingPainter(
                  progress: progress,
                  backgroundColor: colorScheme.surfaceContainerHighest,
                ),
                child: Center(
                  child: Text(
                    '${(progress * 100).round()}%',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RingPainter extends CustomPainter {
  _RingPainter({
    required this.progress,
    required this.backgroundColor,
  });

  final double progress;
  final Color backgroundColor;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 6;
    const strokeWidth = 8.0;

    final backgroundPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, backgroundPaint);

    final sweepAngle = 2 * math.pi * progress;
    final rect = Rect.fromCircle(center: center, radius: radius);
    final gradientPaint = Paint()
      ..shader = AppColors.primaryGradient.createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      rect,
      -math.pi / 2,
      sweepAngle,
      false,
      gradientPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _RingPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
