import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:stockvision_app/app/constants/hive_table_constant.dart';
import 'package:stockvision_app/feature/Product/domain/entity/product_entity.dart';
import 'package:uuid/uuid.dart';

part 'product_hive_model.g.dart';

@HiveType(typeId: HiveTableConstant.productTableId)
class ProductHiveModel extends Equatable {
  @HiveField(0)
  final String? productId;
  @HiveField(1)
  final String productName;
  @HiveField(2)
  final String? image;
  @HiveField(3)
  final String description;
  @HiveField(4)
  final String type;
  @HiveField(5)
  final String quantity;
  @HiveField(6)
  final String price;

  ProductHiveModel({
    String? productId,
    required this.productName,
    this.image,
    required this.description,
    required this.type,
    required this.quantity,
    required this.price,
  }) : productId = productId ?? const Uuid().v4();

  // Initail Constructor
  const ProductHiveModel.initial()
      : productId = '',
        productName = '',
        image = '',
        description = '',
        type = '',
        quantity = '',
        price = '';

  // From Entity
  factory ProductHiveModel.fromEntity(ProductEntity entity) {
    return ProductHiveModel(
        productId: entity.productId,
        productName: entity.productName,
        image: entity.image,
        description: entity.description,
        type: entity.type,
        quantity: entity.quantity,
        price: entity.price);
  }

  // To Entity
  ProductEntity toEntity() {
    return ProductEntity(
        productId: productId,
        productName: productName,
        image: image,
        description: description,
        type: type,
        quantity: quantity,
        price: price);
  }

  @override
  List<Object?> get props =>
      [productId, productName, image, description, type, quantity, price];
}

// From Entity List
List<ProductHiveModel> fromEntityList(List<ProductEntity> entityList) {
  return entityList
      .map((entity) => ProductHiveModel.fromEntity(entity))
      .toList();
}

// To Entity List
List<ProductEntity> toEntityList(List<ProductHiveModel> hiveList) {
  return hiveList.map((hive) => hive.toEntity()).toList();
}
