// import 'package:flutter/widgets.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:dio/dio.dart';
// import 'package:test_project/features/home/data/models/product_model.dart';
// import 'package:test_project/features/home/data/repo/products_repo.dart';

// part 'products_state.dart';

// class ProductsCubit extends Cubit<ProductsState> {
//   final ProductsRepo _productsRepo;
//   ProductsCubit(this._productsRepo) : super(ProductsInitial());
//   final dio = Dio();

//   static ProductsCubit get(BuildContext context) =>
//       BlocProvider.of<ProductsCubit>(context);
//   List<ProductModel> products = [];
//   getProducts() async {
//     emit(ProductsLoading());
//     try {
//       final response = await dio.get(
//         'https://api.escuelajs.co/api/v1/products',
//       );
//       products = List<ProductModel>.from(
//         response.data.map((item) => ProductModel.fromJson(item)),
//       );
//       emit(ProductsSuccess());
//     } catch (e) {
//       emit(ProductsFailed());
//     }
//   }
// }

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:test_project/features/home/data/models/product_model.dart';
import 'package:test_project/features/home/data/repo/products_repo.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  final ProductsRepo _productsRepo;
  ProductsCubit(this._productsRepo) : super(ProductsInitial());

  static ProductsCubit get(BuildContext context) =>
      BlocProvider.of<ProductsCubit>(context);
  List<ProductModel> products = [];
  getProducts() async {
    emit(ProductsLoading());
    final response = await _productsRepo.getHomeData();
    response.when(
      success: (data) {
        products = data;
        emit(ProductsSuccess());
      },
      failure: (error) {
        emit(ProductsFailed());
      },
    );
  }
}
