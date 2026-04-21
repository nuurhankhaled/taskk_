import 'package:dio/dio.dart';
import 'package:test_project/core/constant.dart';
import 'package:test_project/features/home/data/models/product_model.dart';

class ProductsApiService {
  final Dio _dio;
  static const String productsApi = 'products';

  ProductsApiService(this._dio);

  Future<List<ProductModel>> getProducts() async {
    try {
      final response = await _dio.get('$baseUrl$productsApi');

      // If response is a list
      if (response.data is List) {
        return (response.data as List)
            .map((item) => ProductModel.fromJson(item as Map<String, dynamic>))
            .toList();
      }

      // If response is a single object
      return [ProductModel.fromJson(response.data as Map<String, dynamic>)];
    } on DioException catch (e) {
      throw Exception('Failed to fetch products: ${e.message}');
    }
  }
}
