part of 'cart_cubit.dart';

sealed class CartState {
  const CartState();
}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartSuccess extends CartState {}

class CartFailed extends CartState {
  final String error;
  const CartFailed(this.error);
}

class CartItemAdded extends CartState {}

class CartItemRemoved extends CartState {}

class CartItemUpdated extends CartState {}

class CartCleared extends CartState {
  final bool silent;
  const CartCleared({this.silent = true});
}
