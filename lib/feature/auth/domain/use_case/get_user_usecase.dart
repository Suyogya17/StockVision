import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stockvision_app/app/shared_prefs/token_shared_prefs.dart';
// import 'package:stockvision_app/app/shared_prefs/userId_shared_prefs.dart%207-49-15-915%E2%80%AFPM.dart';
import 'package:stockvision_app/app/usecase/usease.dart';
import 'package:stockvision_app/core/error/failure.dart';
import 'package:stockvision_app/feature/auth/domain/entity/auth_entity.dart';

class GetUserUsecase implements UsecaseWithoutParams<AuthEntity> {
  final TokenSharedPrefs _tokenSharedPrefs;

  GetUserUsecase({
    required TokenSharedPrefs tokenSharedPrefs,
  }) : _tokenSharedPrefs = tokenSharedPrefs;

  @override
  Future<Either<Failure, AuthEntity>> call() async {
    try {
      // Await the inner Future to get the actual Map
      final userMap = await _tokenSharedPrefs
          .getUser(); // This should be a Future<Map<String, dynamic>?>

      if (userMap == null) {
        return const Left(SharedPrefsFailure(message: "User data not found"));
      }
      // Convert the Map into an AuthEntity instance
      final user = AuthEntity.fromJson(userMap);
      print('USER:: $user');
      return Right(user);
    } catch (e) {
      print("Why error: ${e.toString()}");
      return Left(
        SharedPrefsFailure(
            message: 'Unexpected error occurred: ${e.toString()}'),
      );
    }
  }
}
