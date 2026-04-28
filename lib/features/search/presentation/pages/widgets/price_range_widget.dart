import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_project/features/search/presentation/cubit/search_cubit/search_cubit.dart';

class PriceRangeWidget extends StatelessWidget {
  const PriceRangeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        final cubit = context.read<SearchCubit>();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Price Range:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  '${cubit.priceRange.start.toInt()} - ${cubit.priceRange.end.toInt()} EGP',
                  style: const TextStyle(color: Colors.deepPurple),
                ),
              ],
            ),
            RangeSlider(
              values: cubit.priceRange,
              min: 0,
              max: 1000,
              divisions: 20,
              activeColor: Colors.deepPurple,
              onChanged: cubit.onPriceRangeChanged,
            ),
          ],
        );
      },
    );
  }
}
