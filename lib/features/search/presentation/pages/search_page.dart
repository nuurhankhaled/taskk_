import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_project/core/helpers/extensions.dart';
import 'package:test_project/features/search/presentation/cubit/search_cubit/search_cubit.dart';
import 'package:test_project/features/search/presentation/pages/widgets/price_range_widget.dart';
import 'package:test_project/features/search/presentation/pages/widgets/search_result_widget.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'.tr()),
        centerTitle: true,
        leading: IconButton(icon: const Icon(Icons.arrow_back_ios), onPressed: () => context.pop()),
      ),
      body: BlocBuilder<SearchCubit, SearchState>(
        builder: (context, state) {
          final cubit = context.read<SearchCubit>();
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    TextField(
                      controller: cubit.searchController,
                      onChanged: cubit.onSearchChanged,
                      decoration: InputDecoration(
                        hintText: 'Search products...'.tr(),
                        prefixIcon: const Icon(Icons.search),
                        suffixIcon: cubit.searchController.text.isNotEmpty ? IconButton(icon: const Icon(Icons.clear), onPressed: cubit.clearSearch) : null,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Colors.deepPurple),
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),

                    if (cubit.categories.isNotEmpty)
                      SizedBox(
                        height: 40,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: cubit.categories.length + 1,
                          separatorBuilder: (_, __) => const SizedBox(width: 8),
                          itemBuilder: (context, index) {
                            if (index == 0) {
                              return ChoiceChip(
                                label: Text('All'.tr()),
                                selected: cubit.selectedCategory == null,
                                selectedColor: Colors.deepPurple,
                                labelStyle: TextStyle(color: cubit.selectedCategory == null ? Colors.white : Colors.grey),
                                onSelected: (_) => cubit.onCategorySelected(null),
                              );
                            }
                            final category = cubit.categories[index - 1];
                            return ChoiceChip(
                              label: Text(category),
                              selected: cubit.selectedCategory == category,
                              selectedColor: Colors.deepPurple,
                              labelStyle: TextStyle(color: cubit.selectedCategory == category ? Colors.white : Colors.grey),
                              onSelected: (_) => cubit.onCategorySelected(category),
                            );
                          },
                        ),
                      ),

                    const SizedBox(height: 12),
                    const PriceRangeWidget(),
                  ],
                ),
              ),

              const Expanded(child: SearchResultsWidget()),
            ],
          );
        },
      ),
    );
  }
}
