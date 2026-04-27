import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:test_project/features/home/data/models/product_model.dart';

class ProductsLocalDataSource {
  final Box _box;
  ProductsLocalDataSource(this._box);

  Future<void> cacheProducts(List<ProductModel> products) async {
    final encoded = products.map((e) => jsonEncode(e.toJson())).toList();
    await _box.put('products', encoded);
  }

  List<ProductModel> getCachedProducts() {
    final data = _box.get('products');
    if (data == null) return [];
    return (data as List)
        .map((e) => ProductModel.fromJson(jsonDecode(e as String)))
        .toList();
  }

  bool get hasCachedProducts => _box.containsKey('products');
}
