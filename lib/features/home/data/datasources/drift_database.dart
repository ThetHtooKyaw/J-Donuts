import 'package:drift/drift.dart';

part 'drift_database.drift.dart';

// --- TABLE DEFINITIONS ---

class MemberTable extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get tier => text()();
  IntColumn get pointsToNextTier => integer()();
  IntColumn get totalPoints => integer()();
  TextColumn get avatarUrl => text()();
  IntColumn get notificationCount => integer()();

  @override
  Set<Column> get primaryKey => {id};
}

class ProductsTable extends Table {
  TextColumn get id => text()();
  TextColumn get code => text()();
  TextColumn get name => text()();
  IntColumn get priceMmk => integer()();
  BoolColumn get isNew => boolean()();
  IntColumn get discountPercent => integer().nullable()();
  TextColumn get imageUrl => text()();
  TextColumn get description => text()();
  TextColumn get category =>
      text()(); // e.g., 'seasonal', 'popular', 'order_again'

  @override
  Set<Column> get primaryKey => {id};
}

class ShopsTable extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get address => text()();
  TextColumn get imageUrl => text()();

  @override
  Set<Column> get primaryKey => {id};
}

// --- DRIFT DATABASE ---

@DriftDatabase(tables: [MemberTable, ProductsTable, ShopsTable])
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.e);

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (Migrator m) async {
      await m.createAll();
      await _seedInitialData();
    },
    onUpgrade: (Migrator m, int from, int to) async {
      if (from < 2) {
        await delete(memberTable).go();
        await delete(productsTable).go();
        await delete(shopsTable).go();
        await _seedInitialData();
      }
    },
  );

  Future<void> _seedInitialData() async {
    // Member Data
    await batch((batch) {
      batch.insertAll(memberTable, [
        MemberTableCompanion.insert(
          id: 'current_user',
          name: 'Hania',
          tier: 'Bronze',
          pointsToNextTier: 1290,
          totalPoints: 680000,
          avatarUrl: 'assets/images/onboarding_banner.png',
          notificationCount: 2,
        ),
      ]);

      // Products Data
      batch.insertAll(productsTable, [
        ProductsTableCompanion.insert(
          id: 'product_1',
          code: 'JD0001',
          name: 'Strawberry Chocolate Donut',
          priceMmk: 3200,
          isNew: true,
          discountPercent: const Value.absent(),
          imageUrl: 'assets/images/product1.png',
          description:
              'Glazed in pink perfection with a rich chocolate drizzle. Indulgence never looked this good!',
          category: 'popular',
        ),
        ProductsTableCompanion.insert(
          id: 'product_2',
          code: 'JD0002',
          name: 'Wild Berry Smoothie',
          priceMmk: 3500,
          isNew: true,
          discountPercent: const Value.absent(),
          imageUrl: 'assets/images/product2.png',
          description:
              'Layered tropical mango and vibrant mixed berry bliss, topped with fresh raspberries and cream.',
          category: 'popular',
        ),
        ProductsTableCompanion.insert(
          id: 'product_3',
          code: 'JD0003',
          name: 'Classic Sugar Glazed Donut',
          priceMmk: 3500,
          isNew: false,
          discountPercent: const Value(10),
          imageUrl: 'assets/images/product3.png',
          description:
              'Simplicity at its finest. Golden, pillow-soft, and dusted with sweet perfection.',
          category: 'popular',
        ),
        ProductsTableCompanion.insert(
          id: 'product_4',
          code: 'JD0004',
          name: 'Iced Caramel Macchiato',
          priceMmk: 3000,
          isNew: false,
          discountPercent: const Value.absent(),
          imageUrl: 'assets/images/product4.png',
          description:
              'Creamy espresso layers topped with whipped foam, colorful sprinkles, and a rich caramel drizzle.',
          category: 'order_again',
        ),
        ProductsTableCompanion.insert(
          id: 'product_5',
          code: 'JD0005',
          name: 'Chocolate Sprinkle Donut',
          priceMmk: 3600,
          isNew: false,
          discountPercent: const Value.absent(),
          imageUrl: 'assets/images/product5.png',
          description:
              'Decadent milk chocolate coating topped with a burst of rainbow sprinkles. Pure joy in every bite!',
          category: 'order_again',
        ),
        ProductsTableCompanion.insert(
          id: 'product_6',
          code: 'JD0006',
          name: 'Mango Passion Parfait Drink',
          priceMmk: 3600,
          isNew: true,
          discountPercent: const Value(15),
          imageUrl: 'assets/images/product6.png',
          description:
              'A sunshine blend of sweet mango nectar, fresh kiwi, sliced peaches, and velvety cream.',
          category: 'order_again',
        ),
        ProductsTableCompanion.insert(
          id: 'special_1',
          code: 'SP0001',
          name: 'Morning FreshBakery Box',
          priceMmk: 4000,
          isNew: true,
          discountPercent: const Value(20),
          imageUrl: 'assets/images/special1.png',
          description:
              'A warm selection of freshly baked golden donuts glazed in signature dark chocolate and vanilla crumble, straight from the morning oven.',
          category: 'seasonal',
        ),
        ProductsTableCompanion.insert(
          id: 'special_2',
          code: 'SP0002',
          name: 'Mistletoe Romance box',
          priceMmk: 4500,
          isNew: true,
          discountPercent: const Value(10),
          imageUrl: 'assets/images/special3.png',
          description:
              'A sweet holiday assortment featuring strawberry frosting, dusted sprinkles, and rich chocolate drizzles crafted for sharing with someone special.',
          category: 'seasonal',
        ),
        ProductsTableCompanion.insert(
          id: 'special_3',
          code: 'SP0003',
          name: 'Christmas MixFamily box',
          priceMmk: 4200,
          isNew: true,
          discountPercent: const Value.absent(),
          imageUrl: 'assets/images/special2.png',
          description:
              'Our ultimate holiday crowd-pleaser packed with cinnamon sugar twists, caramel-filled rings, and classic glazed donuts for the whole family.',
          category: 'seasonal',
        ),
      ]);

      // Shops Data
      batch.insertAll(shopsTable, [
        ShopsTableCompanion.insert(
          id: 'shop_1',
          name: 'Myaynigone J\'Donut',
          address: '2972 Pyay Road, Sanchaung Township, Yangon.',
          imageUrl: 'assets/images/shop1.png',
        ),
        ShopsTableCompanion.insert(
          id: 'shop_2',
          name: 'Bahan J\'Donut',
          address: '2972 Pyay Road, Sanchaung Township, Yangon.',
          imageUrl: 'assets/images/shop2.png',
        ),
        ShopsTableCompanion.insert(
          id: 'shop_3',
          name: 'Downtown J\'Donut',
          address: '2972 Pyay Road, Sanchaung Township, Yangon.',
          imageUrl: 'assets/images/shop3.png',
        ),
      ]);
    });
  }

  // --- QUERIES ---
  Future<MemberTableData?> getMember() => select(memberTable).getSingleOrNull();

  Future<List<ProductsTableData>> getProductsByCategory(String cat) =>
      (select(productsTable)..where((t) => t.category.equals(cat))).get();

  Future<List<ShopsTableData>> getAllShops() => select(shopsTable).get();
}
