import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_project/features/fav_products/data/repo/fav_products_repo.dart';
import 'package:test_project/features/home/data/models/product_model.dart';
part 'fav_products_state.dart';

class FavProductsCubit extends Cubit<FavProductsState> {
  final FavProductsRepo _favRepo;

  FavProductsCubit(this._favRepo) : super(FavProductsInitial());

  List<ProductModel> favProducts = [];

  static FavProductsCubit get(BuildContext context) =>
      BlocProvider.of<FavProductsCubit>(context);

  bool isFavorite(int id) {
    return _favRepo
        .isFavourite(id)
        .when(success: (value) => value, failure: (_) => false);
  }

  Future<void> writeData(ProductModel product) async {
    final result = await _favRepo.addFavourite(product.id!, product);
    result.when(
      success: (_) => emit(
        ProductAddedToFav(
          _favRepo.getAllKeys().when(
            success: (keys) => keys,
            failure: (_) => <int>[],
          ),
        ),
      ),
      failure: (_) => emit(FavProductsFailed()),
    );
  }

  Future<void> deleteData(int key) async {
    final result = await _favRepo.removeFavourite(key);
    result.when(
      success: (_) {
        favProducts.removeWhere((product) => product.id == key);
        emit(
          ProductRemovedToFav(
            _favRepo.getAllKeys().when(
              success: (keys) => keys,
              failure: (_) => <int>[],
            ),
          ),
        );
      },
      failure: (_) => emit(FavProductsFailed()),
    );
  }

  Future<void> getAllFavourites() async {
    final result = _favRepo.getFavouriteProducts();
    result.when(
      success: (products) {
        favProducts = products;
        emit(GetAllFav());
      },
      failure: (_) => emit(FavProductsFailed()),
    );
  }
}
