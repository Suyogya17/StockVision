import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:stockvision_app/app/usecase/usease.dart';
import 'package:stockvision_app/core/error/failure.dart';
import 'package:stockvision_app/feature/Order/domain/entity/order_entity.dart';
import 'package:stockvision_app/feature/Order/domain/repository/order_repository.dart';

class CreateOrderParams extends Equatable {
  final String date;
  final String time;
  final String status;

  const CreateOrderParams({
    required this.date,
    required this.time,
    required this.status,
  });

  // Empty constructor
  const CreateOrderParams.empty()
      : date = '_empty.string',
        time = '_empty.string',
        status = '_empty.string';

  @override
  List<Object?> get props => [date, time, status];
}

class CreateOrderUsecase implements UsecaseWithParams<void, CreateOrderParams> {
  final IOrderRepository _orderRepository;

  CreateOrderUsecase({required IOrderRepository orderRepository})
      : _orderRepository = orderRepository;

  @override
  Future<Either<Failure, void>> call(CreateOrderParams params) {
    return _orderRepository.createOrder(
      OrderEntity(date: params.date, time: params.time, status: params.status),
    );
  }
}
