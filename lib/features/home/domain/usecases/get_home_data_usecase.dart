import '../entities/member_profile.dart';
import '../entities/product.dart';
import '../entities/shop.dart';
import '../repositories/home_repository.dart';

class GetHomeDataUsecase {
  final HomeRepository repository;
  GetHomeDataUsecase(this.repository);

  Future<HomeDataResult> call() async {
    final profile = await repository.getMemberProfile();
    final seasonal = await repository.getProductsByCategory('seasonal');
    final popular = await repository.getProductsByCategory('popular');
    final orderAgain = await repository.getProductsByCategory('order_again');
    final shops = await repository.getNearbyShops();

    return HomeDataResult(
      profile: profile,
      seasonalSpecials: seasonal,
      popular: popular,
      orderAgain: orderAgain,
      shops: shops,
    );
  }
}

class HomeDataResult {
  final MemberProfile profile;
  final List<Product> seasonalSpecials;
  final List<Product> popular;
  final List<Product> orderAgain;
  final List<Shop> shops;

  HomeDataResult({
    required this.profile,
    required this.seasonalSpecials,
    required this.popular,
    required this.orderAgain,
    required this.shops,
  });
}
