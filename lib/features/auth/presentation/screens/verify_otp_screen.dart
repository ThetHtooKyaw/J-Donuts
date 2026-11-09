import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';
import '../widgets/auth_scaffold.dart';

class VerifyOtpScreen extends StatefulWidget {
  const VerifyOtpScreen({super.key});

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  final _formKey = GlobalKey<FormState>();
  final List<TextEditingController> _controllers = List.generate(
    6,
    (_) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());

  // Countdown timer for 5:00
  int _secondsRemaining = 300;
  Timer? _timer;
  bool _canResend = false;

  @override
  void initState() {
    super.initState();
    _startCountdown();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _focusNodes.first.requestFocus();
      }
    });
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }

    _timer?.cancel();
    super.dispose();
  }

  void _startCountdown() {
    setState(() {
      _secondsRemaining = 300;
      _canResend = false;
    });
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() {
          _secondsRemaining--;
        });
      } else {
        setState(() {
          _canResend = true;
        });
        timer.cancel();
      }
    });
  }

  String get _formattedTime {
    final minutes = _secondsRemaining ~/ 60;
    final seconds = _secondsRemaining % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

  void _onDigitChanged(String value, int index) {
    if (value.length == 1 && index < 5) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          _focusNodes[index + 1].requestFocus();
        }
      });
    }

    // Check if all 6 boxes are filled to trigger verification automatically
    String otpCode = _controllers.map((c) => c.text).join();
    if (otpCode.length == 6) {
      context.read<AuthCubit>().verifyOtp(otpCode);
    }
  }

  KeyEventResult _handleKeyEvent(int index, KeyEvent event) {
    if (event is KeyDownEvent &&
        event.logicalKey == LogicalKeyboardKey.backspace &&
        _controllers[index].text.isEmpty &&
        index > 0) {
      _focusNodes[index - 1].requestFocus();
      return KeyEventResult.handled;
    }

    return KeyEventResult.ignored;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocConsumer<AuthCubit, AuthState>(
      listenWhen: (previous, current) =>
          previous.currentStep != current.currentStep ||
          previous.failedOtpAttempts != current.failedOtpAttempts ||
          (previous.errorMessage != current.errorMessage &&
              current.errorMessage != null &&
              current.failedOtpAttempts == 0),
      listener: (context, state) {
        if (state.currentStep == AuthStep.name) {
          context.pushNamed('name_input');
        }
        if (state.currentStep == AuthStep.completed) {
          context.goNamed('welcome');
        }

        if (state.errorMessage != null && state.failedOtpAttempts > 0) {
          final messenger = ScaffoldMessenger.of(context);
          messenger
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                backgroundColor: theme.colorScheme.error,
                content: Text(state.errorMessage!),
              ),
            );
        }
      },
      builder: (context, state) {
        final showOtpError = state.failedOtpAttempts > 0;

        return AuthScaffold(
          formKey: _formKey,
          progressValue: state.progressPercentage,
          isLoading: state.isLoading,
          onBackPressed: () => context.read<AuthCubit>().goBack(),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text("Verify your number", style: theme.textTheme.displayLarge),
                const SizedBox(height: 12),

                // Instructional text
                Text(
                  "We've sent 6 digit OTP to +95${state.phoneNumber}",
                  style: theme.textTheme.bodyLarge,
                ),
                const SizedBox(height: 30),

                // 6 OTP Input Boxes
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(6, (index) {
                    return SizedBox(
                      width: 48,
                      height: 60,
                      child: TextFormField(
                        controller: _controllers[index],
                        focusNode: _focusNodes[index]
                          ..onKeyEvent = (node, event) =>
                              _handleKeyEvent(index, event),
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        textAlignVertical: TextAlignVertical.center,
                        textInputAction: TextInputAction.next,
                        maxLength: 1,
                        autofocus: index == 0,
                        autofillHints: const [AutofillHints.oneTimeCode],
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        cursorColor: theme.colorScheme.primary,
                        cursorWidth: 2,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 14),
                          counterText: "",
                        ),
                        onTap: () => _focusNodes[index].requestFocus(),
                        onChanged: (value) => _onDigitChanged(value, index),
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 10),

                // Validation error message
                showOtpError
                    ? Text(
                        state.failedOtpAttempts > 0
                            ? (state.errorMessage ??
                                  "Incorrect code. Please try again.")
                            : "Enter the 6-digit code sent to your phone.",
                        style: TextStyle(
                          color: theme.colorScheme.error,
                          fontSize: 12,
                        ),
                      )
                    : const SizedBox.shrink(),
                const SizedBox(height: 20),

                // Resend code section
                Text.rich(
                  TextSpan(
                    text: "Didn't receive the code?\n",
                    style: theme.textTheme.bodyLarge,
                    children: [
                      WidgetSpan(
                        child: GestureDetector(
                          onTap: _canResend
                              ? () {
                                  context.read<AuthCubit>().submitPhoneNumber();
                                  _startCountdown();
                                }
                              : null,
                          child: _canResend
                              ? Text(
                                  "Resend code",
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    height: 1.3,
                                    color: theme.colorScheme.onSecondary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              : Text.rich(
                                  TextSpan(
                                    text: "resend in ",
                                    style: theme.textTheme.bodyLarge,
                                    children: [
                                      TextSpan(
                                        text: _formattedTime,
                                        style: theme.textTheme.bodyMedium
                                            ?.copyWith(
                                              height: 1.3,
                                              color:
                                                  theme.colorScheme.onSecondary,
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                      TextSpan(
                                        text: " min",
                                        style: theme.textTheme.bodyLarge,
                                      ),
                                    ],
                                  ),
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
