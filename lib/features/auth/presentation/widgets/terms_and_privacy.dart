import 'package:flutter/material.dart';

class TermsAndPrivacy extends StatelessWidget {
  const TermsAndPrivacy({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Text.rich(
      TextSpan(
        text:
            'By continuing, you acknowledge that you have read and agree to our ',
        style: theme.textTheme.bodyMedium?.copyWith(height: 1.3),
        children: [
          buildLinkSpan(
            context,
            theme,
            'Terms of Use',
            'Terms of Use placeholder sheet opened',
          ),
          const TextSpan(text: ' and '),
          buildLinkSpan(
            context,
            theme,
            'Privacy Policy',
            'Privacy Policy placeholder sheet opened',
          ),
          const TextSpan(text: '.'),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }

  WidgetSpan buildLinkSpan(
    BuildContext context,
    ThemeData theme,
    String text,
    String message,
  ) {
    return WidgetSpan(
      alignment: PlaceholderAlignment.baseline,
      baseline: TextBaseline.alphabetic,
      child: GestureDetector(
        onTap: () {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(message)));
        },
        child: Text(
          text,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSecondary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
