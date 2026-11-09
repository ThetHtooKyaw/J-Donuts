import '../../domain/entities/product.dart';

class ProductModel extends Product {
  const ProductModel({
    required super.id,
    required super.code,
    required super.name,
    required super.priceMmk,
    required super.isNew,
    super.discountPercent,
    required super.imageUrl,
    required super.description,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] as String,
      code: json['code'] as String,
      name: json['name'] as String,
      priceMmk: json['priceMmk'] as int,
      isNew: json['isNew'] as bool? ?? false,
      discountPercent: json['discountPercent'] as int?,
      imageUrl: json['imageUrl'] as String,
      description: json['description'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'code': code,
    'name': name,
    'priceMmk': priceMmk,
    'isNew': isNew,
    'discountPercent': discountPercent,
    'imageUrl': imageUrl,
    'description': description,
  };
}
