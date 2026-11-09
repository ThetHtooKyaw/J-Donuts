class MemberProfile {
  final String name;
  final String tier;
  final int pointsToNextTier;
  final int totalPoints;
  final String avatarUrl;
  final int notificationCount;

  const MemberProfile({
    required this.name,
    required this.tier,
    required this.pointsToNextTier,
    required this.totalPoints,
    required this.avatarUrl,
    required this.notificationCount,
  });
}
