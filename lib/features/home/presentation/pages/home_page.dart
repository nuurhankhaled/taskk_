import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_project/features/home/presentation/cubits/products_cubit/products_cubit.dart';
import 'package:test_project/features/home/presentation/pages/widgets/product_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("products")),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
        child: BlocBuilder<ProductsCubit, ProductsState>(
          builder: (context, state) {
            return (state is ProductsLoading)
                ? Center(child: CircularProgressIndicator())
                : (state is ProductsFailed)
                ? Center(child: Text("Error"))
                : (context.read<ProductsCubit>().products.isEmpty)
                ? Center(child: Text("Empty"))
                : MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 5,
                            mainAxisSpacing: 5,
                            childAspectRatio: 0.9,
                          ),
                      itemCount: context.read<ProductsCubit>().products.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ProductWidget(
                          product: context
                              .read<ProductsCubit>()
                              .products[index],
                        );
                      },
                    ),
                  );
          },
        ),
      ),
    );
  }
}
