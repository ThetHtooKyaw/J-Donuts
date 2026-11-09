import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class SendOtpUsecase {
  final AuthRepository repository;
  SendOtpUsecase(this.repository);

  Future<void> call(String phoneNumber) => repository.sendOtp(phoneNumber);
}

class VerifyOtpUsecase {
  final AuthRepository repository;
  VerifyOtpUsecase(this.repository);

  Future<bool> call(String phone, String otp) =>
      repository.verifyOtp(phone, otp);
}

class RegisterUserUsecase {
  final AuthRepository repository;
  RegisterUserUsecase(this.repository);

  Future<User> call({
    required String phoneNumber,
    required String firstName,
    String? lastName,
    required DateTime dateOfBirth,
  }) => repository.register(
    phoneNumber: phoneNumber,
    firstName: firstName,
    lastName: lastName,
    dateOfBirth: dateOfBirth,
  );
}

class GetCachedUserUsecase {
  final AuthRepository repository;
  GetCachedUserUsecase(this.repository);

  Future<User?> call() => repository.getCachedUser();
}
