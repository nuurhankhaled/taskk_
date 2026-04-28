import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:test_project/core/fcm.dart';
import 'package:test_project/core/network/dio_factory.dart';
import 'package:test_project/core/services/remote_config_service.dart';
import 'package:test_project/core/services/shared_pref_services.dart';
import 'package:test_project/features/auth/data/local/user_local_data_source.dart';
import 'package:test_project/features/auth/data/remote/auth_data_source.dart';
import 'package:test_project/features/cart/data/local/cart_local_data_source.dart';
import 'package:test_project/features/cart/data/repo/cart_repo.dart';
import 'package:test_project/features/cart/presentation/cubits/cart_cubit/cart_cubit.dart';
import 'package:test_project/features/fav_products/data/local_data_source/fav_products_local_source.dart';
import 'package:test_project/features/fav_products/data/repo/fav_products_repo.dart';
import 'package:test_project/features/fav_products/presentation/cubit/fav_products_cubit/fav_products_cubit.dart';
import 'package:test_project/features/home/data/local/products_local_data_source.dart';
import 'package:test_project/features/home/data/remote/products_api_services.dart';
import 'package:test_project/features/home/data/repo/products_repo.dart';
import 'package:test_project/core/cubit/connectivity_cubit/internet_connection_cubit.dart';
import 'package:test_project/features/home/presentation/cubits/products_cubit/products_cubit.dart';
import 'package:test_project/features/auth/data/repo/auth_repo.dart';
import 'package:test_project/features/auth/presentation/cubit/auth_cubit/auth_cubit.dart';
import 'package:test_project/features/main_layout/presentation/cubit/main_layout_cubit/main_layout_cubit.dart';
import 'package:test_project/features/profile/presentation/cubits/profile_cubit/profile_cubit.dart';
import 'package:test_project/features/search/presentation/cubit/search_cubit/search_cubit.dart';
import 'package:test_project/features/settings/presentation/cubit/settings_cubit/settings_cubit.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  // Shared Preferences
  await SharedPrefService.init();

  // Remote Config
  final remoteConfigService = RemoteConfigService();
  await remoteConfigService.init();
  getIt.registerLazySingleton<RemoteConfigService>(() => remoteConfigService);

  // Hive
  await Hive.initFlutter();
  await Hive.openBox("favBox");
  await Hive.openBox("productsBox");
  await Hive.openBox("cartBox");
  await Hive.openBox("userBox");

  // Dio
  Dio dio = DioFactory.getDio(remoteConfigService.baseUrl);

  // Settings
  getIt.registerLazySingleton<SettingsCubit>(() => SettingsCubit());

  // Main Layout
  getIt.registerLazySingleton<MainLayoutCubit>(() => MainLayoutCubit());

  // Internet
  getIt.registerLazySingleton<InternetConnectionCubit>(() => InternetConnectionCubit());

  // Products
  getIt.registerLazySingleton<ProductsApiService>(() => ProductsApiService(dio));
  getIt.registerLazySingleton<ProductsLocalDataSource>(() => ProductsLocalDataSource(Hive.box("productsBox")));
  getIt.registerLazySingleton<ProductsRepo>(() => ProductsRepo(getIt(), getIt()));
  getIt.registerFactory<ProductsCubit>(() => ProductsCubit(getIt(), getIt()));

  // Fav
  getIt.registerLazySingleton<FavProductsLocalDataSource>(() => FavProductsLocalDataSource(Hive.box("favBox")));
  getIt.registerLazySingleton<FavProductsRepo>(() => FavProductsRepo(getIt()));
  getIt.registerLazySingleton<FavProductsCubit>(() => FavProductsCubit(getIt()));

  // Firebase Auth
  getIt.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  getIt.registerLazySingleton<AuthRemoteDataSource>(() => AuthRemoteDataSource(getIt()));
  getIt.registerLazySingleton<UserLocalDataSource>(() => UserLocalDataSource(Hive.box("userBox")));
  getIt.registerLazySingleton<AuthRepo>(() => AuthRepo(getIt(), getIt()));
  getIt.registerFactory<AuthCubit>(() => AuthCubit(getIt()));

  // Cart
  getIt.registerLazySingleton<CartLocalDataSource>(() => CartLocalDataSource(Hive.box("cartBox")));
  getIt.registerLazySingleton<CartRepo>(() => CartRepo(getIt()));
  getIt.registerLazySingleton<CartCubit>(() => CartCubit(getIt()));

  // Search
  getIt.registerFactory<SearchCubit>(() => SearchCubit(getIt()));

  // Profile
  getIt.registerFactory<ProfileCubit>(() => ProfileCubit(getIt()));

  // Push Notifications
  getIt.registerSingleton<PushNotificationService>(PushNotificationService());
  await getIt<PushNotificationService>().initialize();
}
