import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stockvision_app/app/shared_prefs/token_shared_prefs.dart';
import 'package:stockvision_app/feature/Order/presentation/view_model/bloc/order_bloc.dart';
import 'package:stockvision_app/feature/Product/domain/entity/product_entity.dart';

class ProductDetailView extends StatefulWidget {
  final ProductEntity product;
  final List<String>? orderProduct;

  const ProductDetailView(
      {super.key, required this.product, required this.orderProduct});

  @override
  _ProductDetailViewState createState() => _ProductDetailViewState();
}

class _ProductDetailViewState extends State<ProductDetailView> {
  // Controllers to capture user inputs
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final _key = GlobalKey<FormState>();
  late SharedPreferences sharedPreferences;
  late TokenSharedPrefs tokenSharedPrefs;
  bool isPreferencesLoaded = false;
  @override
  void initState() {
    super.initState();
    _initSharedPreferences();
  }

  Future<void> _initSharedPreferences() async {
    sharedPreferences = await SharedPreferences.getInstance();
    tokenSharedPrefs = TokenSharedPrefs(sharedPreferences);
    setState(() {
      isPreferencesLoaded = true;
    });
  }

  Future<void> _createOrder() async {
    if (_addressController.text.isEmpty || _quantityController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all fields!'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    try {
      // Retrieve the token once preferences are loaded
      String? token = (await tokenSharedPrefs.getToken()) as String?;

      if (token == null) {
        // Handle case if token is not found
        print('No token found!');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('No token found! Please log in again.'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      // Proceed with creating the order logic

      await Future.delayed(
          const Duration(seconds: 1)); // Simulate network delay

      // Print the success message to the console
      print('Order placed successfully!');

      // Show a snackbar indicating success
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Order placed successfully!'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (error) {
      print('Failed to place the order. Error: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to place the order. Try again!'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final String imageUrl = widget.product.image != null
        ? "http://localhost:3000/${widget.product.image!.replaceAll('public/', '')}"
        : "";

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
          child: Form(
            key: _key,
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
                    onPressed: () {
                      if (_key.currentState!.validate()) {
                        final orderState = context.read<OrderBloc>().state;
                        context.read<OrderBloc>().add(
                              CreateOrder(
                                context: context,
                                customerId: '',
                                customerUsername: '',
                                products: const [],
                                totalPrice: '',
                                shippingAddress: '',
                                status: '',
                                paymentStatus: '',
                                orderDate: '',
                              ),
                            );
                      }
                    }, // Call the _createOrder method
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 5,
                    ),
                    child: const Text(
                      "Place Order",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
