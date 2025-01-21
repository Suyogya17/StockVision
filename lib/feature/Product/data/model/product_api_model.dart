import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:stockvision_app/feature/Product/domain/entity/product_entity.dart';

@JsonSerializable()
class ProductApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? productId;
  final String productName;

  const ProductApiModel({
    this.productId,
    required this.productName,
  });
  const ProductApiModel.empty()
      : productId = '',
        productName = '';

  // from Json, write full code without generator
  factory ProductApiModel.fromJson(Map<String, dynamic> json) {
    return ProductApiModel(
      productId: json['_id'],
      productName: json['productName'],
    );
  }

  // Too Json, write full code without generator

  Map<String, dynamic> toJson() {
    return {
      // '_id': productId,
      'productName': productName,
    };
  }

  // From Entity
  factory ProductApiModel.fromEntity(ProductEntity entity) {
    return ProductApiModel(
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

  // Convert Api Listy  to entity list
  List<ProductEntity> toEntityList(List<ProductApiModel> models) =>
      models.map((model) => model.toEntity()).toList();

  @override
  // TODO: implement props
  List<Object?> get props => [productId, productName];
}
