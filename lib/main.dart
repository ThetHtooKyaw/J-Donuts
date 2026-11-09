import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/router/app_router.dart';
import 'core/services/locator.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/domain/repositories/auth_repository.dart';
import 'features/auth/presentation/cubit/auth_cubit.dart';
import 'features/home/presentation/cubit/home_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  final cachedUser = await locator<AuthRepository>().getActiveUser();

  runApp(MyApp(isLoggedIn: cachedUser != null));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  const MyApp({super.key, this.isLoggedIn = false});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      routerConfig: createRouter(isLoggedIn: isLoggedIn),
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider<AuthCubit>.value(value: locator<AuthCubit>()),
            BlocProvider<HomeCubit>(create: (_) => locator<HomeCubit>()),
          ],
          child: child ?? const SizedBox.shrink(),
        );
      },
    );
  }
}
