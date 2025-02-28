import 'package:dartz/dartz.dart';
import 'package:stockvision_app/core/error/failure.dart';
import 'package:stockvision_app/feature/Order/data/data_source/remote_datasource/order_remote_datasource.dart';
import 'package:stockvision_app/feature/Order/domain/entity/order_entity.dart';
import 'package:stockvision_app/feature/Order/domain/repository/order_repository.dart';

class OrderRemoteRepository implements IOrderRepository {
  final OrderRemoteDataSource _orderRemoteDatasource;
  OrderRemoteRepository(this._orderRemoteDatasource);

  @override
  Future<Either<Failure, void>> createOrder(OrderEntity order) async {
    try {
      final response1 = await _orderRemoteDatasource.createOrder(order);

      return Right(response1);
      
    } catch (e) {
      // Catch any errors and return a failure
      return Left(ApiFailure(
        message: 'REMOTE REPO ERROR, ${e.toString()}',
      ));
    }
  }

  @override
  Future<Either<Failure, void>> deleteOrder(String id) {
    // TODO: implement deleteOrder
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<OrderEntity>>> getOrder(
      String? token, String userId) async {
    try {
      final response = await _orderRemoteDatasource.getOrder(token, userId);
      print('RESPONSE:: ${response.runtimeType}');
      return Right(response);
    } catch (e) {
      return Left(
        ApiFailure(
          message: ' REMOTE REPO ERROR ,${e.toString()}',
        ),
      );
    }
  }
}
