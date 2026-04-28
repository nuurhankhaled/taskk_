part of 'products_cubit.dart';

sealed class ProductsState {}

class ProductsInitial extends ProductsState {}

class ProductsLoading extends ProductsState {}

class ProductsSuccess extends ProductsState {
  final bool isSynced;
  ProductsSuccess({this.isSynced = false});
}

class ProductsFailed extends ProductsState {
  final bool isNoInternet;
  ProductsFailed({this.isNoInternet = false});
}

class PaginationLoading extends ProductsState {}
