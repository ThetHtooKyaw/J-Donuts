import 'package:go_router/go_router.dart';
import 'package:j_donuts/features/auth/presentation/screens/verify_otp_screen.dart';
import '../../features/auth/presentation/screens/name_input_screen.dart';
import '../../features/auth/presentation/screens/phone_number_input_screen.dart';

final GoRouter router = GoRouter(
  initialLocation: '/phone_input',
  routes: [
    GoRoute(
      path: '/phone_input',
      name: 'phone_input',
      builder: (context, state) => const PhoneNumberInputScreen(),
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
  ],
);
