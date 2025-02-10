import 'package:flutter/material.dart';
import 'package:stockvision_app/feature/Product/domain/entity/product_entity.dart';

class MyProductCard extends StatelessWidget {
  final ProductEntity product;
  final Color color;

  const MyProductCard({
    super.key,
    required this.product,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      height: 150,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Product Image with fallback
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: product.image != null
                ? Image.network(
                    "http://localhost:3000/assets/product_img/${product.image}",
                    width: 90,
                    height: 90,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => const Icon(
                        Icons.image_not_supported,
                        size: 80,
                        color: Colors.grey),
                  )
                : const Icon(Icons.image, size: 90, color: Colors.grey),
          ),
          const SizedBox(width: 12),

          // Product Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.productName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                const SizedBox(height: 6),
                Text(
                  'Rs: ${product.price}',
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
