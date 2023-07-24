import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:kt_dart/collection.dart';
import 'package:weather_app/core/error/failure.dart';
import 'package:weather_app/features/weather/domain/usecases/get_weathers.dart';

import '../../../domain/entities/entity.dart';

part 'weather_loader_cubit.freezed.dart';
part 'weather_loader_state.dart';

@injectable
class WeatherLoaderCubit extends Cubit<WeatherLoaderState> {
  final GetWeathers _getWeathers;
  WeatherLoaderCubit(
    this._getWeathers,
  ) : super(const WeatherLoaderState.initial());

  void fetched(String regionId) async {
    emit(const WeatherLoaderState.loadInProgress());

    final failureOrWeathers = await _getWeathers(Params(regionId: regionId));

    emit(failureOrWeathers.fold(
      (f) => WeatherLoaderState.loadFailure(f),
      (weathers) {
        // group weathers by date
        final groupByDate = groupBy(weathers.asList(), (weather) {
          final weatherTime = weather.time!;
          return DateTime(
            weatherTime.year,
            weatherTime.month,
            weatherTime.day,
          );
        }).toImmutableMap();

        return WeatherLoaderState.loadSuccess(groupByDate);
      },
    ));
  }
}
