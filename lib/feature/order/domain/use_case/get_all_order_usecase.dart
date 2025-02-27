import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stockvision_app/app/shared_prefs/token_shared_prefs.dart';
import 'package:stockvision_app/app/shared_prefs/userId_shared_prefs.dart%207-49-15-915%E2%80%AFPM.dart';
import 'package:stockvision_app/app/usecase/usease.dart';
import 'package:stockvision_app/core/error/failure.dart';
import 'package:stockvision_app/feature/Order/domain/entity/order_entity.dart';
import 'package:stockvision_app/feature/Order/domain/repository/order_repository.dart';

class GetAllOrderUsecase implements UsecaseWithoutParams<List<OrderEntity>> {
  final IOrderRepository _orderRepository;
  final TokenSharedPrefs _tokenSharedPrefs;
  final UserIdSharedPrefs _userIdSharedPrefs;

  GetAllOrderUsecase({
    required IOrderRepository orderRepository,
    required TokenSharedPrefs tokenSharedPrefs,
    required UserIdSharedPrefs userIdSharedPrefs,
  })  : _orderRepository = orderRepository,
        _tokenSharedPrefs = tokenSharedPrefs,
        _userIdSharedPrefs = userIdSharedPrefs;

  @override
  Future<Either<Failure, List<OrderEntity>>> call() async {
    try {
      print("Calling GetAllOrderUsecase...");

      final tokenResult = await _tokenSharedPrefs.getToken();
      // final userResult = await _userIdSharedPrefs.getUserId();
      final user = await _userIdSharedPrefs.getUser();
      final userResult = user?['_id'];
      print("Id datatype:: ${userResult.runtimeType}");
      print('USERRR:: $user');
      print("Token Result: $tokenResult");
      print("User Result: $userResult");

      return tokenResult.fold(
        (failure) {
          print("Failed to retrieve token: ${failure.message}");
          return Left(failure);
        },
        (token) async {
          if (token.isEmpty) {
            print("No token available.");
            return const Left(SharedPrefsFailure(
                message: 'No authentication token available'));
          }

          print("Retrieved Token: $token");

          if (userResult == null || userResult.isEmpty) {
            print("No user ID available.");
            return const Left(
                SharedPrefsFailure(message: 'No user ID available'));
          }

          print("Retrieved User ID: $userResult");
          print("Retrieved User Token: ${token.runtimeType}");

          final ordersResult =
              await _orderRepository.getOrder(token, userResult);
          print("Orders Result: $ordersResult");
          return ordersResult;
        },
      );
    } catch (e) {
      print("Unexpected error: ${e.toString()}");
      return Left(
        SharedPrefsFailure(
            message: 'Unexpected error occurred: ${e.toString()}'),
      );
    }
  }
}
