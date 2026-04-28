import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_project/core/di/dependency_injection.dart';
import 'package:test_project/features/cart/presentation/cubits/cart_cubit/cart_cubit.dart';
import 'package:test_project/features/fav_products/presentation/cubit/fav_products_cubit/fav_products_cubit.dart';
import 'package:test_project/features/home/data/models/product_model.dart';
import 'package:test_project/core/cubit/connectivity_cubit/internet_connection_cubit.dart';
import 'package:test_project/core/cubit/connectivity_cubit/internet_connection_state.dart';
import 'package:test_project/features/product/presentation/pages/widgets/add_to_cart_widget.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key, required this.product});
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: getIt<FavProductsCubit>()),
        BlocProvider.value(value: getIt<CartCubit>()..loadCart()),
      ],
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Product Details".tr()),
          leading: IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.arrow_back_ios)),
        ),
        body: SingleChildScrollView(
          child: BlocBuilder<InternetConnectionCubit, InternetConnectionState>(
            builder: (context, state) {
              return state is InternetNotConnectedState
                  ? Center(child: Text("No internet".tr()))
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.45,
                          child: Image.network(
                            width: double.infinity,
                            product.images![0],
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) => const Center(child: Icon(Icons.broken_image, size: 50, color: Colors.grey)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 15),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(product.title!, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                  ),
                                  const SizedBox(width: 10),
                                  BlocBuilder<FavProductsCubit, FavProductsState>(
                                    builder: (context, state) {
                                      final cubit = context.read<FavProductsCubit>();
                                      final isFav = cubit.isFavorite(product.id!);
                                      return IconButton(
                                        onPressed: () async {
                                          if (isFav) {
                                            await context.read<FavProductsCubit>().deleteData(product.id!);
                                          } else {
                                            await context.read<FavProductsCubit>().writeData(product);
                                          }
                                        },
                                        icon: Icon(isFav ? Icons.favorite : Icons.favorite_outline, color: isFav ? Colors.red : Colors.black),
                                      );
                                    },
                                  ),
                                ],
                              ),
                              const SizedBox(height: 15),
                              Text(product.description!, style: const TextStyle(fontSize: 14)),
                              const SizedBox(height: 15),
                              Text(
                                "${"Price:".tr()} ${product.price!.toString()} ${"EGP".tr()}",
                                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.deepPurple),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
            },
          ),
        ),

        bottomNavigationBar: AddToCartWidget(product: product),
      ),
    );
  }
}
