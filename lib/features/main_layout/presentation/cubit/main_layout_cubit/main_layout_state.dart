part of 'main_layout_cubit.dart';

sealed class MainLayoutState {}

class MainLayoutInitial extends MainLayoutState {}

class AppBottomNavState extends MainLayoutState {
  final int currentIndex;
  AppBottomNavState({this.currentIndex = 0});
}
