import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  final String? productId;
  final String productName;
  final String image;
  final String description;
  final String type;
  final int quantity;
  final int price;

  const ProductEntity({
    this.productId,
    required this.productName,
    required this.image,
    required this.description,
    required this.type,
    required this.quantity,
    required this.price,
  });

  @override
  List<Object?> get props =>
      [productId, productName, image, description, type, quantity, price];
}
