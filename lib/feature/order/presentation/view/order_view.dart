import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stockvision_app/app/di/di.dart';
import 'package:stockvision_app/core/common/snackbar/my_snackbar.dart';
import 'package:stockvision_app/feature/Order/presentation/view/OrderDetailView.dart';
import 'package:stockvision_app/feature/Order/presentation/view_model/order/bloc/order_bloc.dart';

class OrdersView extends StatefulWidget {
  const OrdersView({super.key});

  @override
  _OrdersViewState createState() => _OrdersViewState();
}

class _OrdersViewState extends State<OrdersView> {
  String? selectedStatus;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<OrderBloc>().add(OrderLoad());
  }

  Future<void> _deleteOrder(String orderId) async {
    try {
      context.read<OrderBloc>().add(DeleteOrder(id: orderId));
      showMySnackBar(
        context: context,
        message: 'Order deleted successfully!',
        color: Colors.green,
      );
    } catch (error) {
      showMySnackBar(
        context: context,
        message: 'Failed to delete the order. Try again!',
        color: Colors.red,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: BlocBuilder<OrderBloc, OrderState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state.order.isEmpty) {
              return const Center(child: Text("No orders available"));
            }

            final filteredOrders = state.order
                .where((order) =>
                    (selectedStatus == null || order.status == selectedStatus) &&
                    order.shippingAddress
                        .toLowerCase()
                        .contains(searchController.text.toLowerCase()))
                .toList();

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: searchController,
                          decoration: InputDecoration(
                            hintText: "Search orders...",
                            prefixIcon: const Icon(Icons.search),
                            filled: true,
                            fillColor: Colors.grey[200],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          onChanged: (value) => setState(() {}),
                        ),
                      ),
                      const SizedBox(width: 10),
                      IconButton(
                        icon: const Icon(Icons.filter_list, size: 28),
                        onPressed: () => _showFilterDialog(context),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: filteredOrders.isEmpty
                      ? const Center(child: Text("No orders found"))
                      : ListView.builder(
                          itemCount: filteredOrders.length,
                          itemBuilder: (context, index) {
                            final order = filteredOrders[index];

                            final String imageFileName = order.products.isNotEmpty &&
                                    order.products[0]?.image != null
                                ? order.products[0]!.image!.split('/').last
                                : "";
                            final String baseUrl = Platform.isIOS
                                ? "http://127.0.0.1:3000"
                                : "http://10.0.2.2:3000";
                            final String imageUrl =
                                imageFileName.isNotEmpty ? "$baseUrl/uploads/$imageFileName" : "";

                            Color statusColor = (order.status == "Shipped" ||
                                        order.status == "Delivered") &&
                                    order.paymentStatus == "Completed"
                                ? Colors.green
                                : Colors.red;

                            return Card(
                              elevation: 5,
                              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: ListTile(
                                contentPadding: const EdgeInsets.all(10),
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (_) => BlocProvider.value(
                                        value: context.read<OrderBloc>(),
                                        child: OrderDetailView(order: order),
                                      ),
                                    ),
                                  );
                                },
                                leading: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    imageUrl.isNotEmpty
                                        ? imageUrl
                                        : 'https://via.placeholder.com/80',
                                    width: 80,
                                    height: 80,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return const Icon(
                                        Icons.image_not_supported,
                                        size: 80,
                                        color: Colors.grey,
                                      );
                                    },
                                  ),
                                ),
                                title: Text(
                                  order.products.isNotEmpty
                                      ? order.products[0]?.productName ?? 'N/A'
                                      : 'N/A',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Order ID: #${order.orderId}", style: const TextStyle(fontSize: 14)),
                                    Text(
                                      "Status: ${order.status}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: statusColor,
                                      ),
                                    ),
                                  ],
                                ),
                                trailing: IconButton(
                                  icon: const Icon(Icons.delete, color: Colors.red),
                                  onPressed: () {
                                    if (order.orderId != null) {
                                      _showDeleteConfirmationDialog(context, order.orderId!);
                                    }
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void _showFilterDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Filter Orders",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: selectedStatus,
                    decoration: InputDecoration(
                      labelText: "Select Status",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    items: ["Pending", "Delivered", "Cancelled"]
                        .map((status) => DropdownMenuItem(value: status, child: Text(status)))
                        .toList(),
                    onChanged: (value) {
                      setModalState(() => selectedStatus = value);
                    },
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {});
                      Navigator.pop(context);
                    },
                    child: const Text("Apply Filters"),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context, String orderId) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Delete Order"),
          content: const Text("Are you sure you want to delete this order?"),
          actions: [
            TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text("Cancel")),
            TextButton(
              onPressed: () {
                _deleteOrder(orderId);
                Navigator.of(context).pop();
              },
              child: const Text("Delete"),
            ),
          ],
        );
      },
    );
  }
}
