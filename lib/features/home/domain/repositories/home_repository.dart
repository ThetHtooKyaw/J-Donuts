import '../entities/member_profile.dart';
import '../entities/product.dart';
import '../entities/shop.dart';

abstract class HomeRepository {
  Future<MemberProfile> getMemberProfile();

  Future<List<Product>> getProductsByCategory(String category);

  Future<List<Shop>> getNearbyShops();

  Future<void> refreshHomeData();
}
