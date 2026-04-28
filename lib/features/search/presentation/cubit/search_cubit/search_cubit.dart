import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_project/features/home/data/models/product_model.dart';
import 'package:test_project/features/home/data/repo/products_repo.dart';
part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final ProductsRepo _productsRepo;

  SearchCubit(this._productsRepo) : super(SearchInitial());

  List<ProductModel> _allProducts = [];
  List<ProductModel> _filteredProducts = [];
  List<ProductModel> displayedProducts = [];

  final int _pageSize = 10;
  int _currentPage = 0;
  bool hasMore = true;

  Timer? _debounceTimer;

  final ScrollController scrollController = ScrollController();
  final TextEditingController searchController = TextEditingController();
  String? selectedCategory;
  RangeValues priceRange = const RangeValues(0, 1000);

  Future<void> init() async {
    scrollController.addListener(_onScroll);
    final result = await _productsRepo.getCachedProducts();
    result.when(
      success: (data) => _allProducts = data,
      failure: (_) => emit(SearchFailed('Failed to load products')),
    );
  }

  void _onScroll() {
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent - 200) {
      _loadNextPage();
    }
  }

  void onSearchChanged(String value) {
    search(
      value,
      category: selectedCategory,
      minPrice: priceRange.start.toInt(),
      maxPrice: priceRange.end.toInt(),
    );
  }

  void onCategorySelected(String? category) {
    selectedCategory = category;
    emit(SearchInitial());
    search(
      searchController.text,
      category: selectedCategory,
      minPrice: priceRange.start.toInt(),
      maxPrice: priceRange.end.toInt(),
    );
  }

  void onPriceRangeChanged(RangeValues values) {
    priceRange = values;
    emit(SearchInitial());
    search(
      searchController.text,
      category: selectedCategory,
      minPrice: values.start.toInt(),
      maxPrice: values.end.toInt(),
    );
  }

  void clearSearch() {
    searchController.clear();
    search('');
  }

  void search(String query, {String? category, int? minPrice, int? maxPrice}) {
    _debounceTimer?.cancel();

    if (query.isEmpty &&
        category == null &&
        minPrice == null &&
        maxPrice == null) {
      emit(SearchInitial());
      return;
    }

    emit(SearchLoading());

    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      _performSearch(
        query,
        category: category,
        minPrice: minPrice,
        maxPrice: maxPrice,
      );
    });
  }

  void _performSearch(
    String query, {
    String? category,
    int? minPrice,
    int? maxPrice,
  }) {
    List<ProductModel> results = _allProducts;

    if (query.isNotEmpty) {
      results = results
          .where((p) => p.title!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }

    if (category != null && category.isNotEmpty) {
      results = results
          .where(
            (p) => p.category?.name?.toLowerCase() == category.toLowerCase(),
          )
          .toList();
    }

    if (minPrice != null) {
      results = results.where((p) => p.price! >= minPrice).toList();
    }

    if (maxPrice != null) {
      results = results.where((p) => p.price! <= maxPrice).toList();
    }

    if (results.isEmpty) {
      emit(SearchEmpty());
      return;
    }

    _filteredProducts = results;
    _currentPage = 0;
    displayedProducts = [];
    hasMore = true;
    _loadNextPage();
  }

  void _loadNextPage() {
    if (!hasMore) return;

    final start = _currentPage * _pageSize;
    final end = start + _pageSize;

    if (start >= _filteredProducts.length) {
      hasMore = false;
      return;
    }

    final nextItems = _filteredProducts.sublist(
      start,
      end > _filteredProducts.length ? _filteredProducts.length : end,
    );

    displayedProducts.addAll(nextItems);
    _currentPage++;
    hasMore = end < _filteredProducts.length;
    emit(SearchSuccess(displayedProducts));
  }

  List<String> get categories => _allProducts
      .map((p) => p.category?.name ?? '')
      .where((name) => name.isNotEmpty)
      .toSet()
      .toList();

  @override
  Future<void> close() {
    _debounceTimer?.cancel();
    scrollController.dispose();
    searchController.dispose();
    return super.close();
  }
}
