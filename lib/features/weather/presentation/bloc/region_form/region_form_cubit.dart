import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:weather_app/core/usecases/get_current_position.dart';
import 'package:weather_app/core/usecases/usecase.dart';
import 'package:weather_app/features/weather/domain/usecases/get_nearest_region.dart';

import '../../../../../core/error/failure.dart';
import '../../../domain/entities/entity.dart';

part 'region_form_cubit.freezed.dart';
part 'region_form_state.dart';

@injectable
class RegionFormCubit extends Cubit<RegionFormState> {
  final GetNearestRegion _getNearestRegion;
  final GetCurrentPosition _getCurrentPosition;

  RegionFormCubit(
    this._getNearestRegion,
    this._getCurrentPosition,
  ) : super(RegionFormState.initial());

  Future<void> initialized() async {
    emit(state.copyWith(
      isLoading: true,
      failure: null,
    ));

    final failureOrPosition = await _getCurrentPosition(const NoParams());
    final newState = state.copyWith(isLoading: false);

    emit(await failureOrPosition.fold(
      (f) async => newState.copyWith(failure: f),
      (position) async {
        final failureOrRegion = await _getNearestRegion(Params(
            referencePoint: LatLng(
          latitude: position.latitude,
          longitude: position.longitude,
        )));

        return failureOrRegion.fold(
          (f) => newState.copyWith(failure: f),
          (region) => newState.copyWith(
            currentRegion: region,
            currentLat: region.latitude,
            currentLng: region.longitude,
          ),
        );
      },
    ));
  }

  Future<void> regionChanged(Region region) async {
    emit(state.copyWith(failure: null, currentRegion: region));
  }
}
