import 'package:test_project/features/home/data/models/product_model.dart';

class CartModel {
  final ProductModel product;
  final int quantity;

  CartModel({required this.product, required this.quantity});

  CartModel copyWith({ProductModel? product, int? quantity}) {
    return CartModel(product: product ?? this.product, quantity: quantity ?? this.quantity);
  }

  Map<String, dynamic> toJson() => {'product': product.toJson(), 'quantity': quantity};

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(product: ProductModel.fromJson(json['product']), quantity: json['quantity']);
}
