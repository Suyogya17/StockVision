// single_order_event.dart
part of 'single_order_bloc.dart';

abstract class SingleOrderEvent {}

class PlaceOrderEvent extends SingleOrderEvent {
  final String address;
  final String quantity;
  final ProductEntity product;

  PlaceOrderEvent({
    required this.address,
    required this.quantity,
    required this.product,
  });
}
