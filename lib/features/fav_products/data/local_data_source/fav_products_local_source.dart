import 'package:hive/hive.dart';

class FavProductsLocalDataSource {
  final Box _box;

  FavProductsLocalDataSource(this._box);

  Future<void> addFavourite(int key, dynamic value) => _box.put(key, value);

  Future<void> removeFavourite(int key) => _box.delete(key);

  List<int> getAllKeys() => _box.keys.cast<int>().toList();

  bool isFavourite(int key) => _box.containsKey(key);
}
