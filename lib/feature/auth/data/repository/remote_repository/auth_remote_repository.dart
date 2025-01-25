import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:stockvision_app/core/error/failure.dart';
import 'package:stockvision_app/feature/auth/data/data_source/remote_datasource/auth_remote_datasource.dart';
import 'package:stockvision_app/feature/auth/domain/entity/auth_entity.dart';
import 'package:stockvision_app/feature/auth/domain/repository/auth_repository.dart';

class AuthRemoteRepository implements IAuthRepository {
  final AuthRemoteDatasource _authRemoteDatasource;
  AuthRemoteRepository(this._authRemoteDatasource);
  @override
  Future<Either<Failure, AuthEntity>> getCurrentUser() {
    // TODO: implement getCurrentUser
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> loginCustomer(
      String username, String password) async {
    try {
      final result =
          await _authRemoteDatasource.loginCustomer(username, password);
      return Right(result);
    } catch (e) {
      return Left(LocalDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> registerCustomer(AuthEntity customer) async {
    try {
      return Right(_authRemoteDatasource.registerCustomer(customer));
    } catch (e) {
      return Left(LocalDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> uploadProfilePicture(File file) {
    // TODO: implement uploadProfilePicture
    throw UnimplementedError();
  }
}
