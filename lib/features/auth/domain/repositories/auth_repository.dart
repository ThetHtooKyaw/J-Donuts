import '../entities/user.dart';

abstract class AuthRepository {
  Future<void> sendOtp(String phoneNumber);

  Future<bool> verifyOtp(String phoneNumber, String otp);

  Future<User> register({
    required String phoneNumber,
    required String firstName,
    String? lastName,
    required DateTime dateOfBirth,
  });

  Future<void> activateSession();

  Future<User?> getCachedUser();

  Future<User?> getActiveUser();

  Future<void> logout();
}
