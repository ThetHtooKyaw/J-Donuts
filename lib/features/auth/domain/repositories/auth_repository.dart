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

  Future<User?> getCachedUser();

  Future<void> logout();
}
