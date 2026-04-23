import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_project/core/di/dependency_injection.dart';
import 'package:test_project/core/routing/routes.dart';
import 'package:test_project/features/auth/presentation/cubit/auth_cubit/auth_cubit.dart';
import 'package:test_project/features/auth/presentation/pages/login_screen.dart';
import 'package:test_project/features/fav_products/presentation/cubit/fav_products_cubit/fav_products_cubit.dart';
import 'package:test_project/features/fav_products/presentation/pages/fav_prodcucts_page.dart';
import 'package:test_project/features/home/presentation/cubits/products_cubit/products_cubit.dart';
import 'package:test_project/features/home/presentation/pages/home_page.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.loginScreen:
        return CupertinoPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<AuthCubit>(),
            child: LoginPage(),
          ),
        );

      //     case Routes.signupScreen:
      //       return CupertinoPageRoute(
      //         builder: (_) => BlocProvider(
      //           create: (context) => SignupCubit(getIt()),
      //           child: SignUpScreen(),
      //         ),
      //       );

      default:
        return null;
    }
  }

  List screens = [
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<ProductsCubit>()..getProducts(),
        ),
        BlocProvider.value(value: getIt<FavProductsCubit>()),
      ],
      child: HomePage(),
    ),
    BlocProvider.value(
      value: getIt<FavProductsCubit>()..getAllFavourites(),
      child: FavProdcuctsPage(),
    ),
  ];
}
