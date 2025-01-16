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

  ProductHiveModel({
    String? productId,
    required this.productName,
  }) : productId = productId ?? const Uuid().v4();

  // Initail Constructor
  const ProductHiveModel.initial()
      : productId = '',
        productName = '';

  // From Entity
  factory ProductHiveModel.fromEntity(ProductEntity entity) {
    return ProductHiveModel(
      productId: entity.productId,
      productName: entity.productName,
    );
  }

  // To Entity
  ProductEntity toEntity() {
    return ProductEntity(
      productId: productId,
      productName: productName,
    );
  }

  @override
  List<Object?> get props => [productId, productName];
}



  // // // From Entity List
  // // static List<BatchHiveModel> fromEntityList(List<BatchEntity> entityList) {
  // //   return entityList
  // //       .map((entity) => BatchHiveModel.fromEntity(entity))
  // //       .toList();
  // // }

  // // To Entity List
  // static List<BatchEntity> toEntityList(List<BatchHiveModel> hiveList) {
  //   return hiveList.map((hive) => hive.toEntity()).toList();
  // }