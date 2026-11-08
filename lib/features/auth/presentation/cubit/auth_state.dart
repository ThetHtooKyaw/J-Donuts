enum AuthStep { phone, otp, name, dob, completed }

class AuthState {
  final AuthStep currentStep;
  final String phoneNumber;
  final String otp;
  final String firstName;
  final String? lastName;
  final DateTime? dateOfBirth;
  final bool isLoading;
  final String? errorMessage;
  final int failedOtpAttempts;

  const AuthState({
    this.currentStep = AuthStep.phone,
    this.phoneNumber = '',
    this.otp = '',
    this.firstName = '',
    this.lastName,
    this.dateOfBirth,
    this.isLoading = false,
    this.errorMessage,
    this.failedOtpAttempts = 0,
  });

  double get progressPercentage {
    switch (currentStep) {
      case AuthStep.phone:
        return 0.25;
      case AuthStep.otp:
        return 0.50;
      case AuthStep.name:
        return 0.75;
      case AuthStep.dob:
        return 1.0;
      case AuthStep.completed:
        return 1.0;
    }
  }

  AuthState copyWith({
    AuthStep? currentStep,
    String? phoneNumber,
    String? otp,
    String? firstName,
    String? lastName,
    DateTime? dateOfBirth,
    bool? isLoading,
    String? errorMessage,
    int? failedOtpAttempts,
  }) {
    return AuthState(
      currentStep: currentStep ?? this.currentStep,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      otp: otp ?? this.otp,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      failedOtpAttempts: failedOtpAttempts ?? this.failedOtpAttempts,
    );
  }
}
