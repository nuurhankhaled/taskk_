import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_project/features/fav_products/data/repo/fav_products_repo.dart';
import 'package:test_project/features/home/data/models/product_model.dart';
import 'package:test_project/features/home/data/repo/products_repo.dart';
part 'fav_products_state.dart';

class FavProductsCubit extends Cubit<FavProductsState> {
  final ProductsRepo _productsRepo;
  final FavProductsRepo _favRepo;

  FavProductsCubit(this._productsRepo, this._favRepo)
    : super(FavProductsInitial());

  List<ProductModel> favProducts = [];

  static FavProductsCubit get(BuildContext context) =>
      BlocProvider.of<FavProductsCubit>(context);

  bool isFavorite(int id) {
    return _favRepo
        .isFavourite(id)
        .when(success: (value) => value, failure: (_) => false);
  }

  Future<void> writeData(int key, dynamic value) async {
    final result = await _favRepo.addFavourite(key, value);
    result.when(
      success: (_) {
        final keys = _favRepo.getAllKeys().when(
          success: (keys) => keys,
          failure: (_) => <int>[],
        );
        emit(ProductAddedToFav(keys));
      },
      failure: (_) => emit(FavProductsFailed()),
    );
  }

  Future<void> deleteData(int key) async {
    final result = await _favRepo.removeFavourite(key);
    result.when(
      success: (_) {
        favProducts.removeWhere((product) => product.id == key);
        final keys = _favRepo.getAllKeys().when(
          success: (keys) => keys,
          failure: (_) => <int>[],
        );
        emit(ProductRemovedToFav(keys));
      },
      failure: (_) => emit(FavProductsFailed()),
    );
  }

  Future<void> getAllFavourites() async {
    final keysResult = _favRepo.getAllKeys();
    keysResult.when(
      success: (keys) async {
        if (keys.isEmpty) {
          favProducts = [];
          emit(GetAllFav());
          return;
        }
        emit(FavProductsLoading());
        final response = await _productsRepo.getHomeData();
        response.when(
          success: (data) {
            favProducts = data
                .where((product) => keys.contains(product.id))
                .toList();
            emit(GetAllFav());
          },
          failure: (_) => emit(FavProductsFailed()),
        );
      },
      failure: (_) => emit(FavProductsFailed()),
    );
  }
}
