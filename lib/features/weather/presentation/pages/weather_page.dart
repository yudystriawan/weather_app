import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/features/weather/domain/entities/entity.dart';
import 'package:weather_app/features/weather/presentation/bloc/weather_loader/weather_loader_cubit.dart';
import 'package:weather_app/features/weather/presentation/widgets/region_info_widget.dart';
import 'package:weather_app/features/weather/presentation/widgets/weather_predictions_widget.dart';

import '../bloc/current_location/current_location_cubit.dart';
import '../widgets/weather_info_widget.dart';

@RoutePage()
class WeatherPage extends StatelessWidget {
  const WeatherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<CurrentLocationCubit, CurrentLocationState>(
        listener: (context, state) {
          final region = state.currentRegion;
          if (region != Region.empty()) {
            context.read<WeatherLoaderCubit>().fetched(region.id);
          }

          if (state.failure != null) {
            debugPrint('an error occured:  ${state.failure}');
          }
        },
        child: BlocBuilder<CurrentLocationCubit, CurrentLocationState>(
          buildWhen: (p, c) => p.isLoading != c.isLoading,
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: NestedScrollView(
                  headerSliverBuilder: (context, innerBoxIsScrolled) => [
                    const SliverToBoxAdapter(
                      child: Column(
                        children: [
                          RegionInfoWidget(),
                          SizedBox(
                            height: 16,
                          ),
                          WeatherInfoWidget(),
                        ],
                      ),
                    )
                  ],
                  body: const WeatherPredictionsWidget(),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
