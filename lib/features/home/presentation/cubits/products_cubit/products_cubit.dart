import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_project/features/home/data/models/product_model.dart';
import 'package:test_project/features/home/data/repo/products_repo.dart';
part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  final ProductsRepo _productsRepo;
  ProductsCubit(this._productsRepo) : super(ProductsInitial());

  static ProductsCubit get(BuildContext context) =>
      BlocProvider.of<ProductsCubit>(context);

  List<ProductModel> _allProducts = [];
  List<ProductModel> products = [];

  final int _pageSize = 10;
  int _currentPage = 0;
  bool hasMore = true;

  final ScrollController scrollController = ScrollController();

  void init() {
    getProducts();
    scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent - 200) {
      loadMore();
    }
  }

  Future<void> getProducts() async {
    emit(ProductsLoading());
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
      failure: (_) => emit(ProductsFailed()),
    );
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

  @override
  Future<void> close() {
    scrollController.dispose();
    return super.close();
  }
}
