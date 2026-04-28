import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_project/core/helpers/extensions.dart';
import 'package:test_project/features/cart/presentation/cubits/cart_cubit/cart_cubit.dart';
import 'package:test_project/features/checkout/presentation/pages/payment_page.dart';
import 'package:test_project/features/checkout/presentation/pages/widgets/checkout_product_widget.dart';
import 'package:test_project/features/checkout/presentation/pages/widgets/price_row_widget.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key});

  static const double _shipping = 50;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        final cartCubit = context.read<CartCubit>();
        final cartItems = cartCubit.cartItems;
        final subtotal = cartCubit.totalPrice;
        final total = subtotal + _shipping;

        return Scaffold(
          appBar: AppBar(
            title: Text('Checkout'.tr()),
            centerTitle: true,
            leading: IconButton(onPressed: () => context.pop(), icon: const Icon(Icons.arrow_back_ios)),
          ),
          body: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Order Summary'.tr(), style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      16.0.height(),
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: cartItems.length,
                        separatorBuilder: (_, __) => const Divider(),
                        itemBuilder: (context, index) {
                          final item = cartItems[index];
                          return CheckoutProductWidget(item: item);
                        },
                      ),

                      24.0.height(),

                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(color: Theme.of(context).brightness == Brightness.dark ? Colors.grey.shade900 : Colors.grey.shade100, borderRadius: BorderRadius.circular(12)),
                        child: Column(
                          children: [
                            PriceRowWidget(label: 'Subtotal'.tr(), value: '${subtotal.toStringAsFixed(2)} ${"EGP".tr()}'),
                            const SizedBox(height: 8),
                            PriceRowWidget(label: 'Shipping'.tr(), value: '$_shipping ${"EGP".tr()}'),
                            const Divider(height: 24),
                            PriceRowWidget(label: 'Total'.tr(), value: '${total.toStringAsFixed(2)} ${"EGP".tr()}', isBold: true),
                          ],
                        ),
                      ),
                      24.0.height(),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(color: Theme.of(context).brightness == Brightness.dark ? Colors.grey.shade900 : Colors.grey.shade100, borderRadius: BorderRadius.circular(12)),
                        child: const Row(
                          children: [
                            Icon(Icons.location_on, color: Colors.deepPurple),
                            SizedBox(width: 8),
                            Expanded(
                              child: Text('123 Mock Street, Cairo, Egypt', style: TextStyle(fontSize: 14, color: Colors.grey)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(16),
                child: SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    ),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const MockPaymentScreen()));
                    },
                    child: Text(
                      'Proceed to Payment'.tr(),
                      style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
