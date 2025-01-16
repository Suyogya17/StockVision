import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  final String? productId;
  final String productName;

  const ProductEntity({
    this.productId,
    required this.productName,
  });

  @override
  List<Object?> get props => [productId, productName];
}
