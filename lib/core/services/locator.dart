import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

import '../../features/auth/data/datasources/auth_local_data_source.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/usecases/auth_usecase.dart';
import '../../features/auth/presentation/cubit/auth_cubit.dart';

final locator = GetIt.instance;

void setupLocator() {
  // 1. Register Flutter Secure Storage
  locator.registerLazySingleton<FlutterSecureStorage>(
    () => const FlutterSecureStorage(),
  );

  // Register Data Sources
  locator.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(secureStorage: locator()),
  );

  // Register Repositories
  locator.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(localDataSource: locator()),
  );

  // Register Use Cases
  locator.registerLazySingleton(() => SendOtpUsecase(locator()));
  locator.registerLazySingleton(() => VerifyOtpUsecase(locator()));
  locator.registerLazySingleton(() => RegisterUserUsecase(locator()));
  locator.registerLazySingleton(() => GetCachedUserUsecase(locator()));

  // Keep one AuthCubit instance for the complete auth flow.
  locator.registerLazySingleton(
    () => AuthCubit(
      sendOtpUsecase: locator(),
      verifyOtpUsecase: locator(),
      registerUserUsecase: locator(),
      getCachedUserUsecase: locator(),
    ),
  );
}
