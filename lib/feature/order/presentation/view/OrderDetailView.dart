import 'package:flutter/material.dart';
import 'package:stockvision_app/feature/Order/domain/entity/order_entity.dart';

class OrderDetailView extends StatefulWidget {
  final OrderEntity order;

  const OrderDetailView({super.key, required this.order});

  @override
  _OrderDetailViewState createState() => _OrderDetailViewState();
}

class _OrderDetailViewState extends State<OrderDetailView> {
  // Function to handle the delete action

  @override
  Widget build(BuildContext context) {
    // Calculate total price
    double totalPrice = widget.order.products.fold(0, (sum, product) {
      final quantity = int.tryParse(product?.quantity ?? '0') ?? 0;
      final price = double.tryParse(product?.price ?? '0') ?? 0;
      return sum + (quantity * price);
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text("Order Details"),
        backgroundColor: Colors.orange, // Set your app bar color
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Order ID
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.deepPurple[50],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  "Order ID: #${widget.order.orderId}",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              // Status with conditional color
              Text(
                "Status: ${widget.order.status}",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: (widget.order.status == "Shipped" ||
                              widget.order.status == "Delivered") &&
                          widget.order.paymentStatus == "Completed"
                      ? Colors.green
                      : Colors.red,
                ),
              ),
              const SizedBox(height: 10),
              // Shipping Address
              Text(
                "Shipping Address: ${widget.order.shippingAddress}",
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              // Order Date
              Text(
                "Order Date: ${widget.order.orderDate}",
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              // Payment Status with conditional color
              Text(
                "Payment Status: ${widget.order.paymentStatus}",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: (widget.order.status == "Shipped" ||
                              widget.order.status == "Delivered") &&
                          widget.order.paymentStatus == "Completed"
                      ? Colors.green
                      : Colors.red,
                ),
              ),
              const SizedBox(height: 20),
              // Total Price
              Text(
                "Total Price: Rs $totalPrice",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              // Products Header
              const Text(
                "Products in the Order:",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              // Display products in the order
              ...widget.order.products.map((product) {
                int index = widget.order.products.indexOf(product);

                // Image URL handling
                final String imageUrl = product?.image != null
                    ? "http://localhost:3000/${product!.image!.replaceAll('public/', '')}"
                    : "";

                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.deepPurple[50],
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 2,
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Product Name
                        Text(
                          product?.productName ?? 'Unknown Product',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(height: 8),
                        // Product Image
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: SizedBox(
                            width: 500, // Set a fixed width for the image
                            height: 400, // Set a fixed height for the image
                            child: Image.network(
                              imageUrl.isNotEmpty
                                  ? imageUrl
                                  : "https://via.placeholder.com/150", // Default placeholder if image is empty
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(
                                  Icons.image_not_supported,
                                  size: 60,
                                  color: Colors.grey,
                                );
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 28),
                        // Row with Quantity and Delete Icon
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Quantity: ${product?.quantity ?? 'N/A'}",
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.black54,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            const Spacer(),
                            // Delete Icon
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }), // Ensure map is converted to list
            ],
          ),
        ),
      ),
    );
  }
}
