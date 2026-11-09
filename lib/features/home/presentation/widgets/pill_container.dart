import 'package:flutter/material.dart';

class PillContainer extends StatelessWidget {
  final String text;
  final bool smallContainer;
  final bool hasBorder;
  const PillContainer({
    super.key,
    required this.text,
    this.smallContainer = false,
    this.hasBorder = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: theme.colorScheme.onSecondaryContainer,
        border: hasBorder ? Border.all(color: Colors.white, width: 1) : null,
        borderRadius: BorderRadius.circular(smallContainer ? 14 : 16),
      ),
      child: Text(
        text,
        style: smallContainer
            ? theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.surface,
                fontWeight: FontWeight.bold,
              )
            : theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.surface,
                fontWeight: FontWeight.bold,
              ),
      ),
    );
  }
}
