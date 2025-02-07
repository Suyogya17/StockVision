import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:stockvision_app/feature/Product/domain/entity/product_entity.dart';

part 'product_api_model.g.dart';

@JsonSerializable()
class ProductApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? productId;
  final String productName;
  final String? image;
  final String description;
  final String type;
  final int quantity;
  final int price;

  const ProductApiModel({
    this.productId,
    required this.productName,
    required this.description,
    required this.image,
    required this.type,
    required this.quantity,
    required this.price,
  });

  factory ProductApiModel.fromJson(Map<String, dynamic> json) =>
      _$ProductApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductApiModelToJson(this);

  // To Entity
  ProductEntity toEntity() {
    return ProductEntity(
      productId: productId,
      productName: productName,
      description: description,
      type: type,
      quantity: quantity,
      price: price,
      image: '',
    );
  }

  // From Entity
  factory ProductApiModel.fromEntity(ProductEntity entity) {
    return ProductApiModel(
      productName: entity.productName,
      description: entity.description,
      type: entity.type,
      quantity: entity.quantity,
      price: entity.price,
      image: '',
    );
  }

  // Convert Api List  to entity list
  static List<ProductEntity> toEntityList(List<ProductApiModel> models) =>
      models.map((model) => model.toEntity()).toList();

  @override
  // TODO: implement props
  List<Object?> get props =>
      [productId, productName, image, description, type, quantity, price];
}
