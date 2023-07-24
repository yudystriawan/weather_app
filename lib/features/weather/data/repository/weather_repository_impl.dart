import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:kt_dart/collection.dart';
import 'package:weather_app/core/error/failure.dart';
import 'package:weather_app/features/weather/data/datasources/weather_remote_data_source.dart';
import 'package:weather_app/features/weather/domain/entities/entity.dart';

import '../../domain/repositories/weather_repository.dart';

@Injectable(as: WeatherRepository)
class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherRemoteDataSource _remoteDataSource;

  WeatherRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, KtList<Region>>> getRegions() async {
    try {
      final result = await _remoteDataSource.getRegions();

      if (result == null) return right(const KtList.empty());

      final regions = result.map((e) => e.toDomain()).toImmutableList();

      return right(regions);
    } on Failure catch (e) {
      return left(e);
    } catch (e) {
      log('an error occured', error: e, name: runtimeType.toString());
      return left(const Failure.unexpectedError());
    }
  }

  @override
  Future<Either<Failure, KtList<Weather>>> getWeathers(String regionId) async {
    try {
      final result = await _remoteDataSource.getWeathers(regionId);

      if (result == null) return right(const KtList.empty());

      final weathers = result.map((e) => e.toDomain()).toImmutableList();

      return right(weathers);
    } on Failure catch (e) {
      return left(e);
    } catch (e) {
      log('an error occured', error: e, name: runtimeType.toString());
      return left(const Failure.unexpectedError());
    }
  }
}
