import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_project/core/helpers/extensions.dart';
import 'package:test_project/core/utility/custom_snack_bar.dart';
import 'package:test_project/features/cart/presentation/cubits/cart_cubit/cart_cubit.dart';
import 'package:test_project/features/cart/presentation/pages/widgets/cart_product_widget.dart';
import 'package:test_project/features/cart/presentation/pages/widgets/checkout_widget.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        leading: IconButton(icon: const Icon(Icons.arrow_back_ios), onPressed: () => context.pop()),
      ),
      bottomNavigationBar: CheckoutWidget(),
      body: BlocConsumer<CartCubit, CartState>(
        listener: (context, state) {
          if (state is CartItemRemoved) {
            context.showErrorSnackBar('Item removed from cart');
          } else if (state is CartItemUpdated) {
            context.showInfoSnackBar('Quantity updated');
          } else if (state is CartCleared) {
            context.showErrorSnackBar('Cart cleared');
          }
        },
        builder: (context, state) {
          final cartCubit = context.read<CartCubit>();

          if (state is CartLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (cartCubit.cartItems.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shopping_cart_outlined, size: 80, color: Colors.grey),
                  SizedBox(height: 16),
                  Text('Your cart is empty', style: TextStyle(fontSize: 16, color: Colors.grey)),
                ],
              ),
            );
          }

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton.icon(
                      onPressed: () => cartCubit.clearCart(),
                      icon: const Icon(Icons.delete_outline, color: Colors.red),
                      label: const Text('Clear Cart', style: TextStyle(color: Colors.red)),
                    ),
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: cartCubit.cartItems.length,
                    separatorBuilder: (_, __) => 12.0.height(),
                    itemBuilder: (context, index) {
                      final item = cartCubit.cartItems[index];
                      return CartProductWidget(item: item, cartCubit: cartCubit);
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
