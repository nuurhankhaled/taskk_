import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:test_project/core/network/dio_factory.dart';
import 'package:test_project/features/home/data/remote/products_api_services.dart';
import 'package:test_project/features/home/data/repo/products_repo.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  // Dio & Api services
  Dio dio = DioFactory.getDio();

  getIt.registerLazySingleton<ProductsApiService>(
    () => ProductsApiService(dio),
  );
  getIt.registerLazySingleton<ProductsRepo>(() => ProductsRepo(getIt()));
}
