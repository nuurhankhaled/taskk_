import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:equatable/equatable.dart';
import 'package:test_project/features/home/data/models/product_model.dart';
import 'package:test_project/features/home/data/repo/products_repo.dart';

part 'fav_products_state.dart';

class FavProductsCubit extends Cubit<FavProductsState> {
  final ProductsRepo _productReop;
  FavProductsCubit(this._productReop) : super(FavProductsInitial());

  final favBox = Hive.box("favBox");

  List<ProductModel> favProducts = [];

  static FavProductsCubit get(BuildContext context) =>
      BlocProvider.of<FavProductsCubit>(context);

  bool isFavorite(int id) {
    return favBox.containsKey(id);
  }

  Future<void> writeData(int key, dynamic value) async {
    await favBox.put(key, value);
    // Sync favProducts with Hive
    // await getAllFavourites();
    emit(ProductAddedToFav(favBox.keys.cast<int>().toList()));
  }

  Future<void> getAllFavourites() async {
    List<int> allKeys = favBox.keys.cast<int>().toList();

    if (allKeys.isEmpty) {
      favProducts = [];
      emit(GetAllFav());
      return;
    }

    emit(FavProductsLoading());

    final response = await _productReop.getHomeData();
    response.when(
      success: (data) {
        favProducts = data
            .where((product) => allKeys.contains(product.id))
            .toList();
        emit(GetAllFav());
      },
      failure: (error) {
        emit(FavProductsFailed());
      },
    );
  }

  Future<void> deleteData(int key) async {
    await favBox.delete(key);
    favProducts.removeWhere((product) => product.id == key);
    emit(ProductRemovedToFav(favBox.keys.cast<int>().toList()));
  }
}
