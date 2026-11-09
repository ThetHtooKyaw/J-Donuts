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

class ActivateSessionUsecase {
  final AuthRepository repository;
  ActivateSessionUsecase(this.repository);

  Future<void> call() => repository.activateSession();
}

class GetCachedUserUsecase {
  final AuthRepository repository;
  GetCachedUserUsecase(this.repository);

  Future<User?> call() => repository.getCachedUser();
}

class GetActiveUserUsecase {
  final AuthRepository repository;
  GetActiveUserUsecase(this.repository);

  Future<User?> call() => repository.getActiveUser();
}

class LogoutUsecase {
  final AuthRepository repository;
  LogoutUsecase(this.repository);

  Future<void> call() => repository.logout();
}
