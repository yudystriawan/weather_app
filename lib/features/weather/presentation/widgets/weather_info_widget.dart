import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/styles/typography/text_style.dart';
import 'package:weather_app/core/utils/date_formatter.dart';
import 'package:weather_app/features/weather/presentation/widgets/weather_image.dart';

import '../bloc/current_location/current_location_cubit.dart';

class WeatherInfoWidget extends StatelessWidget {
  const WeatherInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentLocationCubit, CurrentLocationState>(
      buildWhen: (p, c) => p.currentWeather != c.currentWeather,
      builder: (context, state) {
        final weather = state.currentWeather;
        return Column(
          children: [
            Text(
              weather.getTemp(),
              style: AppTextStyle.headline1,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              DateTime.now().toDateFormatted('EEEE, dd MMM hh:mm'),
              style: AppTextStyle.bodyText1,
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              weather.weather.isEmpty ? '-' : weather.weather,
              style: AppTextStyle.headline6,
            ),
            WeatherImage(weather: weather),
          ],
        );
      },
    );
  }
}
