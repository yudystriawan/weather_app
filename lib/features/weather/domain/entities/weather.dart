part of 'entity.dart';

@freezed
class Weather with _$Weather {
  const factory Weather({
    required String time,
    required String code,
    required String weather,
    required String humidity,
    required double tempC,
    required double tempF,
  }) = _Weather;

  factory Weather.empty() => const Weather(
        time: '',
        code: '',
        weather: '',
        humidity: '',
        tempC: 0.0,
        tempF: 0.0,
      );
}
