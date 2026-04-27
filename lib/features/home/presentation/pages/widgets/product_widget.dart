import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_project/core/helpers/extensions.dart';
import 'package:test_project/core/routing/routes.dart';
import 'package:test_project/features/fav_products/presentation/cubit/fav_products_cubit/fav_products_cubit.dart';
import 'package:test_project/features/home/data/models/product_model.dart';
import 'package:test_project/features/product/presentation/pages/product_page.dart';

class ProductWidget extends StatelessWidget {
  ProductWidget({super.key, required this.product});
  ProductModel product;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavProductsCubit, FavProductsState>(
      builder: (context, state) {
        final cubit = context.read<FavProductsCubit>();
        final isFav = cubit.isFavorite(product.id!);
        return GestureDetector(
          onTap: () {
            context.pushNamed(Routes.productPage, arguments: product);
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [BoxShadow(color: Colors.black12, spreadRadius: -2, blurRadius: 5)],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadiusGeometry.vertical(top: Radius.circular(10)),
                      child: SizedBox(
                        height: 130,
                        width: double.infinity,
                        child: Image.network(
                          product.images![0],
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Center(child: Icon(Icons.broken_image, size: 50, color: Colors.grey)),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      child: IconButton(
                        onPressed: () async {
                          if (isFav) {
                            await context.read<FavProductsCubit>().deleteData(product.id!);
                          } else {
                            await context.read<FavProductsCubit>().writeData(product);
                          }
                        },
                        icon: Icon(isFav ? Icons.favorite : Icons.favorite_outline, color: isFav ? Colors.red : Colors.black),
                      ),
                    ),
                  ],
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(maxLines: 2, overflow: TextOverflow.ellipsis, product.title!),
                      Text(maxLines: 2, overflow: TextOverflow.ellipsis, "Price : ${product.price!.toString()} EGP"),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
