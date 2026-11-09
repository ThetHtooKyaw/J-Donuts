import 'package:flutter/material.dart';

class HomeSkeleton extends StatelessWidget {
  const HomeSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          _HeaderSkeleton(),
          SizedBox(height: 30),
          ProductSectionSkeleton(
            titleWidth: 150,
            cardWidth: 280,
            imageHeight: 180,
          ),
          ProductSectionSkeleton(
            titleWidth: 110,
            cardWidth: 170,
            imageHeight: 280,
          ),
          ProductSectionSkeleton(
            titleWidth: 130,
            cardWidth: 170,
            imageHeight: 180,
          ),
          ShopsSectionSkeleton(),
        ],
      ),
    );
  }
}

class _HeaderSkeleton extends StatelessWidget {
  const _HeaderSkeleton();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 420,
      padding: const EdgeInsets.fromLTRB(20, 60, 20, 20),
      decoration: const BoxDecoration(
        color: Color(0xFFffecdc),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(28)),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SkeletonBox(width: 72, height: 72, radius: 36),
              SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SkeletonBox(width: 130, height: 24),
                  SizedBox(height: 10),
                  SkeletonBox(width: 90, height: 16),
                ],
              ),
            ],
          ),
          SizedBox(height: 24),
          SkeletonBox(width: 220, height: 34, radius: 20),
          SizedBox(height: 24),
          SkeletonBox(width: double.infinity, height: 180, radius: 20),
        ],
      ),
    );
  }
}

class ProductSectionSkeleton extends StatelessWidget {
  final double titleWidth;
  final double cardWidth;
  final double imageHeight;

  const ProductSectionSkeleton({
    super.key,
    required this.titleWidth,
    required this.cardWidth,
    required this.imageHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: SkeletonBox(width: titleWidth, height: 24),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: imageHeight + 64,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              scrollDirection: Axis.horizontal,
              itemCount: 2,
              separatorBuilder: (_, _) => const SizedBox(width: 20),
              itemBuilder: (_, _) => SizedBox(
                width: cardWidth,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SkeletonBox(
                      width: cardWidth,
                      height: imageHeight,
                      radius: 20,
                    ),
                    const SizedBox(height: 10),
                    const SkeletonBox(width: 130, height: 18),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ShopsSectionSkeleton extends StatelessWidget {
  const ShopsSectionSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: SkeletonBox(width: 230, height: 52),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 330,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              scrollDirection: Axis.horizontal,
              itemCount: 2,
              separatorBuilder: (_, _) => const SizedBox(width: 20),
              itemBuilder: (_, _) => const SizedBox(
                width: 320,
                child: Column(
                  children: [
                    SkeletonBox(width: 320, height: 180, radius: 20),
                    SizedBox(height: 12),
                    SkeletonBox(width: 180, height: 18),
                    SizedBox(height: 10),
                    SkeletonBox(width: 240, height: 16),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SectionEmptyState extends StatelessWidget {
  final String message;

  const SectionEmptyState({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Text(message, style: Theme.of(context).textTheme.bodyMedium),
    );
  }
}

class SectionErrorState extends StatelessWidget {
  final String message;

  const SectionErrorState({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        children: [
          const Icon(Icons.error_outline, color: Colors.redAccent),
          const SizedBox(width: 8),
          Expanded(child: Text(message)),
        ],
      ),
    );
  }
}

class SkeletonBox extends StatelessWidget {
  final double width;
  final double height;
  final double radius;

  const SkeletonBox({
    super.key,
    required this.width,
    required this.height,
    this.radius = 8,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }
}
