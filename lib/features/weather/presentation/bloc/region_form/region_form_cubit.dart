import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:weather_app/core/usecases/get_current_position.dart';
import 'package:weather_app/core/usecases/usecase.dart';

import '../../../../../core/error/failure.dart';
import '../../../domain/entities/entity.dart';
import '../../../domain/usecases/get_nearest_region.dart' as ng;
import '../../../domain/usecases/get_weather.dart' as w;

part 'region_form_cubit.freezed.dart';
part 'region_form_state.dart';

@injectable
class RegionFormCubit extends Cubit<RegionFormState> {
  final ng.GetNearestRegion _getNearestRegion;
  final GetCurrentPosition _getCurrentPosition;
  final w.GetWeather _getWeather;

  RegionFormCubit(
    this._getNearestRegion,
    this._getCurrentPosition,
    this._getWeather,
  ) : super(RegionFormState.initial());

  Future<void> initialized({
    double? latitude,
    double? longitude,
  }) async {
    emit(state.copyWith(
      isLoading: true,
      failure: null,
    ));

    if (latitude != null && longitude != null) {
      emit(await _getDataToState(
        latitude: latitude,
        longitude: longitude,
      ));
      return;
    }

    final failureOrPosition = await _getCurrentPosition(const NoParams());
    final newState = state.copyWith(isLoading: false);

    emit(await failureOrPosition.fold(
      (f) async => newState.copyWith(failure: f),
      (position) async {
        return await _getDataToState(
          latitude: position.latitude,
          longitude: position.longitude,
        );
      },
    ));
  }

  Future<void> regionChanged(Region region) async {
    emit(state.copyWith(
      failure: null,
      currentRegion: region,
    ));
    initialized(latitude: region.latitude, longitude: region.longitude);
  }

  Future<RegionFormState> _getDataToState({
    required double latitude,
    required double longitude,
  }) async {
    final latLng = ng.LatLng(
      latitude: latitude,
      longitude: longitude,
    );

    final failureOrRegion = await _getNearestRegion(
      ng.Params(referencePoint: latLng),
    );

    final newState = state.copyWith(isLoading: false);

    return await failureOrRegion.fold(
      (f) async => newState.copyWith(failure: f),
      (region) async {
        // get weather
        final failureOrWeather = await _getWeather(w.Params(region.id));

        return failureOrWeather.fold(
          (f) => newState.copyWith(failure: f),
          (weather) => newState.copyWith(
            currentRegion: region,
            currentWeather: weather,
            currentLat: region.latitude,
            currentLng: region.longitude,
          ),
        );
      },
    );
  }
}
