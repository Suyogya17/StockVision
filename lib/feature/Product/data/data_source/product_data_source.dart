import 'package:stockvision_app/feature/Product/domain/entity/product_entity.dart';

abstract interface class IProductDataSource {
  Future<List<ProductEntity>> getProduct();
  Future<void> createProduct(ProductEntity product);
  Future<void> deleteProduct(String id);
}
