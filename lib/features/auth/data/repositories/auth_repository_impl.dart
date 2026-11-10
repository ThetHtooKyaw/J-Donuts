import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../models/user_model.dart';
import '../datasources/auth_local_data_source.dart';
import '../../../home/data/datasources/drift_database.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthLocalDataSource localDataSource;
  final AppDatabase database;

  AuthRepositoryImpl({required this.localDataSource, required this.database});

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
    await Future.delayed(const Duration(seconds: 1)); // Fake network delay
    final userModel = UserModel(
      phoneNumber: phoneNumber,
      firstName: firstName,
      lastName: lastName,
      dateOfBirth: dateOfBirth,
    );

    await localDataSource.cacheUser(userModel);
    await database.updateMemberProfile(
      name: [
        firstName,
        if (lastName != null && lastName.trim().isNotEmpty) lastName.trim(),
      ].join(' '),
      phoneNumber: phoneNumber,
      dateOfBirth: dateOfBirth,
    );

    return userModel;
  }

  @override
  Future<void> activateSession() => localDataSource.activateSession();

  @override
  Future<User?> getCachedUser() async {
    final user = await localDataSource.getCachedUser();
    if (user != null) {
      await _syncMemberProfile(user);
    }
    return user;
  }

  @override
  Future<User?> getActiveUser() async {
    final user = await localDataSource.getActiveUser();
    if (user != null) {
      await _syncMemberProfile(user);
    }
    return user;
  }

  Future<void> _syncMemberProfile(User user) {
    return database.updateMemberProfile(
      name: [
        user.firstName,
        if (user.lastName != null && user.lastName!.trim().isNotEmpty)
          user.lastName!.trim(),
      ].join(' '),
      phoneNumber: user.phoneNumber,
      dateOfBirth: user.dateOfBirth,
    );
  }

  @override
  Future<void> logout() async {
    await Future.delayed(
      const Duration(milliseconds: 500),
    ); // Fake network delay
    await localDataSource.clearSession();
  }
}
