import 'package:dartz/dartz.dart';
import 'package:stockvision_app/core/error/failure.dart';
import 'package:stockvision_app/feature/Order/data/data_source/local_data_source/order_local_data_source.dart';
import 'package:stockvision_app/feature/Order/domain/entity/order_entity.dart';
import 'package:stockvision_app/feature/Order/domain/repository/order_repository.dart';

class OrderLocalRepository implements IOrderRepository {
  final OrderLocalDataSource _orderLocalDataSource;

  OrderLocalRepository({required OrderLocalDataSource orderLocalDataSource})
      : _orderLocalDataSource = orderLocalDataSource;

  @override
  Future<Either<Failure, void>> createOrder(OrderEntity order) {
    try {
      _orderLocalDataSource.createOrder(order);
      return Future.value(const Right(null));
    } catch (e) {
      return Future.value(Left(LocalDatabaseFailure(message: e.toString())));
    }
  }

  @override
  Future<Either<Failure, void>> deleteOrder(String id) {
    try {
      _orderLocalDataSource.deleteOrder(id);
      return Future.value(const Right(null));
    } catch (e) {
      return Future.value(Left(LocalDatabaseFailure(message: e.toString())));
    }
  }

  @override
  Future<Either<Failure, List<OrderEntity>>> getOrder(String? token, String userId) {
    try {
      return _orderLocalDataSource.getOrder( token, userId).then(
        (value) {
          return Right(value);
        },
      );
    } catch (e) {
      return Future.value(Left(LocalDatabaseFailure(message: e.toString())));
    }
  }
  
//   @override
//   Future<Either<Failure, List<OrderEntity>>> getOrderByCustomerId(String customerId, String? token) async {
//   try {
//     // Assuming you retrieve a list of OrderProductEntity from your local data source
//     final orderProducts = await _orderLocalDataSource.getOrderByCustomerId(customerId, token);
//     return Future.value(Right(orderProducts));
//   } catch (e) {
//     return Future.value(Left(LocalDatabaseFailure(message: e.toString())));
//   }
// }

}
