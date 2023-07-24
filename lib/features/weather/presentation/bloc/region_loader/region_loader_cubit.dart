import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:kt_dart/collection.dart';
import 'package:weather_app/core/error/failure.dart';
import 'package:weather_app/core/usecases/usecase.dart';
import 'package:weather_app/features/weather/domain/usecases/get_regions.dart';

import '../../../domain/entities/entity.dart';

part 'region_loader_cubit.freezed.dart';
part 'region_loader_state.dart';

@injectable
class RegionLoaderCubit extends Cubit<RegionLoaderState> {
  final GetRegions _getRegions;

  RegionLoaderCubit(
    this._getRegions,
  ) : super(const RegionLoaderState.initial());

  Future<void> fetched() async {
    emit(const RegionLoaderState.loadInProgress());

    final failureOrRegions = await _getRegions(const NoParams());

    emit(failureOrRegions.fold(
      (f) => RegionLoaderState.loadFailure(f),
      (regions) => RegionLoaderState.loadSuccess(regions),
    ));
  }
}
