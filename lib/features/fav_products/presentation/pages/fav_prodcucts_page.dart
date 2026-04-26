import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_project/features/fav_products/presentation/cubit/fav_products_cubit/fav_products_cubit.dart';
import 'package:test_project/features/home/presentation/pages/widgets/product_widget.dart';

class FavProdcuctsPage extends StatelessWidget {
  const FavProdcuctsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
        child: BlocBuilder<FavProductsCubit, FavProductsState>(
          builder: (context, state) {
            return (state is FavProductsLoading)
                ? Center(child: CircularProgressIndicator())
                : (state is FavProductsFailed)
                ? Center(child: Text("Error"))
                : (context.read<FavProductsCubit>().favProducts.isEmpty)
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
                      itemCount: context
                          .read<FavProductsCubit>()
                          .favProducts
                          .length,
                      itemBuilder: (BuildContext context, int index) {
                        return ProductWidget(
                          product: context
                              .read<FavProductsCubit>()
                              .favProducts[index],
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
