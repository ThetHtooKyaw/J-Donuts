import 'package:flutter/material.dart';

class TierStep {
  final String title;
  final String subtitle;
  final String tireIcon;
  final Color? color;
  final bool isAchieved;
  final bool isCurrent;
  final double progress;

  const TierStep({
    required this.title,
    required this.subtitle,
    required this.tireIcon,
    required this.color,
    this.isAchieved = false,
    this.isCurrent = false,
    this.progress = 0.0,
  });
}

class TierProgressWidget extends StatelessWidget {
  final List<TierStep> steps;

  const TierProgressWidget({super.key, required this.steps});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: List.generate(steps.length, (index) {
        final step = steps[index];
        final isLast = index == steps.length - 1;
        final imageSize = step.isCurrent || step.isAchieved ? 44.0 : 36.0;

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: step.isCurrent || step.isAchieved ? 0 : 4.0,
              ),
              child: Column(
                children: [
                  // Badge Icon
                  SizedBox(
                    width: imageSize,
                    height: imageSize,
                    child: Opacity(
                      opacity: step.isCurrent || step.isAchieved ? 1.0 : 0.5,
                      child: Image.asset(
                        step.tireIcon,
                        width: imageSize,
                        height: imageSize,
                      ),
                    ),
                  ),

                  // Progress Line
                  if (!isLast)
                    Container(
                      width: 4,
                      height: 46,
                      alignment: Alignment.topCenter,
                      child: RotatedBox(
                        quarterTurns: 1,
                        child: SizedBox(
                          width: 46, // Matches container height
                          height: 4,
                          child: LinearProgressIndicator(
                            value: step.progress.clamp(0.0, 1.0),
                            backgroundColor: theme.colorScheme.onInverseSurface
                                .withOpacity(0.3),
                            valueColor: AlwaysStoppedAnimation<Color>(
                              step.color ?? theme.colorScheme.onSurface,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(width: 20),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      step.title,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: step.isCurrent
                            ? theme.colorScheme.onSurface
                            : theme.colorScheme.onInverseSurface,
                      ),
                    ),
                    const SizedBox(height: 2),

                    // Subtitle
                    Text(
                      step.subtitle,
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: step.isCurrent
                            ? theme.colorScheme.onSurface
                            : theme.colorScheme.onInverseSurface,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
