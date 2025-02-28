import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stockvision_app/feature/Product/presentation/view/single_product_view.dart';
import 'package:stockvision_app/feature/Product/presentation/view_model/bloc/product_bloc.dart';

class ProductsView extends StatefulWidget {
  const ProductsView({super.key});

  @override
  _ProductsViewState createState() => _ProductsViewState();
}

class _ProductsViewState extends State<ProductsView> {
  String? selectedType;
  double maxPrice = 100000; // Default max price for filtering
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context
        .read<ProductBloc>()
        .add(GetAllProduct()); // Fetch products initially
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state.product.isEmpty) {
              return const Center(child: Text("No products available"));
            }

            // Apply filters and search
            final filteredProducts = state.product
                .where((product) =>
                    (selectedType == null || product.type == selectedType) &&
                    (double.tryParse(product.price) ?? 0) <= maxPrice &&
                    (product.productName
                        .toLowerCase()
                        .contains(searchController.text.toLowerCase())))
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
                            hintText: "Search products...",
                            prefixIcon: const Icon(Icons.search),
                            filled: true,
                            fillColor: Colors.grey[200],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          onChanged: (value) {
                            setState(() {});
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

                // Product List
                Expanded(
                  child: filteredProducts.isEmpty
                      ? const Center(child: Text("No products found"))
                      : ListView.builder(
                          itemCount: filteredProducts.length,
                          itemBuilder: (BuildContext context, index) {
                            final product = filteredProducts[index];

                            final String imageFileName =
                                product.image?.split('/').last ?? "";
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
                                  borderRadius: BorderRadius.circular(12)),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ProductDetailView(product: product ),
                                    ),
                                  );
                                },
                                child: ListTile(
                                  contentPadding: const EdgeInsets.all(10),
                                  leading: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.network(
                                      imageUrl,
                                      width: 80,
                                      height: 80,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return const Icon(
                                          Icons.image_not_supported,
                                          size: 80,
                                          color: Colors.grey,
                                        );
                                      },
                                    ),
                                  ),
                                  title: Text(
                                    product.productName,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  subtitle: Text(
                                    "Rs: ${product.price}",
                                    style: const TextStyle(
                                        fontSize: 14, color: Colors.black54),
                                  ),
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
                    "Filter Products",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),

                  // Dropdown for product type
                  DropdownButtonFormField<String>(
                    value: selectedType,
                    decoration: InputDecoration(
                      labelText: "Select Type",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    items: ["Shoe", "Clothing", "Accessory"]
                        .map((type) =>
                            DropdownMenuItem(value: type, child: Text(type)))
                        .toList(),
                    onChanged: (value) {
                      setModalState(() => selectedType = value);
                    },
                  ),
                  const SizedBox(height: 16),

                  // Price range filter
                  Text("Max Price: Rs $maxPrice"),
                  Slider(
                    value: maxPrice,
                    min: 1000,
                    max: 100000,
                    divisions: 20,
                    label: maxPrice.toString(),
                    onChanged: (value) {
                      setModalState(() => maxPrice = value);
                    },
                  ),
                  const SizedBox(height: 16),

                  // Apply button
                  ElevatedButton(
                    onPressed: () {
                      setState(() {});
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
