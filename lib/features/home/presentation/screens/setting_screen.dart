import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/widgets/app_snack_bar.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../auth/presentation/cubit/auth_cubit.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool _notificationsEnabled = true;

  Future<void> _logout(BuildContext context) async {
    try {
      await context.read<AuthCubit>().logout();
      if (context.mounted) context.go('/onboarding');
    } catch (_) {
      if (context.mounted) {
        showComingSoonSnackBar(context, 'Could not log out. Please try again.');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            // Title
            Center(
              child: Text("Settings", style: theme.textTheme.displayLarge),
            ),
            const SizedBox(height: 40),

            // Notification Settings
            Card(
              color: theme.colorScheme.surface,
              child: ListTile(
                leading: Icon(
                  Icons.notifications_outlined,
                  color: theme.colorScheme.secondary,
                ),
                title: Text('Notifications', style: theme.textTheme.bodyLarge),
                subtitle: Text(
                  'Manage notification preferences',
                  style: theme.textTheme.bodyMedium,
                ),
                trailing: Switch(
                  value: _notificationsEnabled,
                  onChanged: (value) {
                    setState(() => _notificationsEnabled = value);
                  },
                ),
              ),
            ),
            const SizedBox(height: 10),

            // About Settings
            Card(
              color: theme.colorScheme.surface,
              child: ListTile(
                leading: Icon(
                  Icons.info_outline,
                  color: theme.colorScheme.secondary,
                ),
                title: Text('About J\'Donut', style: theme.textTheme.bodyLarge),
                subtitle: Text(
                  'Version 1.0.0',
                  style: theme.textTheme.bodyMedium,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Logout Button
            PrimaryButton(text: 'Logout', onPressed: () => _logout(context)),
          ],
        ),
      ),
    );
  }
}
