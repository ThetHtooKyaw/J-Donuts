import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/screens/dob_input_screen.dart';
import '../../features/auth/presentation/screens/name_input_screen.dart';
import '../../features/auth/presentation/screens/onboarding_screen.dart';
import '../../features/auth/presentation/screens/phone_number_input_screen.dart';
import '../../features/auth/presentation/screens/verify_otp_screen.dart';
import '../../features/auth/presentation/screens/welcome_screen.dart';

GoRouter createRouter({bool isLoggedIn = false}) => GoRouter(
  initialLocation: isLoggedIn ? '/welcome' : '/onboarding',
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
  ],
);

final GoRouter router = createRouter();
