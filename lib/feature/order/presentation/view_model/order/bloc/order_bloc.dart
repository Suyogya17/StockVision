import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:stockvision_app/feature/Order/domain/entity/order_entity.dart';
import 'package:stockvision_app/feature/Order/domain/use_case/create_order_usecase.dart';
import 'package:stockvision_app/feature/Order/domain/use_case/delete_order_usecase.dart';
import 'package:stockvision_app/feature/Order/domain/use_case/get_all_order_usecase.dart';
import 'package:stockvision_app/feature/Product/domain/entity/product_entity.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final GetAllOrderUsecase _getAllOrderUsecase;
  final CreateOrderUsecase _createOrderUsecase;
  final DeleteOrderUsecase _deleteOrderUsecase;
  OrderBloc({
    required GetAllOrderUsecase getAllOrderUsecase,
    required CreateOrderUsecase createOrderUsecase,
    required DeleteOrderUsecase deleteOrderUsecase,
  })  : _getAllOrderUsecase = getAllOrderUsecase,
        _createOrderUsecase = createOrderUsecase,
        _deleteOrderUsecase = deleteOrderUsecase,
        super(OrderState.initial()) {
    on<OrderLoad>(_onOrderLoad);
    on<CreateOrder>(_onCreateOrder);
    on<DeleteOrder>(_onDeleteOrder);
    add(OrderLoad());
  }

  Future<void> _onOrderLoad(
    OrderLoad event,
    Emitter<OrderState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final result = await _getAllOrderUsecase();
    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, error: failure.message)),
      (order) {
        print('Fetched Orders: $order');
        emit(state.copyWith(isLoading: false, order: order));
      },
    );
  }

  Future<void> _onCreateOrder(
    CreateOrder event,
    Emitter<OrderState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    // var products = {'product':product,'quantity':quantity};
    final result = await _createOrderUsecase.call(CreateOrderParams(
      status: event.status,
      customerId: event.customer,
      customerUsername: 'saxh',
      products: event.productsList.whereType<ProductEntity>().toList(),
      totalPrice: event.totalPrice,
      shippingAddress: event.shippingAddress,
      paymentStatus: event.paymentStatus,
      orderDate: event.orderDate,
    ));
    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, error: failure.message)),
      (_) {
        emit(state.copyWith(isLoading: false));
        add(OrderLoad());
      },
    );
  }

  Future<void> _onDeleteOrder(
    DeleteOrder event,
    Emitter<OrderState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final result = await _deleteOrderUsecase(DeleteOrderParams(id: event.id));
    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, error: failure.message)),
      (_) {
        emit(state.copyWith(isLoading: false));
        add(OrderLoad());
      },
    );
  }
}
