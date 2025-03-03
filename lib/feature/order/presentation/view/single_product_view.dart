import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:stockvision_app/feature/Order/presentation/view_model/bloc/order_bloc.dart';
import 'package:stockvision_app/feature/Order/presentation/view_model/order/bloc/order_bloc.dart';
import 'package:stockvision_app/feature/Product/domain/entity/product_entity.dart';

class ProductDetailView extends StatefulWidget {
  final ProductEntity product;

  const ProductDetailView({super.key, required this.product});

  @override
  _ProductDetailViewState createState() => _ProductDetailViewState();
}

class _ProductDetailViewState extends State<ProductDetailView> {
  // Controllers to capture user inputs
  final _key = GlobalKey<FormState>();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();

  final bool _isOrderPlaced = false; // Flag to check if the order was placed

  // Function to place order
  Future<void> _placeOrder() async {
    if (_addressController.text.isEmpty || _quantityController.text.isEmpty) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please fill in all fields!'),
            backgroundColor: Colors.red,
          ),
        );
      }
      return;
    }
    try {
      print('a');
      final int quantity = int.tryParse(_quantityController.text) ?? 1;
      final String totalAmount = widget.product.price * quantity;
      final OrderState = context.read<OrderBloc>().state;

      // Dispatch the order creation event to the Bloc
      context.read<OrderBloc>().add(CreateOrder(
            context: context,
            customer: 'sadjhhgsd',
            productsList: [widget.product],
            totalPrice: totalAmount,
            shippingAddress: _addressController.text,
            status: 'pending',
            paymentStatus: 'pending',
            orderDate: DateTime.now().toString(),
          ));
      print('b $OrderState');
    } catch (error) {
      print('ERROR:: $error');
      // If there's an error, show an error message
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to place the order. Try again!'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Construct the network image URL
    final String imageUrl = widget.product.image != null
        ? "http://localhost:3000/${widget.product.image!.replaceAll('public/', '')}"
        : "";

    if (_isOrderPlaced) {
      // Display the Bill screen after the order is placed
      final int quantity = int.tryParse(_quantityController.text) ?? 1;
      final String totalAmount = widget.product.price * quantity;

      return Scaffold(
        appBar: AppBar(
          title: const Text("Order Confirmation"),
          backgroundColor: Colors.orange,
          elevation: 0,
        ),
        body: BlocBuilder<OrderBloc, OrderState>(builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Order Summary',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Product: ${widget.product.productName}',
                  style: const TextStyle(fontSize: 18),
                ),
                Text(
                  'Quantity: $_quantityController.text',
                  style: const TextStyle(fontSize: 18),
                ),
                Text(
                  'Total Amount: $totalAmount',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange,
                  ),
                ),
              ],
            ),
          );
        }),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.product.productName,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.orange,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Image
              Center(
                child: widget.product.image != null &&
                        widget.product.image!.isNotEmpty
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.network(
                          imageUrl,
                          height: 350,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(
                              Icons.image_not_supported,
                              size: 250,
                              color: Colors.grey,
                            );
                          },
                        ),
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: const Icon(
                          Icons.image_not_supported,
                          size: 250,
                          color: Colors.grey,
                        ),
                      ),
              ),
              const SizedBox(height: 20),

              // Product Name
              Text(
                widget.product.productName,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),

              // Product Price
              Text(
                "Price: ₹${widget.product.price}",
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: Colors.orange,
                ),
              ),
              const SizedBox(height: 10),

              // Product Quantity Input
              TextField(
                controller: _quantityController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Quantity',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),

              // Shipping Address Input
              TextField(
                controller: _addressController,
                decoration: const InputDecoration(
                  labelText: 'Shipping Address',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),

              // Place Order Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _placeOrder, // Call the _placeOrder method
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 5,
                  ),
                  child: const Text(
                    "Place Order",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
