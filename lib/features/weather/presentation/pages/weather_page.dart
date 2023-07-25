import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/features/weather/domain/entities/entity.dart';
import 'package:weather_app/features/weather/presentation/bloc/region_form/region_form_cubit.dart';
import 'package:weather_app/features/weather/presentation/bloc/weather_loader/weather_loader_cubit.dart';
import 'package:weather_app/features/weather/presentation/widgets/region_form_widget.dart';
import 'package:weather_app/features/weather/presentation/widgets/weather_predictions_widget.dart';

@RoutePage()
class WeatherPage extends StatelessWidget {
  const WeatherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<RegionFormCubit, RegionFormState>(
        listener: (context, state) {
          final region = state.currentRegion;
          if (region != Region.empty()) {
            context.read<WeatherLoaderCubit>().fetched(region.id);
          }

          if (state.failure != null) {
            debugPrint('an error occured:  ${state.failure}');
          }
        },
        child: BlocBuilder<RegionFormCubit, RegionFormState>(
          buildWhen: (p, c) => p.isLoading != c.isLoading,
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return const SafeArea(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    Expanded(
                      flex: 2,
                      child: RegionFormWidget(),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Expanded(
                      flex: 1,
                      child: WeatherPredictionsWidget(),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
