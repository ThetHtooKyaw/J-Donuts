import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/widgets/app_snack_bar.dart';

class QuestCard extends StatelessWidget {
  final String title;
  final int current;
  final int total;
  final String points;
  final Widget progressWidget;

  const QuestCard({
    super.key,
    required this.title,
    required this.current,
    required this.total,
    required this.points,
    required this.progressWidget,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDone = current >= total;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(10),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Progress Widget (Donut or Drink)
          progressWidget,
          const SizedBox(width: 20),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Quest Title
                Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),

                // Progress Text
                Text('$current/$total', style: theme.textTheme.bodyMedium),
                const SizedBox(height: 10),

                Row(
                  children: [
                    // Earn Button
                    SizedBox(
                      width: 90,
                      child: ElevatedButton(
                        onPressed: isDone
                            ? () => showComingSoonSnackBar(
                                context,
                                "Earned $points",
                              )
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isDone
                              ? theme.colorScheme.primary
                              : theme.colorScheme.onSurface.withOpacity(0.3),
                        ),
                        child: Text(
                          'EARN',
                          style: GoogleFonts.fredoka(
                            color: theme.colorScheme.surface,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),

                    // Points Text
                    Text(points, style: theme.textTheme.bodyMedium),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
