import 'package:test_project/core/network/network/api_result.dart';
import 'package:test_project/features/home/data/local/products_local_data_source.dart';
import 'package:test_project/features/home/data/models/product_model.dart';
import 'package:test_project/features/home/data/remote/products_api_services.dart';

class ProductsRepo {
  final ProductsApiService _productsApiService;
  final ProductsLocalDataSource _localDataSource;

  ProductsRepo(this._productsApiService, this._localDataSource);

  Future<AppResult<List<ProductModel>>> getHomeData() async {
    try {
      final response = await _productsApiService.getProducts();
      await _localDataSource.cacheProducts(response);
      return AppResult.success(response);
    } catch (e) {
      return AppResult.failure(e.toString());
    }
  }

  Future<AppResult<List<ProductModel>>> getCachedProducts() async {
    try {
      final products = _localDataSource.getCachedProducts();
      if (products.isEmpty) {
        return AppResult.failure('No cached products');
      }
      return AppResult.success(products);
    } catch (e) {
      return AppResult.failure(e.toString());
    }
  }
}
