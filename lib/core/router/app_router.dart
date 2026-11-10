import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:j_donuts/features/home/presentation/screens/home_screen.dart';

import '../../core/widgets/app_bottom_nav_bar.dart';
import '../../features/auth/presentation/screens/dob_input_screen.dart';
import '../../features/auth/presentation/screens/name_input_screen.dart';
import '../../features/auth/presentation/screens/onboarding_screen.dart';
import '../../features/auth/presentation/screens/phone_number_input_screen.dart';
import '../../features/auth/presentation/screens/verify_otp_screen.dart';
import '../../features/auth/presentation/screens/welcome_screen.dart';
import '../../features/home/presentation/screens/setting_screen.dart';
import '../../features/reward/presentation/screens/reward_screen.dart';

GoRouter createRouter({bool isLoggedIn = false}) => GoRouter(
  initialLocation: isLoggedIn ? '/home' : '/onboarding',
  routes: [
    GoRoute(
      path: '/onboarding',
      name: 'onboarding',
      builder: (context, state) => const OnboardingScreen(),
    ),
    GoRoute(
      path: '/phone_input',
      name: 'phone_input',
      builder: (context, state) => PhoneNumberInputScreen(
        isLogin: state.uri.queryParameters['mode'] == 'login',
      ),
    ),
    GoRoute(
      path: '/verify_otp',
      name: 'verify_otp',
      builder: (context, state) => const VerifyOtpScreen(),
    ),
    GoRoute(
      path: '/name_input',
      name: 'name_input',
      builder: (context, state) => const NameInputScreen(),
    ),
    GoRoute(
      path: '/dob_input',
      name: 'dob_input',
      builder: (context, state) => const DOBInputScreen(),
    ),
    GoRoute(
      path: '/welcome',
      name: 'welcome',
      builder: (context, state) => const WelcomeScreen(),
    ),

    // Bottom Navigation Routes
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return Scaffold(
          body: navigationShell,
          bottomNavigationBar: AppBottomNavBar(
            currentIndex: switch (state.uri.path) {
              '/rewards' => 1,
              '/settings' => 4,
              _ => 0,
            },
          ),
        );
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/home',
              name: 'home',
              builder: (context, state) => const HomeScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/rewards',
              name: 'rewards',
              builder: (context, state) => const RewardsScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/settings',
              name: 'settings',
              builder: (context, state) => const SettingScreen(),
            ),
          ],
        ),
      ],
    ),
  ],
);

final GoRouter router = createRouter();
