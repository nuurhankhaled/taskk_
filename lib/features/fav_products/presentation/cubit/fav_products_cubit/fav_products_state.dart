part of 'fav_products_cubit.dart';

sealed class FavProductsState {}

class FavProductsInitial extends FavProductsState {}

class FavProductsLoading extends FavProductsState {}

class ProductAddedToFav extends FavProductsState {
  final List<int> favIds;

  ProductAddedToFav(this.favIds);
}

class ProductRemovedToFav extends FavProductsState {
  final List<int> favIds;

  ProductRemovedToFav(this.favIds);
}

class GetAllFav extends FavProductsState {}

class FavProductsFailed extends FavProductsState {}
