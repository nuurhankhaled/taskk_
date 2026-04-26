import 'package:test_project/core/network/network/api_result.dart';
import 'package:test_project/features/fav_products/data/local_data_source/fav_products_local_source.dart';
import 'package:test_project/features/home/data/models/product_model.dart';

class FavProductsRepo {
  final FavProductsLocalDataSource _localDataSource;
  FavProductsRepo(this._localDataSource);

  Future<AppResult<void>> addFavourite(int key, ProductModel product) async {
    try {
      await _localDataSource.addFavourite(key, product);
      return AppResult.success(null);
    } catch (e) {
      return AppResult.failure(e.toString());
    }
  }

  Future<AppResult<void>> removeFavourite(int key) async {
    try {
      await _localDataSource.removeFavourite(key);
      return AppResult.success(null);
    } catch (e) {
      return AppResult.failure(e.toString());
    }
  }

  AppResult<List<int>> getAllKeys() {
    try {
      return AppResult.success(_localDataSource.getAllKeys());
    } catch (e) {
      return AppResult.failure(e.toString());
    }
  }

  AppResult<bool> isFavourite(int key) {
    try {
      return AppResult.success(_localDataSource.isFavourite(key));
    } catch (e) {
      return AppResult.failure(e.toString());
    }
  }

  AppResult<List<ProductModel>> getFavouriteProducts() {
    try {
      return AppResult.success(_localDataSource.getAllProducts());
    } catch (e) {
      return AppResult.failure(e.toString());
    }
  }
}
