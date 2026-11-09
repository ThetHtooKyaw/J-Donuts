import 'package:flutter/material.dart';

import '../../../../core/widgets/primary_button.dart';
import 'terms_and_privacy.dart';

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
      backgroundColor: theme.colorScheme.background,
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
                      padding: EdgeInsets.all(16),
                      onPressed: () {
                        onBackPressed?.call();
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),

                    // Progress indicator: completed steps show a check mark.
                    progressValue >= 1.0
                        ? Container(
                            width: 34,
                            height: 34,
                            decoration: BoxDecoration(
                              color: theme.colorScheme.secondary,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 22,
                            ),
                          )
                        : SizedBox(
                            width: 28,
                            height: 28,
                            child: CircularProgressIndicator(
                              value: progressValue,
                              backgroundColor: theme.colorScheme.primary
                                  .withOpacity(0.6),
                              valueColor: AlwaysStoppedAnimation<Color>(
                                theme.colorScheme.secondary,
                              ),
                              strokeWidth: 8,
                            ),
                          ),
                  ],
                ),

                // Content
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
                TermsAndPrivacy(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
