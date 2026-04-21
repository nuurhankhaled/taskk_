import 'package:test_project/core/network/network/api_result.dart';
import 'package:test_project/features/home/data/models/product_model.dart';
import 'package:test_project/features/home/data/remote/products_api_services.dart';

class ProductsRepo {
  final ProductsApiService _productsApiService;
  ProductsRepo(this._productsApiService);
  Future<ApiResult<List<ProductModel>>> getHomeData() async {
    try {
      final response = await _productsApiService.getProducts();
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.failure(e.toString());
    }
  }
}
