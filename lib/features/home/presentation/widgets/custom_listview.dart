import 'package:flutter/material.dart';

import 'pill_container.dart';

class CustomListview extends StatelessWidget {
  final List items;
  final double imageHeight;
  final double width;
  final bool hasDiscountBorder;
  const CustomListview({
    super.key,
    required this.items,
    required this.imageHeight,
    required this.width,
    this.hasDiscountBorder = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const textHeight = 64.0;

    return SizedBox(
      height: imageHeight + textHeight,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        separatorBuilder: (_, _) => const SizedBox(width: 20),
        itemBuilder: (context, index) {
          final item = items[index];
          return SizedBox(
            width: width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product Image
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        item.imageUrl,
                        height: imageHeight,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),

                    // Discount Badge
                    if (item.discountPercent != null)
                      Positioned(
                        right: 8,
                        bottom: 8,
                        child: PillContainer(
                          text: "${item.discountPercent}% off",
                          hasBorder: hasDiscountBorder,
                        ),
                      ),
                  ],
                ),

                // Product Name
                SizedBox(
                  height: textHeight,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        item.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
