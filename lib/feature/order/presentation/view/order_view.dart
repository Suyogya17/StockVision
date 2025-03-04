import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    context.read<OrderBloc>().add(OrderLoad()); // Fetch user orders
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

            // Apply search & filter
            final filteredOrders = state.order
                .where((order) =>
                    (selectedStatus == null ||
                        order.status == selectedStatus) &&
                    order.shippingAddress
                        .toLowerCase()
                        .contains(searchController.text.toLowerCase()))
                .toList();

            return Column(
              children: [
                // Search & Filter Bar
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
                          onChanged: (value) {
                            setState(() {
                              // Trigger rebuild of widget when search text changes
                            });
                          },
                        ),
                      ),
                      const SizedBox(width: 10),
                      // Filter Button
                      IconButton(
                        icon: const Icon(Icons.filter_list, size: 28),
                        onPressed: () => _showFilterDialog(context),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),

                // Order List
                Expanded(
                  child: filteredOrders.isEmpty
                      ? const Center(child: Text("No orders found"))
                      : ListView.builder(
                          itemCount: filteredOrders.length,
                          itemBuilder: (BuildContext context, index) {
                            final order = filteredOrders[index];

                            // Assuming each order has a list of products, access the first product (or a specific one)
                            final product = order.products.isNotEmpty
                                ? order.products[0]
                                : null;

                            // Get the quantity from the specific product in the order
                            final String productQuantity =
                                product?.quantity.toString() ?? 'N/A';

                            final String imageFileName =
                                product?.image?.split('/').last ?? "";
                            final String baseUrl = Platform.isIOS
                                ? "http://127.0.0.1:3000"
                                : "http://10.0.2.2:3000";
                            final String imageUrl =
                                "$baseUrl/uploads/$imageFileName";

                            return Card(
                              elevation: 5,
                              margin: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 5),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: ListTile(
                                contentPadding: const EdgeInsets.all(10),
                                leading: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    imageUrl,
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
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      product?.productName ?? 'N/A',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    IconButton(
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                      onPressed: () {
                                        // Add delete functionality here
                                      },
                                    ),
                                  ],
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Order ID: #${order.orderId}",
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                    Text(
                                      "Status: ${order.status}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: order.status == "Pending"
                                            ? Colors.red
                                            : Colors.green,
                                      ),
                                    ),
                                    // Show the specific product quantity
                                    Text(
                                      "Quantity: $productQuantity",
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
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

  // Show filter modal
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

                  // Dropdown for order status
                  DropdownButtonFormField<String>(
                    value: selectedStatus,
                    decoration: InputDecoration(
                      labelText: "Select Status",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    items: ["Pending", "Delivered", "Cancelled"]
                        .map((status) => DropdownMenuItem(
                              value: status,
                              child: Text(status),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setModalState(() => selectedStatus = value);
                    },
                  ),
                  const SizedBox(height: 16),

                  // Apply button
                  ElevatedButton(
                    onPressed: () {
                      setState(() {}); // Apply filters
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
}
