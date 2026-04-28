part of 'search_cubit.dart';

sealed class SearchState {
  const SearchState();
}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchSuccess extends SearchState {
  final List<ProductModel> results;
  const SearchSuccess(this.results);
}

class SearchEmpty extends SearchState {}

class SearchFailed extends SearchState {
  final String error;
  const SearchFailed(this.error);
}
