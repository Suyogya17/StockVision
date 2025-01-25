import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:stockvision_app/app/usecase/usease.dart';
import 'package:stockvision_app/core/error/failure.dart';
import 'package:stockvision_app/feature/Product/domain/entity/product_entity.dart';
import 'package:stockvision_app/feature/Product/domain/repository/product_repository.dart';
// import 'package:softwarica_student_management_bloc/features/batch/domain/repository/batch_repository.dart';

class CreateProductParams extends Equatable {
  final String productName;
  final String image;
  final String description;
  final String type;
  final int quantity;
  final int price;

  const CreateProductParams({
    required this.productName,
    required this.image,
    required this.description,
    required this.type,
    required this.quantity,
    required this.price,
  });

  // Empty constructor
  const CreateProductParams.empty()
      : productName = '_empty.string',
        image = '_empty.image',
        description = '_empty.description',
        type = '_empty.type',
        quantity = 0,
        price = 0;

  @override
  List<Object?> get props => [productName];
}

class CreateProductUseCase
    implements UsecaseWithParams<void, CreateProductParams> {
  final IProductRepository productRepository;

  CreateProductUseCase({required this.productRepository});

  @override
  Future<Either<Failure, void>> call(CreateProductParams params) async {
    return await productRepository.createProduct(
      ProductEntity(
        productName: params.productName,
        image: params.image,
        description: params.description,
        type: params.type,
        quantity: params.quantity,
        price: params.price,
      ),
    );
  }
}
