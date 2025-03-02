import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stockvision_app/app/di/di.dart';
import 'package:stockvision_app/feature/Order/presentation/view/order_view.dart';
import 'package:stockvision_app/feature/Order/presentation/view_model/order/bloc/order_bloc.dart';
import 'package:stockvision_app/feature/Product/presentation/view/products_view.dart';
import 'package:stockvision_app/feature/Product/presentation/view_model/bloc/product_bloc.dart';
import 'package:stockvision_app/feature/auth/presentation/view_model/profile/bloc/profile_bloc.dart';
import 'package:stockvision_app/feature/auth/presentation/view/setting_view.dart';

class HomeState extends Equatable {
  final int selectedIndex;
  final List<Widget> views;

  const HomeState({
    required this.selectedIndex,
    required this.views,
  });

  // Initial state
  static HomeState initial() {
    return HomeState(
      selectedIndex: 0,
      views: [
        const Center(
          child: Text('Dashboard'),
        ),
        BlocProvider(
          create: (context) => getIt<ProductBloc>(),
          child: const ProductsView(),
        ),
        BlocProvider(
          create: (context) => getIt<OrderBloc>(),
          child: const OrdersView(),
          
        ),
        BlocProvider(
          create: (context) => getIt<ProfileBloc>(),
          child: const SettingView(),
        ),
      ],
    );
  }

  HomeState copyWith({
    int? selectedIndex,
    List<Widget>? views,
  }) {
    return HomeState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
      views: views ?? this.views,
    );
  }

  @override
  List<Object?> get props => [selectedIndex, views];
}
