import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/features/weather/presentation/bloc/current_location/current_location_cubit.dart';

class WeatherTempInfoWidget extends StatelessWidget {
  const WeatherTempInfoWidget({
    Key? key,
    this.style,
  }) : super(key: key);

  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentLocationCubit, CurrentLocationState>(
      buildWhen: (p, c) => p.degree != c.degree,
      builder: (context, state) {
        return Text(
          state.currentWeather.getTemp(degree: state.degree),
          style: style,
        );
      },
    );
  }
}
