import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_project/core/helpers/extensions.dart';
import 'package:test_project/features/cart/presentation/cubits/cart_cubit/cart_cubit.dart';
import 'package:test_project/features/home/data/models/product_model.dart';

class AddToCartWidget extends StatelessWidget {
  const AddToCartWidget({super.key, required this.product});
  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartCubit, CartState>(
      listener: (context, state) {
        if (state is CartItemAdded) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Item added to cart '), backgroundColor: Colors.green, duration: Duration(seconds: 1)));
        } else if (state is CartItemUpdated) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Quantity updated'), backgroundColor: Colors.deepPurple, duration: Duration(seconds: 1)));
        } else if (state is CartItemRemoved) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Item removed from cart'), backgroundColor: Colors.red, duration: Duration(seconds: 1)));
        }
      },
      builder: (context, state) {
        final cartCubit = context.read<CartCubit>();
        final isInCart = cartCubit.isInCart(product.id!);
        final quantity = cartCubit.getQuantity(product.id!);

        return Container(
          margin: const EdgeInsets.all(16),
          height: 60,
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () async {
                    await cartCubit.addToCart(product);
                  },
                  child: Container(
                    height: 60,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.deepPurple),
                      color: isInCart ? Colors.transparent : Colors.deepPurple,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        isInCart ? 'Added to Cart' : 'Add to Cart',
                        style: TextStyle(color: isInCart ? Colors.deepPurple : Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
              if (isInCart) ...[
                12.0.width(),
                Container(
                  height: 60,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.deepPurple),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () async {
                          await cartCubit.decrementQuantity(product.id!, quantity);
                        },
                        icon: const Icon(Icons.remove, color: Colors.deepPurple),
                      ),
                      Text(
                        '$quantity',
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.deepPurple),
                      ),
                      IconButton(
                        onPressed: () async {
                          await cartCubit.incrementQuantity(product.id!, quantity);
                        },
                        icon: const Icon(Icons.add, color: Colors.deepPurple),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}
