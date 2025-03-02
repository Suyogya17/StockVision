import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:stockvision_app/app/shared_prefs/token_shared_prefs.dart';
import 'package:stockvision_app/core/error/failure.dart';
import 'package:stockvision_app/feature/auth/data/data_source/remote_datasource/auth_remote_datasource.dart';
import 'package:stockvision_app/feature/auth/domain/entity/auth_entity.dart';
import 'package:stockvision_app/feature/auth/domain/repository/auth_repository.dart';

class AuthRemoteRepository implements IAuthRepository {
  final AuthRemoteDatasource _authRemoteDatasource;
  final TokenSharedPrefs _tokenSharedPrefs;
  AuthRemoteRepository(this._authRemoteDatasource, this._tokenSharedPrefs);
  @override
  Future<Either<Failure, AuthEntity>> getCurrentUser(
      String? token, String userId) async {
    try {
      final response =
          await _authRemoteDatasource.getCurrentUser(token, userId);
      print('RESPONSEauth:: ${response.runtimeType}');
      return Right(response);
    } catch (e) {
      return Left(
        ApiFailure(message: "API FALIURE, ${e.toString()}"),
      );
    }
  }

  @override
  Future<Either<Failure, String>> loginCustomer(
      String username, String password) async {
    try {
      final token =
          await _authRemoteDatasource.loginCustomer(username, password);
      return Right(token);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> registerCustomer(AuthEntity customer) async {
    try {
      await _authRemoteDatasource.registerCustomer(customer);
      return const Right(null);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> uploadProfilePicture(File file) async {
    try {
      final imageName = await _authRemoteDatasource.uploadProfilePicture(file);
      return Right(imageName);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, AuthEntity>> updateUser(AuthEntity user) async {
    print('User update response:::::::');
    try {
      print('User update response:::::::');
      var currentUser = _tokenSharedPrefs.getUser();
      // var newUser = AuthEntity(
      //   fName: user.fName,
      //   lName: user.lName,
      //   email: user.email,
      //   phoneNo: user.phoneNo,
      //   address: user.address,
      //   username: user.address,
      //   password: currentUser.,
      // );
      final response = await _authRemoteDatasource.updateUser(user);
      print("User update response::: $response");
      return Right(response);
    } catch (e) {
      print('ERROR $e');
      return Left(ApiFailure(message: e.toString()));
    }
  }
}
