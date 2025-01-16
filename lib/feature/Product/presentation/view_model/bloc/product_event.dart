part of 'product_bloc.dart';

sealed class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

final class LoadProduct extends ProductEvent {}

final class AddProduct extends ProductEvent {
  final String productName;
  const AddProduct(this.productName);

  @override
  List<Object> get props => [productName];
}

final class DeleteProduct extends ProductEvent {
  final String productId;

  const DeleteProduct(this.productId);

  @override
  List<Object> get props => [productId];
}
