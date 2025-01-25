import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:stockvision_app/feature/Product/domain/entity/product_entity.dart';

@JsonSerializable()
class ProductApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? productId;
  final String productName;
  final String image;
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
  const ProductApiModel.empty()
      : productId = '',
        productName = '',
        image = '',
        description = '',
        type = '',
        quantity = 0,
        price = 0;

  // from Json, write full code without generator
  factory ProductApiModel.fromJson(Map<String, dynamic> json) {
    return ProductApiModel(
      productId: json['_id'],
      productName: json['productName'],
      image: json['image'],
      description: json['description'],
      type: json['type'],
      quantity: json['quantity'],
      price: json['price'],
    );
  }

  // Too Json, write full code without generator

  Map<String, dynamic> toJson() {
    return {
      // '_id': productId,
      'productName': productName,
      'image': image,
      'description': description,
      'type': type,
      'quantity': quantity,
      'price': price,
    };
  }

  // From Entity
  factory ProductApiModel.fromEntity(ProductEntity entity) {
    return ProductApiModel(
      productId: entity.productId,
      productName: entity.productName,
      image: entity.image,
      description: entity.description,
      type: entity.type,
      quantity: entity.quantity,
      price: entity.price,
    );
  }

  // To Entity
  ProductEntity toEntity() {
    return ProductEntity(
      productId: productId,
      productName: productName,
      image: image,
      description: description,
      type: productName,
      quantity: quantity,
      price: price,
    );
  }

  // Convert Api Listy  to entity list
  static List<ProductEntity> toEntityList(List<ProductApiModel> models) =>
      models.map((model) => model.toEntity()).toList();

  @override
  // TODO: implement props
  List<Object?> get props =>
      [productId, productName, image, description, type, quantity, price];
}
