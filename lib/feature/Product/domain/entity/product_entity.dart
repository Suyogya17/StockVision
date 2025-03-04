import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  final String? productId;
  final String productName;
  final String? image;
  final String description;
  final String type;
  final String quantity;
  final String price;

  const ProductEntity({
    this.productId,
    required this.productName,
    this.image,
    required this.description,
    required this.type,
    required this.quantity,
    required this.price,
  });

  // from JSON
  factory ProductEntity.fromJson(Map<String, dynamic> json) {
    return ProductEntity(
      // Ensure all fields are treated as String
      productId:
          json['_id']?.toString(), // Convert _id to String if it's not already
      productName:
          json['productName']?.toString() ?? '', // Ensure productName is String
      image: json['image']
          ?.toString(), // Convert image to String if it's not already
      description:
          json['description']?.toString() ?? '', // Ensure description is String
      type: json['type']?.toString() ?? '', // Ensure type is String
      quantity:
          json['quantity']?.toString() ?? '', // Convert quantity to String
      price: json['price']?.toString() ?? '', // Convert price to String
    );
  }

  // to JSON
  Map<String, dynamic> toJson() => {
        '_id': productId,
        'productName': productName,
        'image': image,
        'description': description,
        'type': type,
        'quantity': quantity,
        'price': price,
      };

   // Adding copyWith method
  ProductEntity copyWith({
    String? productId,
    String? productName,
    String? image,
    String? description,
    String? type,
    String? quantity,
    String? price,
  }) {
    return ProductEntity(
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      image: image ?? this.image,
      description: description ?? this.description,
      type: type ?? this.type,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
    );
  }


  @override
  List<Object?> get props => [
        productId,
        productName,
        image,
        description,
        type,
        quantity,
        price,
      ];
}
