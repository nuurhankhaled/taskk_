import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:test_project/core/helpers/extensions.dart';
import 'package:test_project/features/cart/data/models/cart_model.dart';

class CheckoutProductWidget extends StatelessWidget {
  const CheckoutProductWidget({super.key, required this.item});
  final CartModel item;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            item.product.images![0],
            width: 60,
            height: 60,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Container(
              width: 60,
              height: 60,
              color: Colors.grey.shade300,
              child: const Icon(Icons.image_not_supported, color: Colors.grey),
            ),
          ),
        ),
        12.0.width(),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.product.title!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text('${"Quantity:".tr()} ${item.quantity}'),
            ],
          ),
        ),
        Text('${item.product.price! * item.quantity} ${"EGP".tr()}', style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }
}
