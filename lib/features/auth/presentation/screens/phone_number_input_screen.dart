import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/widgets/app_snack_bar.dart';
import '../../domain/validators/auth_validators.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';
import '../widgets/auth_scaffold.dart';
import '../widgets/auth_textfield.dart';

class PhoneNumberInputScreen extends StatefulWidget {
  final bool isLogin;

  const PhoneNumberInputScreen({super.key, this.isLogin = false});

  @override
  State<PhoneNumberInputScreen> createState() => _PhoneNumberInputScreenState();
}

class _PhoneNumberInputScreenState extends State<PhoneNumberInputScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    context.read<AuthCubit>().setLoginMode(widget.isLogin);
  }

  Future<void> _submitPhoneNumber() async {
    final cubit = context.read<AuthCubit>();
    final hasDifferentNumber = await cubit.hasDifferentRegisteredPhone();

    final createNewAccount = hasDifferentNumber && mounted
        ? await _confirmNewNumber(context)
        : false;

    if (createNewAccount == true) {
      cubit.setLoginMode(false);
    } else if (hasDifferentNumber) {
      return;
    }

    final otpRequested = await cubit.submitPhoneNumber();
    if (!mounted) {
      return;
    }
    if (otpRequested) {
      context.goNamed('verify_otp');
      return;
    }
    if (!cubit.state.isLogin) return;

    final createAccount = await _confirmNewNumber(context);
    if (!mounted || createAccount != true) {
      return;
    }

    cubit.setLoginMode(false);
    final registrationOtpRequested = await cubit.submitPhoneNumber();
    if (mounted && registrationOtpRequested) {
      context.goNamed('verify_otp');
    }
  }

  Future<bool?> _confirmNewNumber(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Different phone number',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        content: Text(
          "This number is different from the one saved to your account. "
          'Would you like to create a new account with it?',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Create'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocConsumer<AuthCubit, AuthState>(
      listenWhen: (previous, current) =>
          previous.errorMessage != current.errorMessage,
      listener: (context, state) {
        if (state.errorMessage != null && !state.isLogin) {
          showErrorSnackBar(context, state.errorMessage!);
        }
      },
      builder: (context, state) {
        return AuthScaffold(
          formKey: _formKey,
          progressValue: state.progressPercentage,
          isLoading: state.isLoading,
          onBackPressed: () {
            context.read<AuthCubit>().goBack();
            context.goNamed('onboarding');
          },
          primaryButtonText: "CONTINUE",
          onPrimaryButtonPressed: () {
            if (_formKey.currentState?.validate() ?? false) {
              _submitPhoneNumber();
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text(
                  "Enter your phone\nnumber",
                  style: theme.textTheme.displayLarge,
                ),
                const SizedBox(height: 30),

                // Phone Field with +95 Prefix
                AuthTextfield(
                  hintText: "09254135592",
                  keyboardType: TextInputType.phone,
                  prefixIcon: Text(
                    "+95",
                    style: GoogleFonts.quicksand(
                      color: theme.colorScheme.onInverseSurface,
                      fontSize: 18,
                    ),
                  ),
                  onValidate: (value) => AuthValidators.validatePhone(value),
                  onChanged: (value) =>
                      context.read<AuthCubit>().updatePhoneNumber(value),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
