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
