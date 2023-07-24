import 'package:dartz/dartz.dart';
import 'package:kt_dart/collection.dart';
import 'package:weather_app/features/weather/domain/entities/entity.dart';

import '../../../../core/error/failure.dart';

abstract class WeatherRepository {
  Future<Either<Failure, Region>> getRegion({
    required double latitude,
    required double longitude,
  });
  Future<Either<Failure, KtList<Weather>>> getWeathers(String regionId);
}
