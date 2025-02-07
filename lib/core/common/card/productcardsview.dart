import 'package:flutter/material.dart';
import 'package:stockvision_app/feature/Product/domain/entity/product_entity.dart';

class MyCard extends StatelessWidget {
  final ProductEntity product;
  final Color color;

  const MyCard({
    super.key,
    required this.product,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: double.infinity,
        height: 150.0, // Adjust the height as needed
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Display product image
              product.image.isNotEmpty
                  ? Image.network(
                      product.image,
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    )
                  : const Icon(Icons.image, size: 80, color: Colors.grey),
              const SizedBox(height: 8),
              // Product name and price
              Text(
                product.productName,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '\$${product.price}',
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
