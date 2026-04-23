import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:test_project/core/network/dio_factory.dart';
import 'package:test_project/core/services/remote_config_service.dart';
import 'package:test_project/features/fav_products/data/local_data_source/fav_products_local_source.dart';
import 'package:test_project/features/fav_products/data/repo/fav_products_repo.dart';
import 'package:test_project/features/fav_products/presentation/cubit/fav_products_cubit/fav_products_cubit.dart';
import 'package:test_project/features/home/data/remote/products_api_services.dart';
import 'package:test_project/features/home/data/repo/products_repo.dart';
import 'package:test_project/core/cubit/connectivity_cubit/internet_connection_cubit.dart';
import 'package:test_project/features/home/presentation/cubits/products_cubit/products_cubit.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  // Remote Config
  final remoteConfigService = RemoteConfigService();
  await remoteConfigService.init();
  getIt.registerLazySingleton<RemoteConfigService>(() => remoteConfigService);

  // Hive setup
  await Hive.initFlutter();
  await Hive.openBox("favBox");

  // Dio & Api services
  Dio dio = DioFactory.getDio(remoteConfigService.baseUrl);

  getIt.registerLazySingleton<ProductsApiService>(
    () => ProductsApiService(dio),
  );

  getIt.registerLazySingleton<ProductsRepo>(() => ProductsRepo(getIt()));

  getIt.registerFactory<ProductsCubit>(() => ProductsCubit(getIt()));
  getIt.registerLazySingleton<FavProductsRepo>(() => FavProductsRepo(getIt()));
  getIt.registerLazySingleton<FavProductsLocalDataSource>(
    () => FavProductsLocalDataSource(Hive.box("favBox")),
  );
  getIt.registerLazySingleton<FavProductsCubit>(
    () => FavProductsCubit(getIt(), getIt()),
  );

  getIt.registerLazySingleton<InternetConnectionCubit>(
    () => InternetConnectionCubit(),
  );
}
