import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:kt_dart/collection.dart';
import 'package:weather_app/core/error/failure.dart';
import 'package:weather_app/core/usecases/usecase.dart';
import 'package:weather_app/features/weather/domain/entities/entity.dart';
import 'package:weather_app/features/weather/domain/repositories/weather_repository.dart';

@injectable
class GetRegions implements Usecase<KtList<Region>, NoParams> {
  final WeatherRepository _repository;

  GetRegions(this._repository);

  @override
  Future<Either<Failure, KtList<Region>>> call(NoParams params) async {
    return await _repository.getRegions();
  }
}
