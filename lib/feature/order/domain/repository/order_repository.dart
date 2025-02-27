import 'package:dartz/dartz.dart';
import 'package:stockvision_app/core/error/failure.dart';
import 'package:stockvision_app/feature/Order/domain/entity/order_entity.dart';

abstract interface class IOrderRepository {
  Future<Either<Failure, List<OrderEntity>>> getOrder( String? token, String userId);
  Future<Either<Failure, void>> createOrder(OrderEntity order);
  Future<Either<Failure, void>> deleteOrder(String id);

}
