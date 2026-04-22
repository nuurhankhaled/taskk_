import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_project/core/di/dependency_injection.dart';
import 'package:test_project/features/fav_products/presentation/cubit/fav_products_cubit/fav_products_cubit.dart';
import 'package:test_project/features/home/data/models/product_model.dart';
import 'package:test_project/features/home/presentation/cubits/connectivity_cubit/internet_connection_cubit.dart';
import 'package:test_project/features/home/presentation/cubits/connectivity_cubit/internet_connection_state.dart';

class ProductPage extends StatelessWidget {
  ProductPage({super.key, required this.product});
  ProductModel product;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider.value(value: getIt<FavProductsCubit>())],
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("product details"),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios),
          ),
        ),
        body: SingleChildScrollView(
          child: BlocBuilder<InternetConnectionCubit, InternetConnectionState>(
            builder: (context, state) {
              return state is InternetNotConnectedState
                  ? Center(child: Text("No internet"))
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.network(
                          product.images![0],
                          height: 450,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 20,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: 15,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    product.title!,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Spacer(),
                                  BlocBuilder<
                                    FavProductsCubit,
                                    FavProductsState
                                  >(
                                    builder: (context, state) {
                                      final cubit = context
                                          .read<FavProductsCubit>();
                                      final isFav = cubit.isFavorite(
                                        product.id!,
                                      );

                                      return IconButton(
                                        onPressed: () async {
                                          if (isFav) {
                                            await context
                                                .read<FavProductsCubit>()
                                                .deleteData(product.id!);
                                          } else {
                                            await context
                                                .read<FavProductsCubit>()
                                                .writeData(
                                                  product.id!,
                                                  product.title,
                                                );
                                          }
                                        },
                                        icon: Icon(
                                          isFav
                                              ? Icons.favorite
                                              : Icons.favorite_outline,
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                              Text(
                                product.description!,
                                style: TextStyle(fontSize: 14),
                              ),
                              Text(
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                "Price : //${product.price!.toString()} EGP",
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
            },
          ),
        ),
        bottomNavigationBar: Container(
          margin: EdgeInsetsGeometry.all(20),
          width: double.infinity,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.deepPurple,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Text(
              "Add To Cart",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
