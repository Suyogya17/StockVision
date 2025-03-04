part of 'order_bloc.dart';

class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object> get props => [];
}

class OrderLoad extends OrderEvent {}

class CreateOrder extends OrderEvent {
  final BuildContext context;
  final String? orderId;
  final String customer;
  final List<ProductEntity?> productsList;
  final String totalPrice;
  final String shippingAddress;
  final String status;
  final String paymentStatus;
  final String orderDate;

  const CreateOrder({
    this.orderId,
    required this.context,
    required this.customer,
    required this.productsList,
    required this.totalPrice,
    required this.shippingAddress,
    required this.status,
    required this.paymentStatus,
    required this.orderDate,
  });

  @override
  List<Object> get props => [
        context,
        customer,
        productsList,
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

class OrderSearchFilter extends OrderEvent{

}
