import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:kt_dart/collection.dart';
import 'package:weather_app/core/error/failure.dart';
import 'package:weather_app/core/usecases/usecase.dart';
import 'package:weather_app/features/weather/domain/repositories/weather_repository.dart';

import '../entities/entity.dart';

class Params extends Equatable {
  final String regionId;

  const Params({
    required this.regionId,
  });

  @override
  List<Object?> get props => [regionId];
}

@injectable
class GetWeathers implements Usecase<KtList<Weather>, Params> {
  final WeatherRepository _repository;

  GetWeathers(this._repository);

  @override
  Future<Either<Failure, KtList<Weather>>> call(Params params) async {
    return await _repository.getWeathers(params.regionId);
  }
}
