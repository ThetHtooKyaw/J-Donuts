// import 'package:drift/drift.dart';

// part 'drift_database.g.dart';

// // --- TABLE DEFINITIONS ---

// class MemberTable extends Table {
//   TextColumn get id => text()();
//   TextColumn get name => text()();
//   TextColumn get tier => text()();
//   IntColumn get pointsToNextTier => integer()();
//   IntColumn get totalPoints => integer()();
//   TextColumn get avatarUrl => text()();
//   IntColumn get notificationCount => integer()();

//   @override
//   Set<Column> get primaryKey => {id};
// }

// class ProductsTable extends Table {
//   TextColumn get id => text()();
//   TextColumn get code => text()();
//   TextColumn get name => text()();
//   IntColumn get priceMmk => integer()();
//   BoolColumn get isNew => boolean()();
//   IntColumn get discountPercent => integer().nullable()();
//   TextColumn get imageUrl => text()();
//   TextColumn get description => text()();
//   TextColumn get category =>
//       text()(); // e.g., 'seasonal', 'popular', 'order_again'

//   @override
//   Set<Column> get primaryKey => {id};
// }

// class ShopsTable extends Table {
//   TextColumn get id => text()();
//   TextColumn get name => text()();
//   TextColumn get address => text()();
//   TextColumn get imageUrl => text()();

//   @override
//   Set<Column> get primaryKey => {id};
// }

// // --- DRIFT DATABASE ---

// @DriftDatabase(tables: [MemberTable, ProductsTable, ShopsTable])
// class AppDatabase extends _$AppDatabase {
//   AppDatabase(super.e);

//   @override
//   int get schemaVersion => 1;

//   @override
//   MigrationStrategy get migration => MigrationStrategy(
//     onCreate: (Migrator m) async {
//       await m.createAll();
//       // Seed initial bundled data on first launch
//       await _seedInitialData();
//     },
//   );

//   Future<void> _seedInitialData() async {
//     // 1. Seed Member Profile (Matches both Home & Rewards requirements)
//     into(memberTable).insert(
//       MemberTableCompanion.insert(
//         id: 'current_user',
//         name: 'Hania',
//         tier: 'Bronze',
//         pointsToNextTier: 1290,
//         totalPoints: 680000,
//         avatarUrl: 'https://images.unsplash.com/...',
//         notificationCount: 2,
//       ),
//     );

//     // 2. Seed Products (e.g., Coconut Donut reference design)
//     into(productsTable).insert(
//       ProductsTableCompanion.insert(
//         id: 'p_coconut',
//         code: 'JD022123',
//         name: 'Coconut Donut',
//         priceMmk: 3200,
//         isNew: true,
//         discountPercent: const Value.absent(),
//         imageUrl: 'https://images.unsplash.com/...',
//         description:
//             'Enjoy our scrumptious donuts - soft, sweet, and satisfying in every bite[cite: 7].',
//         category: 'popular',
//       ),
//     );

//     // 3. Seed Nearby Shops (4 J'Donut shops)
//     into(shopsTable).insert(
//       ShopsTableCompanion.insert(
//         id: 'shop_1',
//         name: 'Myaynigone J\'Donut',
//         address: '2972 Pyay Road, Sanchaung Township, Yangon.',
//         imageUrl: 'https://images.unsplash.com/...',
//       ),
//     );
//   }

//   // --- QUERIES ---
//   Future<MemberTableData?> getMember() => select(memberTable).getSingleOrNull();

//   Future<List<ProductsTableData>> getProductsByCategory(String cat) =>
//       (select(productsTable)..where((t) => t.category.equals(cat))).get();

//   Future<List<ShopsTableData>> getAllShops() => select(shopsTable).get();
// }
