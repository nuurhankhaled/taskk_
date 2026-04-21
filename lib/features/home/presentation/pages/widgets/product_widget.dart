import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:test_project/features/fav_products/presentation/cubit/fav_products_cubit/fav_products_cubit.dart';
import 'package:test_project/features/home/data/models/product_model.dart';
import 'package:test_project/features/product/presentation/pages/product_page.dart';

class ProductWidget extends StatelessWidget {
  ProductWidget({super.key, required this.product});
  ProductModel product;
  final favBox = Hive.box("favBox");

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavProductsCubit, FavProductsState>(
      builder: (context, state) {
        final cubit = context.read<FavProductsCubit>();
        final isFav = cubit.isFavorite(product.id!);
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductPage(product: product),
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  spreadRadius: -2,
                  blurRadius: 5,
                ),
              ],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Positioned(
                      right: 0,
                      child: IconButton(
                        onPressed: () async {
                          if (isFav) {
                            await context.read<FavProductsCubit>().deleteData(
                              product.id!,
                            );
                          } else {
                            await context.read<FavProductsCubit>().writeData(
                              product.id!,
                              product.title,
                            );
                          }
                        },
                        icon: Icon(
                          isFav ? Icons.favorite : Icons.favorite_outline,
                        ),
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadiusGeometry.vertical(
                        top: Radius.circular(10),
                      ),
                      child: SizedBox(
                        height: 130,
                        child: Image.network(
                          width: double.infinity,
                          product.images![0],
                        ),
                      ),
                    ),
                  ],
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        product.title!,
                      ),
                      Text(
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        "Price : ${product.price!.toString()} EGP",
                      ),
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
