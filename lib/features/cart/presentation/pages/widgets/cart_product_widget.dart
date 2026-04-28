import 'package:flutter/material.dart';
import 'package:test_project/core/helpers/extensions.dart';
import 'package:test_project/features/cart/data/models/cart_model.dart';
import 'package:test_project/features/cart/presentation/cubits/cart_cubit/cart_cubit.dart';

class CartProductWidget extends StatelessWidget {
  const CartProductWidget({
    super.key,
    required this.item,
    required this.cartCubit,
  });

  final CartModel item;
  final CartCubit cartCubit;

  @override
  Widget build(BuildContext context) {
    final quantity = item.quantity;
    final screenWidth = MediaQuery.of(context).size.width;
    final imageSize = screenWidth * 0.25;

    return Container(
      padding: const EdgeInsets.all(8),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(color: Colors.black12, spreadRadius: -2, blurRadius: 5),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // image
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: SizedBox(
              height: imageSize * 1.3,
              width: imageSize,
              child: Image.network(
                item.product.images![0],
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Center(
                  child: Icon(
                    Icons.broken_image,
                    size: imageSize * 0.4,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          ),

          SizedBox(width: screenWidth * 0.03),

          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                5.0.height(),
                Text(
                  item.product.title!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: screenWidth * 0.035,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: screenWidth * 0.02),

                Text(
                  '${item.product.price} EGP',
                  style: TextStyle(
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.bold,
                    fontSize: screenWidth * 0.033,
                  ),
                ),

                // quantity controls
                Row(
                  children: [
                    IconButton(
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      onPressed: () async {
                        await cartCubit.decrementQuantity(
                          item.product.id!,
                          quantity,
                        );
                      },
                      icon: Icon(
                        Icons.remove_circle_outline,
                        color: Colors.deepPurple,
                        size: screenWidth * 0.055,
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.02),
                    Text(
                      '$quantity',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: screenWidth * 0.035,
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.02),
                    IconButton(
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      onPressed: () async {
                        await cartCubit.incrementQuantity(
                          item.product.id!,
                          quantity,
                        );
                      },
                      icon: Icon(
                        Icons.add_circle_outline,
                        color: Colors.deepPurple,
                        size: screenWidth * 0.055,
                      ),
                    ),
                  ],
                ),

                // subtotal
                Text(
                  'Subtotal: ${(item.product.price! * quantity)} EGP',
                  style: TextStyle(
                    fontSize: screenWidth * 0.03,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),

          // delete button
          IconButton(
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            onPressed: () async {
              await cartCubit.removeFromCart(item.product.id!);
            },
            icon: Icon(
              Icons.delete_outline,
              color: Colors.red,
              size: screenWidth * 0.055,
            ),
          ),
        ],
      ),
    );
  }
}
