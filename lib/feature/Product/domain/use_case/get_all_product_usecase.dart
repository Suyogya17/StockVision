import 'package:dartz/dartz.dart';
import 'package:stockvision_app/app/shared_prefs/token_shared_prefs.dart';
import 'package:stockvision_app/app/usecase/usease.dart';
import 'package:stockvision_app/core/error/failure.dart';
import 'package:stockvision_app/feature/Product/domain/entity/product_entity.dart';
import 'package:stockvision_app/feature/Product/domain/repository/product_repository.dart';

class GetAllProductUseCase
    implements UsecaseWithoutParams<List<ProductEntity>> {
  final IProductRepository productRepository;
  final TokenSharedPrefs tokenSharedPrefs;

  GetAllProductUseCase({
    required this.productRepository,
    required this.tokenSharedPrefs,
  });

  @override
  Future<Either<Failure, List<ProductEntity>>> call() async {
    try {
      //  Get token
      final token = await tokenSharedPrefs.getToken();

      // Handle token retrieval failure or empty token
      return token.fold(
        (failure) => Left(
            failure), // If there's a failure getting the token, return that failure
        (token) async {
          if (token.isEmpty) {
            return const Left(
                SharedPrefsFailure(message: 'No token available'));
          }

          return await productRepository
              .getProduct(token); // Pass the token to the repository
        },
      );
    } catch (e) {
      // If an unexpected error occurs, return it as a failure
      return Left(
        SharedPrefsFailure(
            message: 'Unexpected error occurred: ${e.toString()}'),
      );
    }
  }
}
