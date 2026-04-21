part of 'fav_products_cubit.dart';

abstract class FavProductsState extends Equatable {
  const FavProductsState();

  @override
  List<Object> get props => [];
}

class FavProductsInitial extends FavProductsState {}

class FavProductsLoading extends FavProductsState {}

class ProductAddedToFav extends FavProductsState {
  final List<int> favIds;

  ProductAddedToFav(this.favIds);
  @override
  List<Object> get props => [favIds];
}

class ProductRemovedToFav extends FavProductsState {
  final List<int> favIds;

  ProductRemovedToFav(this.favIds);
  @override
  List<Object> get props => [favIds];
}

class GetAllFav extends FavProductsState {}

class FavProductsFailed extends FavProductsState {}
