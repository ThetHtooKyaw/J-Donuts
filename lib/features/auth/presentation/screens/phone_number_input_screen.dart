import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:j_donuts/features/auth/presentation/widgets/auth_textfield.dart';
import '../../domain/validators/auth_validators.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';
import '../widgets/auth_scaffold.dart';

class PhoneNumberInputScreen extends StatefulWidget {
  const PhoneNumberInputScreen({super.key});

  @override
  State<PhoneNumberInputScreen> createState() => _PhoneNumberInputScreenState();
}

class _PhoneNumberInputScreenState extends State<PhoneNumberInputScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state.currentStep == AuthStep.otp) {
          context.pushNamed('verify_otp');
        }

        if (state.errorMessage != null) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
        }
      },
      builder: (context, state) {
        return AuthScaffold(
          formKey: _formKey,
          progressValue: state.progressPercentage,
          isLoading: state.isLoading,
          onBackPressed: () => context.read<AuthCubit>().goBack(),
          primaryButtonText: "CONTINUE",
          onPrimaryButtonPressed: () {
            if (_formKey.currentState?.validate() ?? false) {
              context.read<AuthCubit>().submitPhoneNumber();
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
                  style: TextStyle(
                    color: theme.colorScheme.onSurface,
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 30),

                // Phone Field with +95 Prefix
                AuthTextfield(
                  hintText: "09254135592",
                  keyboardType: TextInputType.phone,
                  prefixIcon: Text(
                    "+95",
                    style: TextStyle(
                      color: theme.colorScheme.onInverseSurface,
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
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
