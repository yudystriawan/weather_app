import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:kt_dart/collection.dart';
import 'package:weather_app/core/error/failure.dart';
import 'package:weather_app/core/usecases/usecase.dart';
import 'package:weather_app/features/weather/domain/entities/entity.dart';
import 'package:weather_app/features/weather/domain/repositories/weather_repository.dart';

class Params extends Equatable {
  final String regionId;

  const Params(this.regionId);

  @override
  List<Object> get props => [regionId];
}

@injectable
class GetWeather implements Usecase<Weather, Params> {
  final WeatherRepository _repository;

  GetWeather(this._repository);

  @override
  Future<Either<Failure, Weather>> call(Params params) async {
    final failureOrWeathers = await _repository.getWeathers(params.regionId);

    return failureOrWeathers.fold(
      (f) => left(f),
      (weathers) {
        final currentDateTime = DateTime.now();

        // get weather for today
        final filteredWeathers = weathers
            .filter((weather) => weather.time?.day == currentDateTime.day);

        Weather selectedWeather = Weather.empty();

        for (var weather in filteredWeathers.iter) {
          if (currentDateTime.isAfter(weather.time!)) {
            selectedWeather = weather;
          }
        }

        return right(selectedWeather);
      },
    );
  }
}
