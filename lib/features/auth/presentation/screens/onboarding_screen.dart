import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/widgets/app_snack_bar.dart';
import '../widgets/terms_and_privacy.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      body: Column(
        children: [
          // Banner Image
          Expanded(
            flex: 2,
            child: ShaderMask(
              blendMode: BlendMode.dstIn,
              shaderCallback: (Rect bounds) {
                return const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.white, Colors.white, Colors.transparent],
                  stops: [0.0, 0.65, 1.0],
                ).createShader(bounds);
              },
              child: Image.asset(
                'assets/images/onboarding_banner.png',
                width: double.infinity,
                fit: BoxFit.cover,
                alignment: const Alignment(0, -0.3),
              ),
            ),
          ),

          // Content Section
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 44),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Title
                  Text(
                    "Round food for\nevery mood",
                    textAlign: TextAlign.center,
                    style: theme.textTheme.displayLarge,
                  ),
                  const SizedBox(height: 40),

                  // Register Button
                  SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: ElevatedButton(
                      onPressed: () => context.pushNamed('phone_input'),
                      child: Text("LET'S GET STARTED"),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Login Button
                  GestureDetector(
                    onTap: () => context.pushNamed(
                      'phone_input',
                      queryParameters: const {'mode': 'login'},
                    ),
                    child: Text.rich(
                      TextSpan(
                        text: "Already have an account? ",
                        style: theme.textTheme.bodyMedium,
                        children: [
                          TextSpan(
                            text: "Log In",
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.colorScheme.secondary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Social Media Sign-In Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildSocialIconButton(
                        context: context,
                        iconString: 'assets/icons/google.png',
                        color: Colors.red,
                        message: 'Google sign-in screen is coming soon.',
                      ),
                      const SizedBox(width: 30),

                      _buildSocialIconButton(
                        context: context,
                        icon: Icons.apple,
                        color: Colors.black,
                        message: 'Apple sign-in screen is coming soon.',
                      ),
                      const SizedBox(width: 30),

                      _buildSocialIconButton(
                        context: context,
                        icon: Icons.facebook,
                        color: const Color(0xFF1877F2),
                        message: 'Facebook sign-in screen is coming soon.',
                      ),
                    ],
                  ),
                  const Spacer(),

                  TermsAndPrivacy(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildSocialIconButton({
  required BuildContext context,
  String? iconString,
  IconData? icon,
  required Color color,
  required String message,
}) {
  return GestureDetector(
    onTap: () => showComingSoonSnackBar(context, message),
    child: Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(shape: BoxShape.circle),
      child: icon != null
          ? Icon(icon, color: color, size: 36)
          : Center(
              child: SizedBox(
                width: 30,
                height: 30,
                child: Image.asset(iconString!, fit: BoxFit.contain),
              ),
            ),
    ),
  );
}
