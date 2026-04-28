import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_project/core/helpers/extensions.dart';
import 'package:test_project/core/routing/routes.dart';
import 'package:test_project/features/cart/presentation/cubits/cart_cubit/cart_cubit.dart';

class CheckoutWidget extends StatelessWidget {
  const CheckoutWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        final cartCubit = context.read<CartCubit>();
        if (cartCubit.cartItems.isEmpty) return const SizedBox.shrink();
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total:'.tr(), style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  Text(
                    '${cartCubit.totalPrice.toStringAsFixed(2)} ${"EGP".tr()}',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.deepPurple),
                  ),
                ],
              ),
            ),
            8.0.height(),
            InkWell(
              onTap: () {
                context.pushNamed(Routes.checkoutPage);
              },
              child: Container(
                margin: const EdgeInsets.all(20),
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(color: Colors.deepPurple, borderRadius: BorderRadius.circular(20)),
                child: Center(
                  child: Text(
                    "Checkout".tr(),
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
