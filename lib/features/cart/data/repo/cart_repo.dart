import 'package:test_project/core/network/network/api_result.dart';
import 'package:test_project/features/cart/data/local/cart_local_data_source.dart';
import 'package:test_project/features/cart/data/models/cart_model.dart';

class CartRepo {
  final CartLocalDataSource _localDataSource;
  CartRepo(this._localDataSource);

  Future<AppResult<void>> addToCart(int key, CartModel cartModel) async {
    try {
      await _localDataSource.addToCart(key, cartModel);
      return AppResult.success(null);
    } catch (e) {
      return AppResult.failure(e.toString());
    }
  }

  Future<AppResult<void>> removeFromCart(int key) async {
    try {
      await _localDataSource.removeFromCart(key);
      return AppResult.success(null);
    } catch (e) {
      return AppResult.failure(e.toString());
    }
  }

  Future<AppResult<void>> updateQuantity(int key, int quantity) async {
    try {
      await _localDataSource.updateQuantity(key, quantity);
      return AppResult.success(null);
    } catch (e) {
      return AppResult.failure(e.toString());
    }
  }

  Future<AppResult<void>> clearCart() async {
    try {
      await _localDataSource.clearCart();
      return AppResult.success(null);
    } catch (e) {
      return AppResult.failure(e.toString());
    }
  }

  AppResult<List<CartModel>> getCartItems() {
    try {
      return AppResult.success(_localDataSource.getCartItems());
    } catch (e) {
      return AppResult.failure(e.toString());
    }
  }

  AppResult<bool> isInCart(int key) {
    try {
      return AppResult.success(_localDataSource.isInCart(key));
    } catch (e) {
      return AppResult.failure(e.toString());
    }
  }

  AppResult<int> getQuantity(int key) {
    try {
      return AppResult.success(_localDataSource.getQuantity(key));
    } catch (e) {
      return AppResult.failure(e.toString());
    }
  }
}
