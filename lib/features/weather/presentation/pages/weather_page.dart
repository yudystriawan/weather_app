import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/features/weather/domain/entities/entity.dart';
import 'package:weather_app/features/weather/presentation/bloc/region_form/region_form_cubit.dart';
import 'package:weather_app/features/weather/presentation/bloc/region_loader/region_loader_cubit.dart';
import 'package:weather_app/features/weather/presentation/bloc/weather_loader/weather_loader_cubit.dart';
import 'package:weather_app/injection.dart';

@RoutePage()
class WeatherPage extends StatelessWidget implements AutoRouteWrapper {
  const WeatherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<RegionFormCubit, RegionFormState>(
        listener: (context, state) {
          final region = state.selectedRegion;
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

            final region = state.selectedRegion;
            return SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(region.province),
                    Text(region.city),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<RegionLoaderCubit>()..fetched(),
        ),
        BlocProvider(
          create: (context) => getIt<WeatherLoaderCubit>(),
        ),
      ],
      child: this,
    );
  }
}
