import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/widgets/app_snack_bar.dart';
import '../../domain/validators/auth_validators.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';
import '../widgets/auth_scaffold.dart';
import '../widgets/auth_textfield.dart';

class DOBInputScreen extends StatefulWidget {
  const DOBInputScreen({super.key});

  @override
  State<DOBInputScreen> createState() => _DOBInputScreenState();
}

class _DOBInputScreenState extends State<DOBInputScreen> {
  final _formKey = GlobalKey<FormState>();
  final _dayController = TextEditingController();
  final _monthController = TextEditingController();
  final _yearController = TextEditingController();

  @override
  void dispose() {
    _dayController.dispose();
    _monthController.dispose();
    _yearController.dispose();
    super.dispose();
  }

  String? _validateCompleteDate(String? value) {
    final yearError = AuthValidators.validateBirthYear(value);
    if (yearError != null) {
      return yearError;
    }

    final month = AuthValidators.parseBirthMonth(_monthController.text);
    final day = int.tryParse(_dayController.text.trim());
    final year = int.tryParse(value!.trim());
    if (month == null || day == null || year == null) {
      return null;
    }

    final dateOfBirth = DateTime(year, month, day);
    if (dateOfBirth.year != year ||
        dateOfBirth.month != month ||
        dateOfBirth.day != day) {
      return 'Enter a valid date';
    }

    return AuthValidators.validateDateOfBirth(dateOfBirth);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocConsumer<AuthCubit, AuthState>(
      listenWhen: (previous, current) =>
          previous.currentStep != current.currentStep ||
          previous.errorMessage != current.errorMessage,
      listener: (context, state) {
        if (state.currentStep == AuthStep.completed) {
          context.pushNamed('welcome');
        }

        if (state.errorMessage != null) {
          showErrorSnackBar(context, state.errorMessage!);
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
              final month = AuthValidators.parseBirthMonth(
                _monthController.text,
              );
              final day = int.parse(_dayController.text.trim());
              final year = int.parse(_yearController.text.trim());
              final dateOfBirth = DateTime(year, month!, day);

              context.read<AuthCubit>().completeRegistration(dateOfBirth);
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text(
                  "What's your\ndate of birth?",
                  style: theme.textTheme.displayLarge?.copyWith(height: 1.5),
                ),
                const SizedBox(height: 30),

                // Month Field
                AuthTextfield(
                  hintText: "May",
                  controller: _monthController,
                  keyboardType: TextInputType.text,
                  onValidate: AuthValidators.validateBirthMonth,
                ),
                const SizedBox(height: 20),

                // Day Field
                AuthTextfield(
                  hintText: "1",
                  controller: _dayController,
                  keyboardType: TextInputType.number,
                  onValidate: AuthValidators.validateBirthDay,
                ),
                const SizedBox(height: 20),

                // Year Field
                AuthTextfield(
                  hintText: "1998",
                  controller: _yearController,
                  keyboardType: TextInputType.number,
                  onValidate: _validateCompleteDate,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
