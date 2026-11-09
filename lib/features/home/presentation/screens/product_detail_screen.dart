import 'package:flutter/material.dart';

import '../../../../core/widgets/app_snack_bar.dart';
import '../widgets/pill_container.dart';

class ProductDetailScreen extends StatefulWidget {
  final String productId;
  final String title;
  final double price;
  final String imageUrl;
  final String description;
  final bool isNew;
  final bool isSpecialCategory;
  const ProductDetailScreen({
    super.key,
    required this.productId,
    required this.title,
    required this.price,
    required this.imageUrl,
    required this.description,
    required this.isNew,
    this.isSpecialCategory = false,
  });

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int _quantity = 1;

  void _increment() {
    setState(() => _quantity++);
  }

  void _decrement() {
    if (_quantity > 1) {
      setState(() => _quantity--);
    }
  }

  void _addToCart() {
    Future<void>.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        showComingSoonSnackBar(context, 'Added to cart!');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final double totalPrice = widget.price * _quantity;
    final String formattedPrice = widget.price.toStringAsFixed(0);
    final String formattedTotal = totalPrice.toStringAsFixed(0);

    return Scaffold(
      backgroundColor: theme.colorScheme.onBackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          style: IconButton.styleFrom(
            backgroundColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0),
              side: BorderSide.none,
            ),
          ),
          icon: Icon(
            Icons.arrow_back,
            color: theme.colorScheme.onSurface,
            size: 30,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.bottomCenter,
                      clipBehavior: Clip.none,
                      children: [
                        // Product Image
                        Container(
                          height: 420,
                          width: double.infinity,
                          margin: const EdgeInsets.only(bottom: 24),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(widget.imageUrl),
                              fit: widget.isSpecialCategory
                                  ? BoxFit.cover
                                  : BoxFit.fitWidth,
                              alignment: Alignment(0, -0.5),
                              onError: (_, _) {},
                            ),
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(28),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.04),
                                blurRadius: 16,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                        ),

                        Positioned(
                          top: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            width: double.infinity,
                            decoration: widget.isSpecialCategory
                                ? BoxDecoration(
                                    color: const Color.fromARGB(
                                      164,
                                      238,
                                      242,
                                      245,
                                    ),
                                    borderRadius: BorderRadius.circular(28),
                                    border: Border.all(
                                      color: theme.colorScheme.surface
                                          .withOpacity(0.5),
                                      width: 1,
                                    ),
                                  )
                                : null,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Top Info Row (ID, Badge)
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    // Product ID
                                    Text(
                                      widget.productId,
                                      style: widget.isSpecialCategory
                                          ? theme.textTheme.bodyMedium
                                                ?.copyWith(
                                                  color: theme
                                                      .colorScheme
                                                      .onSurface,
                                                  fontWeight: FontWeight.bold,
                                                )
                                          : theme.textTheme.bodyMedium
                                                ?.copyWith(
                                                  color: theme
                                                      .colorScheme
                                                      .onInverseSurface,
                                                ),
                                    ),

                                    // New Badge
                                    if (widget.isNew)
                                      PillContainer(
                                        text: 'New',
                                        smallContainer: true,
                                      ),
                                  ],
                                ),
                                const SizedBox(height: 4),

                                // Title
                                Text(
                                  widget.title,
                                  style: theme.textTheme.displayMedium
                                      ?.copyWith(fontSize: 26),
                                ),
                                const SizedBox(height: 4),

                                // Price
                                Text(
                                  '$formattedPrice MMK',
                                  style: theme.textTheme.bodyLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        // Overlapping Quantity Stepper
                        Positioned(
                          bottom: 0,
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFFEEF2F5),
                              borderRadius: BorderRadius.circular(28),
                              border: Border.all(
                                color: theme.colorScheme.surface,
                                width: 3,
                              ),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 6,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // Decrement Button
                                _buildQuantityButton(
                                  icon: Icons.remove,
                                  onTap: _decrement,
                                ),

                                // Quantity Display
                                Container(
                                  constraints: const BoxConstraints(
                                    minWidth: 40,
                                  ),
                                  child: Text(
                                    '$_quantity',
                                    textAlign: TextAlign.center,
                                    style: theme.textTheme.titleLarge,
                                  ),
                                ),

                                // Increment Button
                                _buildQuantityButton(
                                  icon: Icons.add,
                                  onTap: _increment,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),

                    // Bottom Section
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Left Content
                        Column(
                          children: [
                            // Question Icon
                            Container(
                              width: 22,
                              height: 22,
                              decoration: const BoxDecoration(
                                color: Color(0xFF8CC63F),
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Text(
                                  '?',
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    color: theme.colorScheme.surface,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 4),

                            // Text
                            Text(
                              'What’s\nthis?',
                              textAlign: TextAlign.center,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 20),

                        // Vertical Divider
                        Container(
                          width: 2,
                          height: 80,
                          color: theme.colorScheme.surface,
                        ),
                        const SizedBox(width: 20),

                        // Description Text
                        Expanded(
                          child: Text(
                            widget.description,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              height: 1.45,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),

            // Add to Cart Button
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
              child: SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: _addToCart,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Add to Cart Text
                      Text('ADD TO CART'),

                      // Vertical Divider
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        width: 2,
                        height: 20,
                        color: theme.colorScheme.surface,
                      ),

                      // Total Price
                      Text('$formattedTotal MMK'),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuantityButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Material(
      color: const Color(0xFF4FC3F7),
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(icon, color: Colors.white, size: 20),
        ),
      ),
    );
  }
}
