// ProductDetailView.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stockvision_app/app/shared_prefs/token_shared_prefs.dart';
import 'package:stockvision_app/feature/Order/presentation/view_model/single_product_view/bloc/single_order_bloc.dart';
import 'package:stockvision_app/feature/Product/domain/entity/product_entity.dart';

class ProductDetailView extends StatefulWidget {
  final ProductEntity product;
  final List<String>? orderProduct;

  const ProductDetailView({
    Key? key,
    required this.product,
    required this.orderProduct,
  }) : super(key: key);

  @override
  _ProductDetailViewState createState() => _ProductDetailViewState();
}

class _ProductDetailViewState extends State<ProductDetailView> {
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final _key = GlobalKey<FormState>();
  late SharedPreferences sharedPreferences;
  late TokenSharedPrefs tokenSharedPrefs;
  bool isPreferencesLoaded = false;
  String? token;

  @override
  void initState() {
    super.initState();
    _initSharedPreferences();
  }

  Future<void> _initSharedPreferences() async {
    sharedPreferences = await SharedPreferences.getInstance();
    tokenSharedPrefs = TokenSharedPrefs(sharedPreferences);
    token = (await tokenSharedPrefs.getToken()) as String?;
    setState(() {
      isPreferencesLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final String imageUrl = widget.product.image != null
        ? "http://localhost:3000/${widget.product.image!.replaceAll('public/', '')}"
        : "";

    if (!isPreferencesLoaded) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (token == null) {
      return const Scaffold(
        body: Center(
          child: Text(
            'No token found! Please log in again.',
            style: TextStyle(fontSize: 20, color: Colors.red),
          ),
        ),
      );
    }

    return BlocProvider<SingleOrderBloc>(
      create: (context) => SingleOrderBloc(
        sharedPreferences: sharedPreferences,
        tokenSharedPrefs: tokenSharedPrefs,
      ),
      child: Scaffold(
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
                    child: widget.product.image != null && widget.product.image!.isNotEmpty
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
                          context.read<SingleOrderBloc>().add(
                            PlaceOrderEvent(
                              product: widget.product,
                              quantity: _quantityController.text,
                              address: _addressController.text,
                            ),
                          );
                        }
                      },
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
        ),
      ),
    );
  }
}
