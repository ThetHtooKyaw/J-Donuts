class MemberProfile {
  final String name;
  final String? phoneNumber;
  final DateTime? dateOfBirth;
  final String tier;
  final int pointsToNextTier;
  final int totalPoints;
  final String avatarUrl;
  final int notificationCount;

  const MemberProfile({
    required this.name,
    this.phoneNumber,
    this.dateOfBirth,
    required this.tier,
    required this.pointsToNextTier,
    required this.totalPoints,
    required this.avatarUrl,
    required this.notificationCount,
  });
}
