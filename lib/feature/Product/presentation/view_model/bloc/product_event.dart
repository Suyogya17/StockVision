part of 'product_bloc.dart';

sealed class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object?> get props => [];
}

class LoadProduct extends ProductEvent {}

class LoadProductImage extends ProductEvent {
  final File file;

  const LoadProductImage({
    required this.file,
  });
}

class AddProduct extends ProductEvent {
  final String productName;
  final String? image;
  final String description;
  final String type;
  final int quantity;
  final int price;

  const AddProduct({
    required this.productName,
    this.image,
    required this.description,
    required this.type,
    required this.quantity,
    required this.price,
  });

  @override
  List<Object?> get props => [
        productName,
        image,
        description,
        type,
        quantity,
        price,
      ];
}

final class DeleteProduct extends ProductEvent {
  final String productId;

  const DeleteProduct(this.productId);

  @override
  List<Object> get props => [productId];
}
