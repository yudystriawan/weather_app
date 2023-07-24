import 'package:dartz/dartz.dart';
import 'package:kt_dart/collection.dart';
import 'package:weather_app/features/weather/domain/entities/entity.dart';

import '../../../../core/error/failure.dart';

abstract class WeatherRepository {
  Future<Either<Failure, KtList<Region>>> getRegions();
  Future<Either<Failure, KtList<Weather>>> getWeathers(String regionId);
}
