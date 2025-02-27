import 'package:dartz/dartz.dart';
import 'package:stockvision_app/core/error/failure.dart';
import 'package:stockvision_app/feature/Order/data/data_source/remote_datasource/order_remote_datasource.dart';
import 'package:stockvision_app/feature/Order/domain/entity/order_entity.dart';
import 'package:stockvision_app/feature/Order/domain/repository/order_repository.dart';

class OrderRemoteRepository implements IOrderRepository {
  final OrderRemoteDataSource _orderRemoteDatasource;
  OrderRemoteRepository(this._orderRemoteDatasource);

  @override
  Future<Either<Failure, void>> createOrder(OrderEntity order) {
    // TODO: implement createOrder
    throw UnimplementedError();
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
      final orderList = response.map((dynamic orderJson) {
        if (orderJson is Map<String, dynamic>) {
          return OrderEntity.fromJson(orderJson);
        } else {
          throw Exception('Invalid data format');
        }
      }).toList();

      return Right(orderList);
    } catch (e) {
      return Left(
        ApiFailure(
          message: e.toString(),
        ),
      );
    }
  }
}
