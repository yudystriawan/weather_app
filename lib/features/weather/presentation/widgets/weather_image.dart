import 'package:flutter/material.dart';
import 'package:weather_app/features/weather/domain/entities/entity.dart';

class WeatherImage extends StatelessWidget {
  const WeatherImage({
    Key? key,
    required this.weather,
    this.size,
  }) : super(key: key);

  final Weather weather;
  final double? size;

  @override
  Widget build(BuildContext context) {
    const url = 'https://ibnux.github.io/BMKG-importer/icon';

    return Image.network(
      '$url/${weather.code}.png',
      width: size,
      height: size,
    );
  }
}
