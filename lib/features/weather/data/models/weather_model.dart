part of 'model.dart';

@freezed
class WeatherModel with _$WeatherModel {
  const WeatherModel._();
  const factory WeatherModel({
    @JsonKey(name: 'jamCuaca') String? time,
    @JsonKey(name: 'kodeCuaca') String? code,
    @JsonKey(name: 'cuaca') String? weather,
    String? humidity,
    @JsonKey(name: 'tempC') String? tempC,
    @JsonKey(name: 'tempF') String? tempF,
  }) = _WeatherModel;

  factory WeatherModel.fromJson(Map<String, dynamic> json) =>
      _$WeatherModelFromJson(json);

  Weather toDomain() {
    final empty = Weather.empty();
    return Weather(
      time: DateTime.tryParse(time ?? ''),
      code: code ?? empty.code,
      weather: weather ?? empty.weather,
      humidity: humidity ?? empty.humidity,
      tempC: double.tryParse(tempC ?? '') ?? empty.tempC,
      tempF: double.tryParse(tempF ?? '') ?? empty.tempF,
    );
  }
}
