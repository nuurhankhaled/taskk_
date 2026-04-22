part of 'products_cubit.dart';

sealed class ProductsState {}

class ProductsInitial extends ProductsState {}

class ProductsLoading extends ProductsState {}

class ProductsSuccess extends ProductsState {}

class ProductsFailed extends ProductsState {}
