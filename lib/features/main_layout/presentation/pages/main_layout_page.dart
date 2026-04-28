import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_project/core/helpers/extensions.dart';
import 'package:test_project/core/routing/app_router.dart';
import 'package:test_project/core/cubit/connectivity_cubit/internet_connection_cubit.dart';
import 'package:test_project/core/cubit/connectivity_cubit/internet_connection_state.dart';
import 'package:test_project/core/routing/routes.dart';
import 'package:test_project/features/main_layout/presentation/cubit/main_layout_cubit/main_layout_cubit.dart';

class MainLayoutPage extends StatelessWidget {
  const MainLayoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainLayoutCubit, MainLayoutState>(
      builder: (context, mainLayoutState) {
        final currentIndex = mainLayoutState is AppBottomNavState ? mainLayoutState.currentIndex : 0;

        return Scaffold(
          appBar: AppBar(
            title: Text(
              currentIndex == 0
                  ? "Products".tr()
                  : currentIndex == 1
                  ? "Favourites".tr()
                  : "settings".tr(),
            ),
            actions: [
              if (currentIndex == 0) IconButton(onPressed: () => context.pushNamed(Routes.searchPage), icon: const Icon(Icons.search)),
              IconButton(
                onPressed: () {
                  context.pushNamed(Routes.cartPage);
                },
                icon: const Icon(Icons.shopping_cart_outlined),
              ),
              IconButton(onPressed: () => context.pushNamed(Routes.profilePage), icon: const Icon(Icons.person_outline)),
            ],
          ),
          body: BlocBuilder<InternetConnectionCubit, InternetConnectionState>(
            builder: (context, internetState) {
              return AppRouter().screens[currentIndex];
            },
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: currentIndex,
            onTap: (value) {
              context.read<MainLayoutCubit>().changeBottomNavBarIndex(value);
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home, color: currentIndex == 0 ? Colors.purple : Colors.grey),
                label: "",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite, color: currentIndex == 1 ? Colors.purple : Colors.grey),
                label: "",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings, color: currentIndex == 2 ? Colors.purple : Colors.grey),
                label: "",
              ),
            ],
          ),
        );
      },
    );
  }
}
