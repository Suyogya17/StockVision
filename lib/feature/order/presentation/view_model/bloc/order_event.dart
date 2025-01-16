part of 'order_bloc.dart';

sealed class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object> get props => [];
}

class OrderLoad extends OrderEvent {}

class CreateOrder extends OrderEvent {
  final String orderName;

  const CreateOrder({required this.orderName});

  @override
  List<Object> get props => [orderName];
}

class DeleteOrder extends OrderEvent {
  final String id;

  const DeleteOrder({required this.id});

  @override
  List<Object> get props => [id];
}
