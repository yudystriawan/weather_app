import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_app/core/error/failure.dart';
import 'package:weather_app/core/usecases/usecase.dart';
import 'package:weather_app/features/weather/domain/entities/entity.dart';
import 'package:weather_app/features/weather/domain/repositories/weather_repository.dart';

class GetRegion implements Usecase<Region, Params> {
  final WeatherRepository _repository;

  GetRegion(this._repository);
  @override
  Future<Either<Failure, Region>> call(Params params) async {
    return await _repository.getRegion(
      latitude: params.latitude,
      longitude: params.longitude,
    );
  }
}

class Params extends Equatable {
  final double latitude;
  final double longitude;

  const Params({
    required this.latitude,
    required this.longitude,
  });

  @override
  List<Object?> get props => [latitude, longitude];
}
