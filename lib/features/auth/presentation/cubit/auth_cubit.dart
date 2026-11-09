import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/auth_usecase.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final SendOtpUsecase _sendOtpUsecase;
  final VerifyOtpUsecase _verifyOtpUsecase;
  final RegisterUserUsecase _registerUserUsecase;
  final ActivateSessionUsecase _activateSessionUsecase;
  final GetCachedUserUsecase _getCachedUserUsecase;
  final LogoutUsecase _logoutUsecase;

  AuthCubit({
    required SendOtpUsecase sendOtpUsecase,
    required VerifyOtpUsecase verifyOtpUsecase,
    required RegisterUserUsecase registerUserUsecase,
    required ActivateSessionUsecase activateSessionUsecase,
    required GetCachedUserUsecase getCachedUserUsecase,
    required LogoutUsecase logoutUsecase,
  }) : _sendOtpUsecase = sendOtpUsecase,
       _verifyOtpUsecase = verifyOtpUsecase,
       _registerUserUsecase = registerUserUsecase,
       _activateSessionUsecase = activateSessionUsecase,
       _getCachedUserUsecase = getCachedUserUsecase,
       _logoutUsecase = logoutUsecase,
       super(const AuthState());

  Future<void> logout() => _logoutUsecase();

  Future<bool> hasDifferentRegisteredPhone() async {
    final user = await _getCachedUserUsecase();
    if (user == null) return false;
    return _normalizePhoneNumber(user.phoneNumber) !=
        _normalizePhoneNumber(state.phoneNumber);
  }

  void setLoginMode(bool isLogin) {
    if (state.isLogin != isLogin) {
      emit(state.copyWith(isLogin: isLogin, errorMessage: null));
    }
  }

  void updatePhoneNumber(String phone) {
    emit(state.copyWith(phoneNumber: phone, errorMessage: null));
  }

  Future<bool> submitPhoneNumber() async {
    if (state.isLoading) {
      return false;
    }

    final phoneNumber = _normalizePhoneNumber(state.phoneNumber);
    final user = await _getCachedUserUsecase();
    final isExistingUser =
        user != null && _normalizePhoneNumber(user.phoneNumber) == phoneNumber;

    if (state.isLogin) {
      if (!isExistingUser) {
        emit(state.copyWith(phoneNumber: phoneNumber, errorMessage: null));
        return false;
      }
    }

    emit(
      state.copyWith(
        phoneNumber: phoneNumber,
        isLoading: true,
        errorMessage: null,
      ),
    );

    try {
      await _sendOtpUsecase(phoneNumber);
      emit(state.copyWith(isLoading: false, currentStep: AuthStep.otp));
      return true;
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: 'Failed to send OTP. Please check your connection.',
        ),
      );
      return false;
    }
  }

  Future<void> verifyOtp(String code) async {
    if (state.isLoading) {
      return;
    }

    emit(state.copyWith(isLoading: true, errorMessage: null));

    try {
      final isValid = await _verifyOtpUsecase(state.phoneNumber, code);

      if (isValid) {
        final user = await _getCachedUserUsecase();
        final isExistingUser =
            user != null &&
            _normalizePhoneNumber(user.phoneNumber) ==
                _normalizePhoneNumber(state.phoneNumber);

        if (isExistingUser) {
          await _activateSessionUsecase();
        }

        emit(
          state.copyWith(
            isLoading: false,
            isLogin: state.isLogin || isExistingUser,
            currentStep: isExistingUser || state.isLogin
                ? AuthStep.completed
                : AuthStep.name,
            failedOtpAttempts: 0,
          ),
        );
      } else {
        final attempts = state.failedOtpAttempts + 1;
        String message = 'Invalid code. Try 123456.';

        if (attempts >= 3) {
          message = 'Too many wrong attempts. Please request a new code.';
        }

        emit(
          state.copyWith(
            isLoading: false,
            failedOtpAttempts: attempts,
            errorMessage: message,
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: 'Verification failed. Please try again.',
        ),
      );
    }
  }

  void setName(String first, String? last) {
    emit(
      state.copyWith(
        firstName: first,
        lastName: last,
        currentStep: AuthStep.dob,
        errorMessage: null,
      ),
    );
  }

  Future<void> completeRegistration(DateTime dob) async {
    if (state.isLoading) {
      return;
    }

    emit(state.copyWith(isLoading: true, dateOfBirth: dob));

    try {
      await _registerUserUsecase(
        phoneNumber: state.phoneNumber,
        firstName: state.firstName,
        lastName: state.lastName,
        dateOfBirth: dob,
      );
      emit(state.copyWith(isLoading: false, currentStep: AuthStep.completed));
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: 'Registration failed. Please try again.',
        ),
      );
    }
  }

  void goBack() {
    if (state.currentStep == AuthStep.otp) {
      emit(state.copyWith(currentStep: AuthStep.phone, errorMessage: null));
    } else if (state.currentStep == AuthStep.name) {
      emit(state.copyWith(currentStep: AuthStep.otp, errorMessage: null));
    } else if (state.currentStep == AuthStep.dob) {
      emit(state.copyWith(currentStep: AuthStep.name, errorMessage: null));
    }
  }

  String _normalizePhoneNumber(String phone) {
    var normalized = phone.replaceAll(RegExp(r'[\s-]'), '');
    if (normalized.startsWith('+95')) {
      normalized = normalized.substring(3);
    }
    if (normalized.startsWith('0')) {
      normalized = normalized.substring(1);
    }
    return normalized;
  }
}
