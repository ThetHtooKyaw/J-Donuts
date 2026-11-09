import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'app_snack_bar.dart';

class AppBottomNavBar extends StatelessWidget {
  final int currentIndex;

  const AppBottomNavBar({super.key, required this.currentIndex});

  void _handleTap(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go('/home');
      case 4:
        context.go('/settings');
      default:
        showComingSoonSnackBar(context, 'This section is coming soon.');
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      color: Colors.transparent,
      height: 100,
      child: Stack(
        children: [
          // Background Color
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: 50,
            child: ColoredBox(color: theme.colorScheme.secondary),
          ),

          // Bottom Navigation Bar
          Positioned(
            left: 14,
            right: 14,
            bottom: 0,
            child: Container(
              height: 100,
              decoration: BoxDecoration(
                color: theme.colorScheme.primary,
                border: Border.all(color: theme.colorScheme.surface, width: 2),
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(30),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildNavItem(
                    theme: theme,
                    icon: Icons.home_rounded,
                    label: 'Home',
                    isSelected: currentIndex == 0,
                    onTap: () => _handleTap(context, 0),
                  ),
                  _buildNavItem(
                    theme: theme,
                    icon: Icons.emoji_events_outlined,
                    label: 'Rewards',
                    isSelected: currentIndex == 1,
                    onTap: () => _handleTap(context, 1),
                  ),
                  _buildNavItem(
                    theme: theme,
                    icon: Icons.catching_pokemon,
                    isSelected: currentIndex == 2,
                    onTap: () => _handleTap(context, 2),
                  ),
                  _buildNavItem(
                    theme: theme,
                    icon: Icons.account_balance_wallet_outlined,
                    label: 'Wallet',
                    isSelected: currentIndex == 3,
                    onTap: () => _handleTap(context, 3),
                  ),
                  _buildNavItem(
                    theme: theme,
                    icon: Icons.settings_outlined,
                    label: 'Settings',
                    isSelected: currentIndex == 4,
                    onTap: () => _handleTap(context, 4),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildNavItem({
  required ThemeData theme,
  required IconData icon,
  String? label,
  required bool isSelected,
  required VoidCallback onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    behavior: HitTestBehavior.opaque,
    child: AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: EdgeInsets.symmetric(
        horizontal: isSelected ? 16 : 10,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: isSelected ? theme.colorScheme.secondary : Colors.transparent,
        border: Border.all(
          color: isSelected ? theme.colorScheme.surface : Colors.transparent,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white, size: 24),
          if (isSelected && label != null) ...[
            const SizedBox(width: 6),
            Text(
              label,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.surface,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ],
      ),
    ),
  );
}
