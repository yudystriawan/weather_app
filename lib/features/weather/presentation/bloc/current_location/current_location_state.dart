part of 'current_location_cubit.dart';

@freezed
@freezed
class CurrentLocationState with _$CurrentLocationState {
  const factory CurrentLocationState({
    required Region currentRegion,
    required Weather currentWeather,
    required double currentLat,
    required double currentLng,
    Failure? failure,
    @Default(false) bool isLoading,
  }) = _CurrentLocationState;

  factory CurrentLocationState.initial() => CurrentLocationState(
        currentRegion: Region.empty(),
        currentLat: 0.0,
        currentLng: 0.0,
        currentWeather: Weather.empty(),
      );
}
