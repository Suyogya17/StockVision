import 'package:dartz/dartz.dart';
import 'package:stockvision_app/core/error/failure.dart';
import 'package:stockvision_app/feature/Product/data/data_source/product_local_data_source.dart';
import 'package:stockvision_app/feature/Product/domain/entity/product_entity.dart';
import 'package:stockvision_app/feature/Product/domain/repository/product_repository.dart';

class ProductLocalRepository implements IProductRepository {
  final ProductLocalDataSource _productLocalDataSource;

  ProductLocalRepository(
      {required ProductLocalDataSource productLocalDataSource})
      : _productLocalDataSource = productLocalDataSource;

  @override
  Future<Either<Failure, void>> createProduct(ProductEntity product) {
    try {
      _productLocalDataSource.createProduct(product);
      return Future.value(const Right(null));
    } catch (e) {
      return Future.value(Left(LocalDatabaseFailure(message: e.toString())));
    }
  }

  @override
  Future<Either<Failure, void>> deleteProduct(String id) {
    try {
      _productLocalDataSource.deleteProduct(id);
      return Future.value(const Right(null));
    } catch (e) {
      return Future.value(Left(LocalDatabaseFailure(message: e.toString())));
    }
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> getProduct() {
    try {
      return _productLocalDataSource.getProduct().then(
        (value) {
          return Right(value);
        },
      );
    } catch (e) {
      return Future.value(Left(LocalDatabaseFailure(message: e.toString())));
    }
  }
}
