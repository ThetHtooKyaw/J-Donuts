import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/primary_button.dart';

class AuthScaffold extends StatelessWidget {
  final Widget child;
  final GlobalKey<FormState>? formKey;
  final double progressValue; // 0.25 to 1.0 matching the progress ring
  final bool isLoading;
  final VoidCallback? onBackPressed;
  final String? primaryButtonText;
  final VoidCallback? onPrimaryButtonPressed;

  const AuthScaffold({
    super.key,
    required this.child,
    this.formKey,
    required this.progressValue,
    this.isLoading = false,
    this.onBackPressed,
    this.primaryButtonText,
    this.onPrimaryButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: const Color(0xFFFFF8F9),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                // Top bar
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Back button
                    IconButton(
                      padding: EdgeInsets.zero,
                      style: IconButton.styleFrom(
                        padding: EdgeInsets.all(16),
                        backgroundColor: theme.colorScheme.surface,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        onBackPressed?.call();
                        if (context.canPop()) {
                          context.pop();
                        }
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),

                    // Progress Ring (Task 1 requirement: 25% -> 50% -> 75% -> 100%)
                    SizedBox(
                      width: 28,
                      height: 28,
                      child: CircularProgressIndicator(
                        value: progressValue,
                        backgroundColor: Colors.grey.shade300,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          theme.colorScheme.secondary,
                        ),
                        strokeWidth: 8,
                      ),
                    ),
                  ],
                ),

                // Main Screen Body Content
                Expanded(child: SingleChildScrollView(child: child)),

                // Primary Button (if provided)
                if (primaryButtonText != null) ...[
                  PrimaryButton(
                    text: primaryButtonText!,
                    onPressed: onPrimaryButtonPressed,
                    isLoading: isLoading,
                  ),
                  const SizedBox(height: 40),
                ],

                // Terms and Privacy Policy Text
                Text.rich(
                  TextSpan(
                    text:
                        'By continuing, you acknowledge that you have read and agree to our ',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade500,
                      height: 1.3,
                    ),
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
                ),
              ],
            ),
          ),
        ),
      ),
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
          style: TextStyle(
            color: theme.colorScheme.onSecondary,
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
