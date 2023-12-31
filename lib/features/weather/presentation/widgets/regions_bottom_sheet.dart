import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kt_dart/collection.dart';
import 'package:weather_app/core/styles/typography/text_style.dart';
import 'package:weather_app/features/weather/presentation/bloc/current_location/current_location_cubit.dart';
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
                padding: EdgeInsets.all(12.w),
                child: Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Search...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50.r),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 10.w,
                          vertical: 10.w,
                        ),
                      ),
                      onChanged: (value) => query.value = value,
                    ),
                    SizedBox(
                      height: 16.w,
                    ),
                    Expanded(
                      child: ListView.separated(
                        itemCount: regions.size,
                        separatorBuilder: (BuildContext context, int index) {
                          return Divider(
                            height: 16.w,
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
                    ),
                    SizedBox(
                      height: 8.w,
                    ),
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        context.read<CurrentLocationCubit>().initialized();
                        context.router.pop();
                      },
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                          vertical: 16.w,
                          horizontal: 8.w,
                        ),
                        decoration: ShapeDecoration(
                          shape: const StadiumBorder(),
                          color: Theme.of(context).primaryColor,
                        ),
                        child: Center(
                          child: Text(
                            'Use My Location.',
                            style: AppTextStyle.bodyText1.bold
                                .copyWith(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).padding.bottom),
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
