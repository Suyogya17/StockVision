import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductsView extends StatefulWidget {
  const ProductsView({super.key});

  @override
  State<ProductsView> createState() => _ProductsViewState();
}

class _ProductsViewState extends State<ProductsView> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "This is the history page",
        style: GoogleFonts.arima(
          textStyle: const TextStyle(
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
