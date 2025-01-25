import 'package:dartz/dartz.dart';
import 'package:stockvision_app/app/usecase/usease.dart';
import 'package:stockvision_app/core/error/failure.dart';
import 'package:stockvision_app/feature/Order/domain/entity/order_entity.dart';
import 'package:stockvision_app/feature/Order/domain/repository/order_repository.dart';

class GetAllOrderUsecase implements UsecaseWithoutParams<List<OrderEntity>> {
  final IOrderRepository _orderRepository;

  GetAllOrderUsecase({required IOrderRepository orderRepository})
      : _orderRepository = orderRepository;

  @override
  Future<Either<Failure, List<OrderEntity>>> call() {
    return _orderRepository.getOrder();
  }

  // @override
  // Future<Either<Failure, List<OrderEntity>>> call() {
  //   return _orderRepository.getOrder();
  // }
}
