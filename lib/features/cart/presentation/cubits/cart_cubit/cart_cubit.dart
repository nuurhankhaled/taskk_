import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_project/features/cart/data/models/cart_model.dart';
import 'package:test_project/features/cart/data/repo/cart_repo.dart';
import 'package:test_project/features/home/data/models/product_model.dart';
part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final CartRepo _cartRepo;

  CartCubit(this._cartRepo) : super(CartInitial());

  List<CartModel> cartItems = [];

  void loadCart() {
    final result = _cartRepo.getCartItems();
    result.when(
      success: (items) {
        cartItems = items;
        emit(CartSuccess());
      },
      failure: (error) => emit(CartFailed(error)),
    );
  }

  Future<void> addToCart(ProductModel product) async {
    final isInCart = _cartRepo.isInCart(product.id!).when(success: (value) => value, failure: (_) => false);

    if (isInCart) {
      final currentQty = _cartRepo.getQuantity(product.id!).when(success: (value) => value, failure: (_) => 1);
      await incrementQuantity(product.id!, currentQty);
    } else {
      final cartModel = CartModel(product: product, quantity: 1);
      final result = await _cartRepo.addToCart(product.id!, cartModel);
      result.when(
        success: (_) {
          loadCart();
          emit(CartItemAdded());
        },
        failure: (error) => emit(CartFailed(error)),
      );
    }
  }

  Future<void> removeFromCart(int key) async {
    final result = await _cartRepo.removeFromCart(key);
    result.when(
      success: (_) {
        cartItems.removeWhere((item) => item.product.id == key);
        emit(CartItemRemoved());
      },
      failure: (error) => emit(CartFailed(error)),
    );
  }

  Future<void> incrementQuantity(int key, int currentQty) async {
    final result = await _cartRepo.updateQuantity(key, currentQty + 1);
    result.when(
      success: (_) {
        loadCart();
        emit(CartItemUpdated());
      },
      failure: (error) => emit(CartFailed(error)),
    );
  }

  Future<void> decrementQuantity(int key, int currentQty) async {
    if (currentQty <= 1) {
      await removeFromCart(key);
      return;
    }
    final result = await _cartRepo.updateQuantity(key, currentQty - 1);
    result.when(
      success: (_) {
        loadCart();
        emit(CartItemUpdated());
      },
      failure: (error) => emit(CartFailed(error)),
    );
  }

  Future<void> clearCart() async {
    final result = await _cartRepo.clearCart();
    result.when(
      success: (_) {
        cartItems = [];
        emit(CartCleared());
      },
      failure: (error) => emit(CartFailed(error)),
    );
  }

  bool isInCart(int key) {
    return _cartRepo.isInCart(key).when(success: (value) => value, failure: (_) => false);
  }

  int getQuantity(int key) {
    return _cartRepo.getQuantity(key).when(success: (value) => value, failure: (_) => 0);
  }

  double get totalPrice => cartItems.fold(0, (sum, item) => sum + (item.product.price! * item.quantity));
}
