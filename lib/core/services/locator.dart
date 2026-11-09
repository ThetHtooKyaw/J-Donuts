import 'dart:io';

import 'package:drift/native.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../../features/auth/data/datasources/auth_local_data_source.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/usecases/auth_usecase.dart';
import '../../features/auth/presentation/cubit/auth_cubit.dart';
import '../../features/home/data/datasources/drift_database.dart';
import '../../features/home/data/datasources/home_local_data_source.dart';
import '../../features/home/data/repositories/home_repository_impl.dart';
import '../../features/home/domain/repositories/home_repository.dart';
import '../../features/home/domain/usecases/get_home_data_usecase.dart';
import '../../features/home/presentation/cubit/home_cubit.dart';

final locator = GetIt.instance;

Future<void> setupLocator() async {
  // Register Flutter Secure Storage
  locator.registerLazySingleton<FlutterSecureStorage>(
    () => const FlutterSecureStorage(),
  );

  // Register Drift Database
  final applicationDirectory = await getApplicationDocumentsDirectory();
  final databaseFile = File(
    p.join(applicationDirectory.path, 'j_donuts.sqlite'),
  );

  locator.registerSingleton<AppDatabase>(
    AppDatabase(NativeDatabase.createInBackground(databaseFile)),
  );

  // Register Data Sources
  locator.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(secureStorage: locator()),
  );
  locator.registerLazySingleton<HomeLocalDataSource>(
    () => HomeLocalDataSourceImpl(database: locator()),
  );

  // Register Repositories
  locator.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(localDataSource: locator()),
  );
  locator.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(localDataSource: locator()),
  );

  // Register Use Cases
  locator.registerLazySingleton(() => SendOtpUsecase(locator()));
  locator.registerLazySingleton(() => VerifyOtpUsecase(locator()));
  locator.registerLazySingleton(() => RegisterUserUsecase(locator()));
  locator.registerLazySingleton(() => GetCachedUserUsecase(locator()));
  locator.registerLazySingleton(() => GetHomeDataUsecase(locator()));

  // Keep one AuthCubit instance for the complete auth flow.
  locator.registerLazySingleton(
    () => AuthCubit(
      sendOtpUsecase: locator(),
      verifyOtpUsecase: locator(),
      registerUserUsecase: locator(),
      getCachedUserUsecase: locator(),
    ),
  );
  locator.registerFactory(() => HomeCubit(locator()));
}
