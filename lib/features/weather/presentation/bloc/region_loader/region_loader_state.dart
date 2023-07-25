part of 'region_loader_cubit.dart';

@freezed
class RegionLoaderState with _$RegionLoaderState {
  const factory RegionLoaderState.initial() = _Initial;
  const factory RegionLoaderState.loadInProgress() = _LoadInProgress;
  const factory RegionLoaderState.loadFailure(Failure failure) = _LoadFailure;
  const factory RegionLoaderState.loadSuccess(KtList<Region> regions) =
      _LoadSuccess;
}
