import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:kt_dart/collection.dart';
import 'package:weather_app/core/styles/typography/text_style.dart';
import 'package:weather_app/features/weather/presentation/bloc/region_loader/region_loader_cubit.dart';
import 'package:weather_app/injection.dart';

import '../../domain/entities/entity.dart';

Future<Region?> showRegionBottomSheet(BuildContext context) {
  return showModalBottomSheet<Region?>(
    context: context,
    isScrollControlled: true,
    constraints: BoxConstraints(
      maxHeight: MediaQuery.of(context).size.height -
          MediaQueryData.fromView(View.of(context)).padding.top -
          kToolbarHeight,
    ),
    builder: (context) => const _RegionsBottomSheet(),
  );
}

class _RegionsBottomSheet extends HookWidget {
  const _RegionsBottomSheet();

  @override
  Widget build(BuildContext context) {
    final query = useState('');

    return BlocProvider(
      create: (context) => getIt<RegionLoaderCubit>()..fetched(),
      child: BlocBuilder<RegionLoaderCubit, RegionLoaderState>(
        builder: (context, state) {
          return state.map(
            initial: (_) => const SizedBox(),
            loadInProgress: (_) => const Center(
              child: CircularProgressIndicator(),
            ),
            loadFailure: (_) => const SizedBox(),
            loadSuccess: (value) {
              final regions = value.regions.toMutableList();
              if (query.value.isNotEmpty) {
                final filteredRegions = regions.filter(
                  (region) =>
                      region.subDistrict.toLowerCase().contains(query.value) ||
                      region.city.toLowerCase().contains(query.value) ||
                      region.province.toLowerCase().contains(query.value),
                );
                regions.clear();
                regions.addAll(filteredRegions);
              }

              return Container(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    TextField(
                      decoration: const InputDecoration(
                        hintText: 'Search...',
                      ),
                      onChanged: (value) => query.value = value,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Expanded(
                      child: ListView.separated(
                        itemCount: regions.size,
                        separatorBuilder: (BuildContext context, int index) {
                          return const SizedBox(
                            height: 16,
                          );
                        },
                        itemBuilder: (BuildContext context, int index) {
                          final region = regions[index];
                          return GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () => context.router.pop(region),
                            child: Text(
                              region.formattedAddress,
                              style: AppTextStyle.bodyText1,
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
