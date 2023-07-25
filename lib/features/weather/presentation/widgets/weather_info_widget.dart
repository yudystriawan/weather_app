import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/core/styles/typography/text_style.dart';
import 'package:weather_app/core/utils/date_formatter.dart';
import 'package:weather_app/features/weather/presentation/widgets/weather_image.dart';
import 'package:weather_app/features/weather/presentation/widgets/weather_temp_info_widget.dart';

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
            WeatherTempInfoWidget(
              style: AppTextStyle.headline1,
            ),
            SizedBox(
              height: 10.w,
            ),
            Text(
              DateTime.now().toDateFormatted('EEEE, dd MMM hh:mm'),
              style: AppTextStyle.bodyText1,
            ),
            SizedBox(
              height: 4.w,
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
