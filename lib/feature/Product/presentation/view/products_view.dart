import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stockvision_app/core/common/snackbar/my_snackbar.dart';
import 'package:stockvision_app/feature/Product/presentation/view_model/bloc/product_bloc.dart';

class ProductsView extends StatefulWidget {
  const ProductsView({super.key});

  @override
  State<ProductsView> createState() => _ProductsViewState();
}

class _ProductsViewState extends State<ProductsView> {
  final productNameController = TextEditingController();
  final descriptionController = TextEditingController();
  final typeController = TextEditingController();
  final quantityController = TextEditingController();
  final priceController = TextEditingController();

  final _productViewFormKey = GlobalKey<FormState>();

  File? _img;

  Future<void> _browseImage(
      BuildContext context, ImageSource imageSource) async {
    try {
      final image = await ImagePicker().pickImage(source: imageSource);
      if (image != null) {
        setState(() {
          _img = File(image.path);
        });
        if (_img != null) {
          context.read<ProductBloc>().add(LoadProductImage(file: _img!));
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void _showImagePickerOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pop(context);
                _browseImage(context, ImageSource.camera);
              },
              icon: const Icon(Icons.camera),
              label: const Text('Camera'),
            ),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pop(context);
                _browseImage(context, ImageSource.gallery);
              },
              icon: const Icon(Icons.image),
              label: const Text('Gallery'),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddProductDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: Form(
              key: _productViewFormKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildTextField(productNameController, "Product Name",
                      Icons.shopping_bag),
                  InkWell(
                    onTap: () => _showImagePickerOptions(context),
                    child: _img != null
                        ? Image.file(_img!,
                            height: 100, width: 100, fit: BoxFit.cover)
                        : const Icon(Icons.image,
                            size: 100, color: Colors.grey),
                  ),
                  _buildTextField(
                      descriptionController, "Description", Icons.description),
                  _buildTextField(typeController, "Type", Icons.category),
                  _buildTextField(quantityController, "Quantity", Icons.numbers,
                      isNumeric: true),
                  _buildTextField(priceController, "Price", Icons.attach_money,
                      isNumeric: true),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              child: const Text("Cancel"),
              onPressed: () => Navigator.of(context).pop(),
            ),
            ElevatedButton(
              child: const Text("Add"),
              onPressed: () {
                if (_productViewFormKey.currentState!.validate()) {
                  context.read<ProductBloc>().add(
                        AddProduct(
                          productName: productNameController.text,
                          image: _img?.path ?? "",
                          description: descriptionController.text,
                          type: typeController.text,
                          quantity: int.parse(quantityController.text),
                          price: int.parse(priceController.text),
                        ),
                      );
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildTextField(
      TextEditingController controller, String label, IconData icon,
      {bool isNumeric = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        controller: controller,
        keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) return "Enter $label";
          if (isNumeric && int.tryParse(value) == null)
            return "Enter a valid number";
          return null;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: BlocConsumer<ProductBloc, ProductState>(
          listener: (context, state) {
            if (state.error != null) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                showMySnackBar(
                    context: context, message: state.error!, color: Colors.red);
              });
            }
          },
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state.product.isEmpty) {
              return const Center(child: Text("No products available"));
            }

            return ListView.builder(
              itemCount: state.product.length,
              itemBuilder: (BuildContext context, index) {
                final product = state.product[index];
                return ListTile(
                  leading: product.image.isNotEmpty
                      ? Image.network(product.image,
                          width: 50, height: 50, fit: BoxFit.cover)
                      : const Icon(Icons.image, size: 50, color: Colors.grey),
                  title: Text(product.productName,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text("ID: ${product.productId}"),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      context
                          .read<ProductBloc>()
                          .add(DeleteProduct(product.productId!));
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddProductDialog(context),
        backgroundColor: Colors.orange,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
