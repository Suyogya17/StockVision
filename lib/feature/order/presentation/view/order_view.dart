import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stockvision_app/feature/Order/presentation/view_model/bloc/order_bloc.dart';

class OrdersView extends StatelessWidget {
  const OrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<OrderBloc>().add(OrderLoad());
    SharedPreferences sharedPreferences;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Orders"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: BlocBuilder<OrderBloc, OrderState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state.order.isEmpty) {
              return const Center(child: Text("No orders available"));
            }

            return ListView.builder(
              itemCount: state.order.length,
              itemBuilder: (BuildContext context, index) {
                final order = state.order[index];
                return ListTile(
                  title: Text(order.shippingAddress),
                  subtitle: Text(order.status),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
