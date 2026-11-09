import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/widgets/app_snack_bar.dart';
import '../../domain/validators/auth_validators.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';
import '../widgets/auth_scaffold.dart';
import '../widgets/auth_textfield.dart';

class NameInputScreen extends StatefulWidget {
  const NameInputScreen({super.key});

  @override
  State<NameInputScreen> createState() => _NameInputScreenState();
}

class _NameInputScreenState extends State<NameInputScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocConsumer<AuthCubit, AuthState>(
      listenWhen: (previous, current) =>
          previous.currentStep != current.currentStep ||
          previous.errorMessage != current.errorMessage,
      listener: (context, state) {
        if (state.currentStep == AuthStep.dob) {
          context.pushNamed('dob_input');
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
              final lastName = _lastNameController.text.trim();

              context.read<AuthCubit>().setName(
                _firstNameController.text.trim(),
                lastName.isEmpty ? null : lastName,
              );
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text(
                  "What's your\nname?",
                  style: theme.textTheme.displayLarge?.copyWith(height: 1.5),
                ),
                const SizedBox(height: 30),

                // First Name Field
                AuthTextfield(
                  hintText: "First Name",
                  controller: _firstNameController,
                  keyboardType: TextInputType.text,
                  onValidate: (value) =>
                      AuthValidators.validateFirstName(value),
                ),
                const SizedBox(height: 20),

                // Last Name Field
                AuthTextfield(
                  hintText: "Last Name",
                  controller: _lastNameController,
                  keyboardType: TextInputType.text,
                  onValidate: (value) => AuthValidators.validateLastName(value),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
