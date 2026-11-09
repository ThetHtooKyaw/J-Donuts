import 'package:flutter/material.dart';

import '../../../../core/widgets/app_snack_bar.dart';
import '../../domain/entities/shop.dart';

class ShopCard extends StatelessWidget {
  final Shop shop;
  const ShopCard({super.key, required this.shop});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: 320,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Shop Image
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(
              shop.imageUrl,
              height: 180,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) => Container(
                height: 180,
                color: theme.colorScheme.onInverseSurface,
                child: const Icon(Icons.store, color: Colors.grey),
              ),
            ),
          ),
          const SizedBox(height: 8),

          // Shop Name
          Text(
            shop.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),

          // Address
          Text(
            shop.address,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onInverseSurface,
            ),
          ),
          // Order Online Button
          GestureDetector(
            onTap: () => showComingSoonSnackBar(
              context,
              'Order Online feature is coming soon!',
            ),
            child: Text(
              'Order Online',
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.secondary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
