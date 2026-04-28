import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_project/features/home/presentation/pages/widgets/product_widget.dart';
import 'package:test_project/features/search/presentation/cubit/search_cubit/search_cubit.dart';

class SearchResultsWidget extends StatelessWidget {
  const SearchResultsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        final cubit = context.read<SearchCubit>();

        if (state is SearchLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is SearchInitial) {
          return Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.search, size: 80, color: Colors.grey),
                  SizedBox(height: 16),
                  Text('Search for products'.tr(), style: TextStyle(color: Colors.grey, fontSize: 16)),
                ],
              ),
            ),
          );
        }

        if (state is SearchEmpty) {
          return Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.search_off, size: 80, color: Colors.grey),
                  SizedBox(height: 16),
                  Text('No products found'.tr(), style: TextStyle(color: Colors.grey, fontSize: 16)),
                ],
              ),
            ),
          );
        }

        if (state is SearchFailed) {
          return Center(child: Text(state.error));
        }

        if (state is SearchSuccess) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: GridView.builder(
              controller: cubit.scrollController,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
                childAspectRatio: MediaQuery.of(context).size.width / (MediaQuery.of(context).size.height * 0.65),
              ),
              itemCount: state.results.length + (cubit.hasMore ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == state.results.length) {
                  return const Center(child: CircularProgressIndicator());
                }
                return ProductWidget(product: state.results[index]);
              },
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
