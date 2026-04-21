import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_project/core/constant.dart';
import 'package:test_project/features/fav_products/presentation/pages/fav_prodcucts_page.dart';
import 'package:test_project/features/home/presentation/cubits/connectivity_cubit/internet_connection_cubit.dart';
import 'package:test_project/features/home/presentation/cubits/connectivity_cubit/internet_connection_state.dart';
import 'package:test_project/features/home/presentation/pages/home_page.dart';
import 'package:test_project/features/main_layout/presentation/cubit/main_layout_cubit/main_layout_cubit.dart';

class MainLayoutPage extends StatelessWidget {
  const MainLayoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MainLayoutCubit(),
      child: BlocBuilder<MainLayoutCubit, MainLayoutState>(
        builder: (context, state) {
          return Scaffold(
            body: BlocBuilder<InternetConnectionCubit, InternetConnectionState>(
              builder: (context, state) {
                return state is InternetNotConnectedState
                    ? Text("No internet")
                    : (mainLayoutIntitalScreenIndex == 0)
                    ? HomePage()
                    : FavProdcuctsPage();
              },
            ),
            bottomNavigationBar: BottomNavigationBar(
              onTap: (value) => {
                context.read<MainLayoutCubit>().changeBottomNavBarIndex(value),
              },
              items: [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                    color: mainLayoutIntitalScreenIndex == 0
                        ? Colors.purple
                        : Colors.grey,
                  ),
                  label: "",
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.favorite,
                    color: mainLayoutIntitalScreenIndex == 1
                        ? Colors.purple
                        : Colors.grey,
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
