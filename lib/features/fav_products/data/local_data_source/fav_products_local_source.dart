import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:test_project/features/home/data/models/product_model.dart';

class FavProductsLocalDataSource {
  final Box _box;
  FavProductsLocalDataSource(this._box);

  Future<void> addFavourite(int key, ProductModel product) =>
      _box.put(key, jsonEncode(product.toJson()));

  Future<void> removeFavourite(int key) => _box.delete(key);

  List<int> getAllKeys() => _box.keys.cast<int>().toList();

  List<ProductModel> getAllProducts() => _box.values
      .map((e) => ProductModel.fromJson(jsonDecode(e as String)))
      .toList();

  bool isFavourite(int key) => _box.containsKey(key);
}
