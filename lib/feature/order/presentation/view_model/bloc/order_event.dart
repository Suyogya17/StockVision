part of 'order_bloc.dart';

sealed class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object> get props => [];
}

class OrderLoad extends OrderEvent {}

class CreateOrder extends OrderEvent {
  final String customer;
  final List<ProductEntity> products;
  final String totalPrice;
  final String shippingAddress;
  final String status;
  final String paymentStatus;
  final String orderdate;

  const CreateOrder({
    required this.customer,
    required this.products,
    required this.totalPrice,
    required this.shippingAddress,
    required this.status,
    required this.paymentStatus,
    required this.orderdate,
  });

  @override
  List<Object> get props => [
        customer,
        products,
        totalPrice,
        shippingAddress,
        paymentStatus,
        status,
        orderdate
      ];
}

class DeleteOrder extends OrderEvent {
  final String id;

  const DeleteOrder({required this.id});

  @override
  List<Object> get props => [id];
}
