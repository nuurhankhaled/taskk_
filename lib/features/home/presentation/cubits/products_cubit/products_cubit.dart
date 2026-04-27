import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_project/core/cubit/connectivity_cubit/internet_connection_cubit.dart';
import 'package:test_project/core/cubit/connectivity_cubit/internet_connection_state.dart';
import 'package:test_project/features/home/data/models/product_model.dart';
import 'package:test_project/features/home/data/repo/products_repo.dart';
part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  final ProductsRepo _productsRepo;
  final InternetConnectionCubit _internetCubit;

  ProductsCubit(this._productsRepo, this._internetCubit)
    : super(ProductsInitial());

  static ProductsCubit get(BuildContext context) =>
      BlocProvider.of<ProductsCubit>(context);

  List<ProductModel> _allProducts = [];
  List<ProductModel> products = [];
  final int _pageSize = 10;
  int _currentPage = 0;
  bool hasMore = true;
  bool _isSyncing = false;

  final ScrollController scrollController = ScrollController();
  StreamSubscription? _connectivitySubscription;

  void init() {
    _listenToConnectivity(); // ✅ listen for connection changes
    loadProducts();
    scrollController.addListener(_onScroll);
  }

  void _listenToConnectivity() {
    _connectivitySubscription = _internetCubit.stream.listen((state) {
      if (state is InternetConnectedState && !_isSyncing) {
        _syncFromApi(); // ✅ sync when connection restored
      }
    });
  }

  Future<void> loadProducts() async {
    emit(ProductsLoading());
    if (_internetCubit.state is InternetConnectedState) {
      await _loadFromApi(); // ✅ online → fetch from API
    } else {
      await _loadFromCache(); // ✅ offline → load from Hive
    }
  }

  Future<void> _loadFromApi() async {
    final response = await _productsRepo.getHomeData();
    response.when(
      success: (data) {
        _allProducts = data;
        _currentPage = 0;
        products = [];
        hasMore = true;
        _loadNextPage();
        emit(ProductsSuccess());
      },
      failure: (_) async {
        await _loadFromCache(); // ✅ API fails → fallback to cache
      },
    );
  }

  Future<void> _loadFromCache() async {
    final response = await _productsRepo.getCachedProducts();
    response.when(
      success: (data) {
        _allProducts = data;
        _currentPage = 0;
        products = [];
        hasMore = true;
        _loadNextPage();
        emit(ProductsSuccess());
      },
      failure: (_) => emit(ProductsFailed()),
    );
  }

  Future<void> _syncFromApi() async {
    _isSyncing = true;
    final response = await _productsRepo.getHomeData();
    response.when(
      success: (data) {
        _allProducts = data;
        _currentPage = 0;
        products = [];
        hasMore = true;
        _loadNextPage();
        emit(ProductsSuccess(isSynced: true)); // ✅ notify UI sync happened
      },
      failure: (_) {},
    );
    _isSyncing = false;
  }

  void loadMore() {
    if (!hasMore) return;
    emit(PaginationLoading());
    Future.delayed(const Duration(milliseconds: 500), () {
      _loadNextPage();
      emit(ProductsSuccess());
    });
  }

  void _loadNextPage() {
    final start = _currentPage * _pageSize;
    final end = start + _pageSize;
    if (start >= _allProducts.length) {
      hasMore = false;
      return;
    }
    final nextItems = _allProducts.sublist(
      start,
      end > _allProducts.length ? _allProducts.length : end,
    );
    products.addAll(nextItems);
    _currentPage++;
    hasMore = end < _allProducts.length;
  }

  void _onScroll() {
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent - 200) {
      loadMore();
    }
  }

  @override
  Future<void> close() {
    _connectivitySubscription?.cancel();
    scrollController.dispose();
    return super.close();
  }
}
