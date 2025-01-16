part of 'product_bloc.dart';

class ProductState extends Equatable {
  final List<ProductEntity> product;
  final bool isLoading;
  final String? error;

  const ProductState({
    required this.product,
    required this.isLoading,
    this.error,
  });

  factory ProductState.initial() {
    return const ProductState(
      product: [],
      isLoading: false,
    );
  }
  ProductState copyWith({
    List<ProductEntity>? product,
    bool? isLoading,
    String? error,
  }) {
    return ProductState(
      product: product ?? this.product,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  @override
  List<Object?> get props => [product, isLoading, error];
}
