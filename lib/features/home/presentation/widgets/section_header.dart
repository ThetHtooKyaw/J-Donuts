import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const SectionHeader({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Section Title
          Text(title, style: theme.textTheme.displayMedium),

          // See All Button
          InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(20),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: const Icon(
                Icons.arrow_forward_ios,
                size: 14,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
