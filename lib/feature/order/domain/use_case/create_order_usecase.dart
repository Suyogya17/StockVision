import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:stockvision_app/app/usecase/usease.dart';
import 'package:stockvision_app/core/error/failure.dart';
import 'package:stockvision_app/feature/Order/domain/entity/order_entity.dart';
import 'package:stockvision_app/feature/Order/domain/repository/order_repository.dart';
import 'package:stockvision_app/feature/Product/domain/entity/product_entity.dart';

class CreateOrderParams extends Equatable {
  final String customerId;
  final String customerUsername;
  final List<ProductEntity> products;
  final String totalPrice;
  final String shippingAddress;
  final String status;
  final String paymentStatus;
  final DateTime orderDate;

  const CreateOrderParams({
    required this.customerId,
    required this.customerUsername,
    required this.products,
    required this.totalPrice,
    required this.shippingAddress,
    required this.status,
    required this.paymentStatus,
    required this.orderDate,
  });

  @override
  List<Object?> get props => [
        customerId,
        customerUsername,
        products,
        totalPrice,
        shippingAddress,
        status,
        paymentStatus,
        orderDate,
      ];
}

class CreateOrderUsecase implements UsecaseWithParams<void, CreateOrderParams> {
  final IOrderRepository _orderRepository;

  CreateOrderUsecase({required IOrderRepository orderRepository})
      : _orderRepository = orderRepository;

  @override
  Future<Either<Failure, void>> call(CreateOrderParams params) {
    return _orderRepository.createOrder(
      OrderEntity(
        orderId: null, // Since it's generated by backend
        customerId: params.customerId,
        customerUsername: params.customerUsername,
        products: params.products,
        totalPrice: params.totalPrice,
        shippingAddress: params.shippingAddress,
        status: params.status,
        paymentStatus: params.paymentStatus,
        orderDate: params.orderDate,
      ),
    );
  }
}
