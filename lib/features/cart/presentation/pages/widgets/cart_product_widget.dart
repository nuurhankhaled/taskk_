import 'package:flutter/material.dart';
import 'package:test_project/core/helpers/extensions.dart';
import 'package:test_project/features/cart/data/models/cart_model.dart';
import 'package:test_project/features/cart/presentation/cubits/cart_cubit/cart_cubit.dart';

class CartProductWidget extends StatelessWidget {
  const CartProductWidget({super.key, required this.item, required this.cartCubit});

  final CartModel item;
  final CartCubit cartCubit;

  @override
  Widget build(BuildContext context) {
    final quantity = item.quantity;

    return Container(
      padding: const EdgeInsets.all(10),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: const [BoxShadow(color: Colors.black12, spreadRadius: -2, blurRadius: 5)],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: SizedBox(
              height: 130,
              width: 100,
              child: Image.network(
                item.product.images![0],
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => const Center(child: Icon(Icons.broken_image, size: 50, color: Colors.grey)),
              ),
            ),
          ),
          20.0.width(),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.product.title!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                15.0.height(),
                Row(
                  children: [
                    Text(
                      '${item.product.price} EGP',
                      style: const TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () async {
                            await cartCubit.decrementQuantity(item.product.id!, quantity);
                          },
                          icon: const Icon(Icons.remove_circle_outline, color: Colors.deepPurple),
                        ),
                        Text('$quantity', style: const TextStyle(fontWeight: FontWeight.bold)),
                        IconButton(
                          onPressed: () async {
                            await cartCubit.incrementQuantity(item.product.id!, quantity);
                          },
                          icon: const Icon(Icons.add_circle_outline, color: Colors.deepPurple),
                        ),
                      ],
                    ),
                  ],
                ),
                Text('Subtotal: ${(item.product.price! * quantity)} EGP', style: const TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
          ),
          IconButton(
            onPressed: () async {
              await cartCubit.removeFromCart(item.product.id!);
            },
            icon: const Icon(Icons.delete_outline, color: Colors.red),
          ),
        ],
      ),
    );
  }
}
