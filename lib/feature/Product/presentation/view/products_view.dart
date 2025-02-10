import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stockvision_app/core/common/card/productcardsview.dart';
import 'package:stockvision_app/feature/Product/presentation/view_model/bloc/product_bloc.dart';

class ProductsView extends StatelessWidget {
  const ProductsView({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<ProductBloc>().add(GetAllProduct());

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

            return ListView.builder(
              itemCount: state.product.length,
              itemBuilder: (BuildContext context, index) {
                final product = state.product[index];
                return MyProductCard(product: product, color: Colors.blue);
              },
            );
          },
        ),
      ),
    );
  }
}
