import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stockvision_app/core/common/snackbar/my_snackbar.dart';
import 'package:stockvision_app/feature/Order/presentation/view_model/order/bloc/order_bloc.dart';
import 'package:stockvision_app/feature/Product/domain/entity/product_entity.dart';

class ProductDetailView extends StatefulWidget {
  final ProductEntity product;

  const ProductDetailView({super.key, required this.product});

  @override
  _ProductDetailViewState createState() => _ProductDetailViewState();
}

class _ProductDetailViewState extends State<ProductDetailView> {
  final _key = GlobalKey<FormState>();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();

  bool _isOrderPlaced = false;

  Future<void> _placeOrder() async {
    if (_addressController.text.isEmpty || _quantityController.text.isEmpty) {
      showMySnackBar(
        context: context,
        message: 'Please fill in all fields!',
        color: Colors.red,
      );
      return;
    }

    final int quantity = int.tryParse(_quantityController.text) ?? 1;
    if (quantity <= 0) {
      showMySnackBar(
        context: context,
        message: 'Quantity must be greater than 0!',
        color: Colors.red,
      );
      return;
    }

    final String totalAmount =
        (double.parse(widget.product.price) * quantity).toString();

    try {
      context.read<OrderBloc>().add(CreateOrder(
            context: context,
            customer: 'customer_id', // Replace with actual customer ID
            productsList: [
              widget.product.copyWith(
                  quantity: quantity.toString()) // Send the entered quantity
            ],
            totalPrice: totalAmount,
            shippingAddress: _addressController.text,
            status: 'pending',
            paymentStatus: 'pending',
            orderDate: DateTime.now().toString(),
          ));

      showMySnackBar(
        context: context,
        message: 'Order placed successfully!',
        color: Colors.green,
      );

      setState(() {
        _isOrderPlaced = true;
      });
    } catch (error) {
      showMySnackBar(
        context: context,
        message: 'Failed to place the order. Try again!',
        color: Colors.red,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final String imageUrl = widget.product.image != null
        ? "http://localhost:3000/${widget.product.image!.replaceAll('public/', '')}"
        : "";

    if (_isOrderPlaced) {
      final int quantity = int.tryParse(_quantityController.text) ?? 1;
      final String totalAmount =
          (double.parse(widget.product.price) * quantity).toString();

      return Scaffold(
        appBar: AppBar(
          title: const Text("Order Confirmation"),
          backgroundColor: Colors.orange,
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Order Summary',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15),
              Text('Product: ${widget.product.productName}',
                  style: const TextStyle(fontSize: 18)),
              Text('Price: Rs${widget.product.price}',
                  style: const TextStyle(fontSize: 18)),
              Text('Quantity: $quantity', style: const TextStyle(fontSize: 18)),
              Text('Total: Rs $totalAmount',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 25),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                      vertical: 15.0, horizontal: 30.0),
                  backgroundColor: Colors.orange, // Button color
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: () {
                  setState(() {
                    _isOrderPlaced = false;
                  });
                  Navigator.pop(context);
                },
                child: const Text('Back to Orders'),
              ),
            ],
          ),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Product Details"),
          backgroundColor: Colors.orange,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _key,
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(
                    imageUrl,
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  widget.product.productName,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text('Price: ${widget.product.price}',
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),
                // Product Quantity
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Text(
                  'Total Quantity Left: ${widget.product.quantity}',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[700],
                  ),
                  textAlign: TextAlign.justify,
                  ),
                ),
                const SizedBox(height: 20),
                // Shipping Address Field
                TextFormField(
                  controller: _addressController,
                  decoration: InputDecoration(
                    labelText: 'Shipping Address',
                    labelStyle: const TextStyle(color: Colors.orange),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.orange),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 20),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your address';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                // Quantity Field
                TextFormField(
                  controller: _quantityController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Quantity',
                    labelStyle: const TextStyle(color: Colors.orange),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.orange),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 20),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter quantity';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 30),
                // Place Order Button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 30.0),
                    backgroundColor: Colors.orange, // Button color
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: () {
                    if (_key.currentState!.validate()) {
                      _placeOrder();
                    }
                  },
                  child: const Text('Place Order'),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
}
