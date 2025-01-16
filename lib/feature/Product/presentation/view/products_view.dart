import 'package:flutter/material.dart';

class ProductsView extends StatefulWidget {
  const ProductsView({super.key});

  @override
  State<ProductsView> createState() => _ProductsViewState();
}

class _ProductsViewState extends State<ProductsView> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "This is the product page",
        style: TextStyle(fontSize: 40),
      ),
    );
  }
}
