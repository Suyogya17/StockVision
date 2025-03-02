// single_order_state.dart
part of 'single_order_bloc.dart';

abstract class SingleOrderState {}

class SingleOrderInitialState extends SingleOrderState {}

class SingleOrderLoadingState extends SingleOrderState {}

class SingleOrderSuccessState extends SingleOrderState {
  final String message;

  SingleOrderSuccessState({required this.message});
}

class SingleOrderFailureState extends SingleOrderState {
  final String errorMessage;

  SingleOrderFailureState({required this.errorMessage});
}
