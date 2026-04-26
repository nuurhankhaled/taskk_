import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_project/core/di/dependency_injection.dart';
import 'package:test_project/core/routing/app_router.dart';
import 'package:test_project/core/cubit/connectivity_cubit/internet_connection_cubit.dart';
import 'package:test_project/core/cubit/connectivity_cubit/internet_connection_state.dart';
import 'package:test_project/features/main_layout/presentation/cubit/main_layout_cubit/main_layout_cubit.dart';

class MainLayoutPage extends StatelessWidget {
  const MainLayoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<MainLayoutCubit>(),
      child: BlocBuilder<MainLayoutCubit, MainLayoutState>(
        builder: (context, mainLayoutState) {
          final currentIndex = mainLayoutState is AppBottomNavState
              ? mainLayoutState.currentIndex
              : 0;

          return Scaffold(
            appBar: AppBar(
              title: Text(currentIndex == 0 ? "Products" : "Favourites"),
            ),
            body: BlocBuilder<InternetConnectionCubit, InternetConnectionState>(
              builder: (context, internetState) {
                if (internetState is InternetNotConnectedState) {
                  return const Center(child: Text("No internet"));
                }
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
                  icon: Icon(
                    Icons.home,
                    color: currentIndex == 0 ? Colors.purple : Colors.grey,
                  ),
                  label: "",
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.favorite,
                    color: currentIndex == 1 ? Colors.purple : Colors.grey,
                  ),
                  label: "",
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
