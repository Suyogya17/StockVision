import 'package:dartz/dartz.dart';
import 'package:stockvision_app/core/error/failure.dart';
import 'package:stockvision_app/feature/order/data/data_source/remote_datasource/order_remote_datasource.dart';
import 'package:stockvision_app/feature/order/domain/entity/order_entity.dart';
import 'package:stockvision_app/feature/order/domain/repository/order_repository.dart';

class OrderRemoteRepository implements IOrderRepository {
  final OrderRemoteDataSource remoteDatasource;
  OrderRemoteRepository({required this.remoteDatasource});

  @override
  Future<Either<Failure, void>> createOrder(OrderEntity order) async {
    try {
      remoteDatasource.createOrder(order);
      return const Right(null);
    } catch (e) {
      return Left(
        ApiFailure(
          message: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> deleteOrder(String id) {
    // TODO: implement deleteOrder
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<OrderEntity>>> getOrder() {
    // TODO: implement getOrder
    throw UnimplementedError();
  }
}
