part of 'product_bloc.dart';

class ProductState extends Equatable {
  final List<ProductEntity> product;
  final bool isLoading;
  final String? error;
  final String? productimageName;

  const ProductState({
    required this.product,
    required this.isLoading,
    this.error,
    this.productimageName,
  });

  factory ProductState.initial() {
    return const ProductState(
      product: [],
      isLoading: false,
      productimageName: null,
    );
  }
  ProductState copyWith({
    List<ProductEntity>? product,
    bool? isLoading,
    String? error,
    String? productimageName,
  }) {
    return ProductState(
      product: product ?? this.product,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      productimageName: productimageName ?? this.productimageName,
    );
  }

  @override
  List<Object?> get props => [product, isLoading, error, productimageName];
}
