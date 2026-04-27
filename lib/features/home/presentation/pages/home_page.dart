import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_project/core/cubit/connectivity_cubit/internet_connection_cubit.dart';
import 'package:test_project/core/cubit/connectivity_cubit/internet_connection_state.dart';
import 'package:test_project/features/home/presentation/cubits/products_cubit/products_cubit.dart';
import 'package:test_project/features/home/presentation/pages/widgets/product_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<InternetConnectionCubit, InternetConnectionState>(
        builder: (context, internetState) {
          if (internetState is InternetNotConnectedState && context.read<ProductsCubit>().products.isEmpty) {
            return const Center(child: Text("No internet"));
          }
          return BlocBuilder<ProductsCubit, ProductsState>(
            builder: (context, state) {
              final cubit = context.read<ProductsCubit>();

              if (state is ProductsLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state is ProductsFailed) {
                return const Center(child: Text("Error"));
              }

              final products = cubit.products;
              final hasMore = cubit.hasMore;
              final isPaginating = state is PaginationLoading;

              if (products.isEmpty) {
                return const Center(child: Text("Empty"));
              }

              return Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
                      child: RefreshIndicator(
                        onRefresh: () => cubit.loadProducts(),
                        child: MediaQuery.removePadding(
                          context: context,
                          removeTop: true,
                          child: GridView.builder(
                            controller: cubit.scrollController,
                            physics: const AlwaysScrollableScrollPhysics(),
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 5, mainAxisSpacing: 5, childAspectRatio: 0.9),
                            itemCount: products.length + (hasMore ? 1 : 0),
                            itemBuilder: (context, index) {
                              if (index == products.length) {
                                return isPaginating ? const Center(child: CircularProgressIndicator()) : const SizedBox.shrink();
                              }
                              return ProductWidget(product: products[index]);
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
