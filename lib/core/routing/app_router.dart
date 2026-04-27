import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_project/core/di/dependency_injection.dart';
import 'package:test_project/core/routing/routes.dart';
import 'package:test_project/features/auth/presentation/cubit/auth_cubit/auth_cubit.dart';
import 'package:test_project/features/auth/presentation/pages/login_page.dart';
import 'package:test_project/features/auth/presentation/pages/signup_page.dart';
import 'package:test_project/features/cart/presentation/cubits/cart_cubit/cart_cubit.dart';
import 'package:test_project/features/cart/presentation/pages/cart_page.dart';
import 'package:test_project/features/checkout/presentation/pages/checkout_page.dart';
import 'package:test_project/features/fav_products/presentation/cubit/fav_products_cubit/fav_products_cubit.dart';
import 'package:test_project/features/fav_products/presentation/pages/fav_prodcucts_page.dart';
import 'package:test_project/features/home/data/models/product_model.dart';
import 'package:test_project/features/home/presentation/cubits/products_cubit/products_cubit.dart';
import 'package:test_project/features/home/presentation/pages/home_page.dart';
import 'package:test_project/features/main_layout/presentation/cubit/main_layout_cubit/main_layout_cubit.dart';
import 'package:test_project/features/main_layout/presentation/pages/main_layout_page.dart';
import 'package:test_project/features/product/presentation/pages/product_page.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.loginPage:
        return CupertinoPageRoute(
          builder: (_) => BlocProvider(create: (context) => getIt<AuthCubit>(), child: LoginPage()),
        );
      case Routes.signupPage:
        return CupertinoPageRoute(
          builder: (_) => BlocProvider(create: (context) => getIt<AuthCubit>(), child: SignupPage()),
        );
      case Routes.mainlayoutPage:
        return CupertinoPageRoute(
          builder: (_) => BlocProvider(create: (context) => getIt<MainLayoutCubit>(), child: MainLayoutPage()),
        );
      case Routes.cartPage:
        return CupertinoPageRoute(
          builder: (_) => BlocProvider.value(value: getIt<CartCubit>()..loadCart(), child: CartPage()),
        );
      case Routes.productPage:
        var args = settings.arguments as ProductModel;
        return CupertinoPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => getIt<ProductsCubit>()..init()),
              BlocProvider.value(value: getIt<FavProductsCubit>()),
            ],
            child: ProductPage(product: args),
          ),
        );
      case Routes.checkoutPage:
        return CupertinoPageRoute(builder: (_) => CheckoutPage());

      default:
        return null;
    }
  }

  List screens = [
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<ProductsCubit>()..init()),
        BlocProvider.value(value: getIt<FavProductsCubit>()),
      ],
      child: HomePage(),
    ),
    BlocProvider.value(value: getIt<FavProductsCubit>()..getAllFavourites(), child: FavProdcuctsPage()),
  ];
}
