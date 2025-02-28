part of 'order_bloc.dart';

sealed class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object> get props => [];
}

class OrderLoad extends OrderEvent {}

class CreateOrder extends OrderEvent {
  final BuildContext context;
  final String? orderId;
  final String customerId;
  final String customerUsername;
  final List<ProductEntity?> products;
  final String totalPrice;
  final String shippingAddress;
  final String status;
  final String paymentStatus;
  final String orderDate;

  const CreateOrder({
    this.orderId,
    required this.context,
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
  List<Object> get props => [
        context,
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

class NavigateToOrder extends OrderEvent {
  final BuildContext context;
  const NavigateToOrder({required this.context});
}

class DeleteOrder extends OrderEvent {
  final String id;

  const DeleteOrder({required this.id});

  @override
  List<Object> get props => [id];
}
