part of 'weather_loader_cubit.dart';

@freezed
class WeatherLoaderState with _$WeatherLoaderState {
  const factory WeatherLoaderState.initial() = _Initial;
  const factory WeatherLoaderState.loadInProgress() = _LoadInProgress;
  const factory WeatherLoaderState.loadFailure(Failure failure) = _LoadFailure;
  const factory WeatherLoaderState.loadSuccess(KtList<Weather> weathers) =
      _LoadSuccess;
}
