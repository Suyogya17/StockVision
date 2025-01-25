part of 'product_bloc.dart';

sealed class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

final class LoadProduct extends ProductEvent {}

final class AddProduct extends ProductEvent {
  final String productName;
  final String image;
  final String description;
  final String type;
  final int quantity;
  final int price;

  const AddProduct(
    this.productName,
    this.image,
    this.description,
    this.type,
    this.quantity,
    this.price,
  );

  @override
  List<Object> get props => [
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
