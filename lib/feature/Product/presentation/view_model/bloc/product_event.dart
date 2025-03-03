part of 'product_bloc.dart';

sealed class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object?> get props => [];
}

class GetAllProduct extends ProductEvent {}

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
  final String quantity;
  final String price;

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
class NavigateSingleProductScreenEvent extends ProductEvent {
  final BuildContext context;
  final Widget destination;
  final ProductEntity product;

  const NavigateSingleProductScreenEvent({
    required this.context,
    required this.destination,
    required this.product
  });
}

final class DeleteProduct extends ProductEvent {
  final String productId;

  const DeleteProduct(this.productId);

  @override
  List<Object> get props => [productId];
}
