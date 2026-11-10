import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:j_donuts/features/reward/presentation/widgets/quest_card.dart';

import '../../../../core/widgets/noti_container.dart';
import '../widgets/donut_progress_widget.dart';
import '../widgets/donut_ring_progress_widget.dart';
import '../widgets/drink_progress_widget.dart';
import '../widgets/tier_progress_widget.dart';

class RewardsScreen extends StatefulWidget {
  const RewardsScreen({super.key});

  @override
  State<RewardsScreen> createState() => _RewardsScreenState();
}

class _RewardsScreenState extends State<RewardsScreen> {
  int _selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.onBackground,
      appBar: AppBar(
        backgroundColor: theme.colorScheme.surface,
        // Title
        title: Text("J' Donuts Rewards", style: theme.textTheme.titleLarge),
        actions: [
          // Reward Badge
          NotiContainer(
            widget: Text(
              'Rewards ',
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.surface,
                fontWeight: FontWeight.bold,
              ),
            ),
            count: 3,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 20),
        child: Column(
          children: [
            // Top Section
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 40, 0, 80),
                  color: Colors.white,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      // Tier Progress Tracker
                      Padding(
                        padding: const EdgeInsets.only(right: 140),
                        child: TierProgressWidget(
                          steps: [
                            TierStep(
                              title: 'Silver',
                              subtitle: "You're here now",
                              tireIcon: 'assets/images/tier1.png',
                              color: Color(0xFFbdbebe),
                              isCurrent: true,
                              isAchieved: true,
                              progress: 0.68, // 68% progress towards next tier
                            ),
                            TierStep(
                              title: 'Gold',
                              subtitle: '500 pts Remaining\nto become Gold',
                              tireIcon: 'assets/images/tier2.png',
                              color: Color(0xFFf0e7bb),
                              isAchieved: false,
                            ),
                            TierStep(
                              title: 'Platinum',
                              subtitle: "You'll be here soon",
                              tireIcon: 'assets/images/tier3.png',
                              color: Color(0xFFbdbebe),
                              isAchieved: false,
                            ),
                          ],
                        ),
                      ),

                      // Points Tracker (Donut Ring Progress Widget)
                      Positioned(
                        right: -30,
                        top: -10,
                        child: DonutRingProgressWidget(
                          currentPoints: 680000,
                          maxPoints: 1000000,
                          size: 240,
                        ),
                      ),
                    ],
                  ),
                ),

                Positioned(
                  bottom: -22,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Tab 1: Eat more earn more
                        _buildTabButton(
                          theme: theme,
                          title: 'Eat more earn more',
                          isSelected: _selectedTabIndex == 0,
                          onTap: () {
                            setState(() {
                              _selectedTabIndex = 0;
                            });
                          },
                        ),
                        const SizedBox(width: 10),

                        // Tab 2: Gift
                        _buildTabButton(
                          theme: theme,
                          title: 'Gift',
                          isSelected: _selectedTabIndex == 1,
                          onTap: () {
                            setState(() {
                              _selectedTabIndex = 1;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),

            // Conditional Content based on Selected Tab
            if (_selectedTabIndex == 0) ...[
              // Quest Item 1: Donut (4/4 Completed)
              QuestCard(
                title: 'Eat 4 Coco donuts',
                current: 4,
                total: 4,
                points: '100 pts',
                progressWidget: const DonutProgressWidget(current: 4, total: 4),
              ),
              const SizedBox(height: 20),

              // Quest Item 2: Donut (1/4 In Progress)
              QuestCard(
                title: 'Eat 4 Coco donuts',
                current: 1,
                total: 4,
                points: '100 pts',
                progressWidget: const DonutProgressWidget(current: 1, total: 4),
              ),
              const SizedBox(height: 20),

              // Quest Item 3: Drink (9/12 Curved Arc)
              QuestCard(
                title: 'Drink 12 cups americano',
                current: 9,
                total: 12,
                points: '100 pts',
                progressWidget: const DrinkProgressWidget(
                  imagePath: 'assets/images/product2.png',
                  current: 9,
                  total: 12,
                ),
              ),
            ] else ...[
              // Gift Tab Content View
              Padding(
                padding: const EdgeInsets.all(40.0),
                child: Center(
                  child: Text(
                    "No gifts available yet!",
                    style: theme.textTheme.bodyLarge,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildTabButton({
    required ThemeData theme,
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? theme.colorScheme.primary : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: theme.colorScheme.surface, width: 3),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(15),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Text(
          title,
          style: GoogleFonts.fredoka(
            color: isSelected
                ? theme.colorScheme.surface
                : theme.colorScheme.onSurface,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
