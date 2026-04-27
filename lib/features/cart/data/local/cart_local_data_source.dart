import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:test_project/features/cart/data/models/cart_model.dart';

class CartLocalDataSource {
  final Box _box;
  CartLocalDataSource(this._box);

  Future<void> addToCart(int key, CartModel cartModel) => _box.put(key, jsonEncode(cartModel.toJson()));

  Future<void> removeFromCart(int key) => _box.delete(key);

  Future<void> updateQuantity(int key, int quantity) async {
    final existing = _box.get(key);
    if (existing == null) return;
    final cartModel = CartModel.fromJson(jsonDecode(existing as String));
    await _box.put(key, jsonEncode(cartModel.copyWith(quantity: quantity).toJson()));
  }

  Future<void> clearCart() => _box.clear();

  List<CartModel> getCartItems() => _box.values.map((e) => CartModel.fromJson(jsonDecode(e as String))).toList();

  bool isInCart(int key) => _box.containsKey(key);

  int getQuantity(int key) {
    final existing = _box.get(key);
    if (existing == null) return 0;
    return CartModel.fromJson(jsonDecode(existing as String)).quantity;
  }
}
