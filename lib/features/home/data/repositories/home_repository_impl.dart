import '../../domain/entities/member_profile.dart';
import '../../domain/entities/product.dart';
import '../../domain/entities/shop.dart';
import '../../domain/repositories/home_repository.dart';
import '../datasources/home_local_data_source.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeLocalDataSource localDataSource;
  HomeRepositoryImpl({required this.localDataSource});

  @override
  Future<MemberProfile> getMemberProfile() async {
    final data = await localDataSource.getMemberProfile();

    if (data == null) {
      throw Exception('Member profile not found in local database.');
    }

    return MemberProfile(
      name: data.name,
      phoneNumber: data.phoneNumber,
      dateOfBirth: data.dateOfBirth,
      tier: data.tier,
      pointsToNextTier: data.pointsToNextTier,
      totalPoints: data.totalPoints,
      avatarUrl: data.avatarUrl,
      notificationCount: data.notificationCount,
    );
  }

  @override
  Future<List<Product>> getProductsByCategory(String category) async {
    final results = await localDataSource.getProductsByCategory(category);
    return results
        .map(
          (row) => Product(
            id: row.id,
            code: row.code,
            name: row.name,
            priceMmk: row.priceMmk,
            isNew: row.isNew,
            discountPercent: row.discountPercent,
            imageUrl: row.imageUrl,
            description: row.description,
          ),
        )
        .toList();
  }

  @override
  Future<List<Shop>> getNearbyShops() async {
    final results = await localDataSource.getNearbyShops();
    return results
        .map(
          (row) => Shop(
            id: row.id,
            name: row.name,
            address: row.address,
            imageUrl: row.imageUrl,
          ),
        )
        .toList();
  }

  @override
  Future<void> refreshHomeData() async {
    // When online, fetch from mock server and update local database cache[cite: 6, 13]
  }
}
