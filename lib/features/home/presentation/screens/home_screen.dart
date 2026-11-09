import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:j_donuts/features/home/presentation/widgets/custom_listview.dart';
import 'package:j_donuts/features/home/presentation/widgets/shop_card.dart';

import '../../../../core/widgets/app_snack_bar.dart';
import '../../domain/entities/member_profile.dart';
import '../../domain/entities/shop.dart';
import '../cubit/home_cubit.dart';
import '../cubit/home_state.dart';
import '../widgets/pill_container.dart';
import '../widgets/section_header.dart';
import '../widgets/home_skeletons.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<HomeCubit>().loadHomeData();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.onBackground,
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const HomeSkeleton();
          }

          if (state.errorMessage != null && state.data == null) {
            return SectionErrorState(message: state.errorMessage!);
          }

          final data = state.data;
          if (data == null) return const SizedBox.shrink();

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Card
                _buildHeaderCard(context, theme, data.profile),
                const SizedBox(height: 30),

                // Seasonal Section
                SectionHeader(
                  title: "Seasonal specials",
                  onTap: () => showComingSoonSnackBar(
                    context,
                    "Seasonal specials screen is coming soon.",
                  ),
                ),
                const SizedBox(height: 20),

                data.seasonalSpecials.isEmpty
                    ? const SectionEmptyState(
                        message: 'No seasonal specials available.',
                      )
                    : CustomListview(
                        items: data.seasonalSpecials,
                        imageHeight: 180,
                        width: 280,
                        hasDiscountBorder: true,
                      ),
                const SizedBox(height: 20),

                // Popular Section
                SectionHeader(
                  title: "Popular 🔥",
                  onTap: () => showComingSoonSnackBar(
                    context,
                    "Popular screen is coming soon.",
                  ),
                ),
                const SizedBox(height: 20),

                data.popular.isEmpty
                    ? const SectionEmptyState(
                        message: 'No popular products available.',
                      )
                    : CustomListview(
                        items: data.popular,
                        imageHeight: 280,
                        width: 170,
                      ),
                const SizedBox(height: 20),

                // Order Again Section
                SectionHeader(
                  title: "Order again",
                  onTap: () => showComingSoonSnackBar(
                    context,
                    "Order again screen is coming soon.",
                  ),
                ),
                const SizedBox(height: 20),

                data.orderAgain.isEmpty
                    ? const SectionEmptyState(
                        message: 'You have no previous orders yet.',
                      )
                    : CustomListview(
                        items: data.orderAgain,
                        imageHeight: 180,
                        width: 170,
                      ),
                const SizedBox(height: 30),

                // Shops Section
                data.shops.isEmpty
                    ? const SectionEmptyState(
                        message: 'No nearby shops available.',
                      )
                    : _buildShopsSection(theme, data.shops),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeaderCard(
    BuildContext context,
    ThemeData theme,
    MemberProfile profile,
  ) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 60, 0, 0),
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(
        color: Color(0xFFffecdc),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(28),
          bottomRight: Radius.circular(28),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // User Info
          Row(
            children: [
              // User Avatar
              CircleAvatar(
                radius: 36,
                backgroundImage: AssetImage(profile.avatarUrl),
              ),
              const SizedBox(width: 20),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // User Name
                    Text(profile.name, style: theme.textTheme.displayMedium),

                    // User Tier
                    Text(
                      '${profile.tier} member',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              // Notification Badge
              Container(
                height: 44,
                width: 80,
                decoration: BoxDecoration(
                  color: theme.colorScheme.onSecondaryContainer,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    bottomLeft: Radius.circular(24),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Notification Icon
                    const Icon(
                      Icons.notifications_outlined,
                      color: Colors.white,
                      size: 32,
                    ),
                    const SizedBox(width: 6),

                    // Notification Count
                    if (profile.notificationCount > 0)
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          '${profile.notificationCount}',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Points Pill Banner
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '${profile.pointsToNextTier} points left to become Gold Member',
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Promotional Banners Carousel
          SizedBox(
            height: 180,
            child: ListView(
              scrollDirection: Axis.horizontal,
              clipBehavior: Clip.none,
              children: [
                _buildPromoCard(
                  theme: theme,
                  badge: "New shop",
                  image: 'assets/images/home_banner1.png',
                ),
                const SizedBox(width: 20),

                _buildPromoCard(
                  theme: theme,
                  badge: "50% off",
                  image: 'assets/images/home_banner2.png',
                ),
                const SizedBox(width: 20),

                _buildPromoCard(
                  theme: theme,
                  badge: "50% off",
                  image: 'assets/images/home_banner3.png',
                ),
                const SizedBox(width: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPromoCard({
    required ThemeData theme,
    required String badge,
    required String image,
  }) {
    return SizedBox(
      width: 320,
      height: 180,
      child: Stack(
        children: [
          // Promo Background Image
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              child: Image.asset(
                image,
                fit: BoxFit.fitWidth,
                alignment: const Alignment(0, -0.7),
              ),
            ),
          ),

          // Badge
          Positioned(
            top: 14,
            left: 0,
            right: 0,
            child: Center(
              child: PillContainer(
                text: badge,
                smallContainer: true,
                hasBorder: true,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShopsSection(ThemeData theme, List<Shop> shops) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/home_bottom_banner.png'),
          fit: BoxFit.cover,
          alignment: Alignment(0, -0.5),
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Title
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: RichText(
              text: TextSpan(
                style: GoogleFonts.fredoka(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  height: 1.3,
                ),
                children: [
                  TextSpan(text: 'There are ${shops.length} J\'Donut shops\n'),
                  const TextSpan(text: 'near you.😋'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Explore Now Button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ElevatedButton(
              onPressed: () => showComingSoonSnackBar(
                context,
                "Explore Now screen is coming soon.",
              ),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(40, 44),
                backgroundColor: theme.colorScheme.surface,
                foregroundColor: theme.colorScheme.primary,
              ),
              child: Text(
                'EXPLORE NOW',
                style: GoogleFonts.fredoka(
                  fontSize: 16,
                  letterSpacing: 1.2,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Horizontal Shops Carousel
          SizedBox(
            height: 330,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              scrollDirection: Axis.horizontal,
              itemCount: shops.length,
              separatorBuilder: (_, _) => const SizedBox(width: 20),
              itemBuilder: (context, index) {
                return ShopCard(shop: shops[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
