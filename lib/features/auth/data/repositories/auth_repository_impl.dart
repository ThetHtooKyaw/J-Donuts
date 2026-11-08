import '../../domain/entities/user.dart';
import '../models/user_model.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_local_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl({required this.localDataSource});

  @override
  Future<void> sendOtp(String phoneNumber) async {
    await Future.delayed(const Duration(seconds: 1)); // Fake network delay
  }

  @override
  Future<bool> verifyOtp(String phoneNumber, String otp) async {
    await Future.delayed(const Duration(seconds: 1)); // Fake network delay

    // Fake code "123456" passes, anything else fails
    return otp == '123456';
  }

  @override
  Future<User> register({
    required String phoneNumber,
    required String firstName,
    String? lastName,
    required DateTime dateOfBirth,
  }) async {
    await Future.delayed(const Duration(seconds: 1));
    final userModel = UserModel(
      phoneNumber: phoneNumber,
      firstName: firstName,
      lastName: lastName,
      dateOfBirth: dateOfBirth,
    );

    await localDataSource.cacheUser(userModel);

    return userModel;
  }

  @override
  Future<User?> getCachedUser() async {
    return await localDataSource.getCachedUser();
  }

  @override
  Future<void> logout() async {
    await Future.delayed(
      const Duration(milliseconds: 500),
    ); // Fake network delay
    await localDataSource.clearSession();
  }
}
