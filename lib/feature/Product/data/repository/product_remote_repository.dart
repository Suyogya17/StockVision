import 'package:dartz/dartz.dart';
import 'package:stockvision_app/core/error/failure.dart';
import 'package:stockvision_app/feature/Product/data/data_source/remote_datasource/product_remote_datasource.dart';
import 'package:stockvision_app/feature/Product/domain/entity/product_entity.dart';
import 'package:stockvision_app/feature/Product/domain/repository/product_repository.dart';

class ProductRemoteRepository implements IProductRepository {
  final ProductRemoteDatasource remoteDatasource;
  ProductRemoteRepository({required this.remoteDatasource});

  @override
  Future<Either<Failure, void>> createProduct(ProductEntity product) async {
    try {
      remoteDatasource.createProduct(product);
      return const Right(null);
    } catch (e) {
      return Left(
        ApiFailure(
          message: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> deleteProduct(String id) {
    // TODO: implement deleteBatch
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> getProduct() {
    // TODO: implement getProduct
    throw UnimplementedError();
  }
}
