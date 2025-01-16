import 'package:equatable/equatable.dart';

class OrderEntity extends Equatable {
  final String? orderId;
  final String orderName;

  const OrderEntity({
    this.orderId,
    required this.orderName,
  });

  @override
  List<Object?> get props => [orderId, orderName];
}
