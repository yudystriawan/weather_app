part of 'region_form_cubit.dart';

@freezed
@freezed
class RegionFormState with _$RegionFormState {
  const factory RegionFormState({
    required Region selectedRegion,
    required double currentLat,
    required double currentLng,
    Failure? failure,
    @Default(false) bool isLoading,
  }) = _RegionFormState;

  factory RegionFormState.initial() => RegionFormState(
        selectedRegion: Region.empty(),
        currentLat: 0.0,
        currentLng: 0.0,
      );
}
