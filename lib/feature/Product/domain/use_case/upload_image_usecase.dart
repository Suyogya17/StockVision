import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:stockvision_app/app/usecase/usease.dart';
import 'package:stockvision_app/core/error/failure.dart';
import 'package:stockvision_app/feature/Product/domain/repository/product_repository.dart';

class UploadProductImageParams {
  final File file;

  const UploadProductImageParams({
    required this.file,
  });
}

class UploadProductImageUsecase
    implements UsecaseWithParams<String, UploadProductImageParams> {
  final IProductRepository _repository;

  UploadProductImageUsecase(this._repository);

  @override
  Future<Either<Failure, String>> call(UploadProductImageParams params) {
    return _repository.uploadProductPicture(params.file);
  }
}
