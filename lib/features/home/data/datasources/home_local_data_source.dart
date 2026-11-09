// import 'drift_database.dart';

// abstract class HomeLocalDataSource {
//   Future<MemberTableData?> getMemberProfile();
//   Future<List<ProductsTableData>> getProductsByCategory(String category);
//   Future<List<ShopsTableData>> getNearbyShops();
// }

// class HomeLocalDataSourceImpl implements HomeLocalDataSource {
//   final AppDatabase database;

//   HomeLocalDataSourceImpl({required this.database});

//   @override
//   Future<MemberTableData?> getMemberProfile() => database.getMember();

//   @override
//   Future<List<ProductsTableData>> getProductsByCategory(String category) =>
//       database.getProductsByCategory(category);

//   @override
//   Future<List<ShopsTableData>> getNearbyShops() => database.getAllShops();
// }
