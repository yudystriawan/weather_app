import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:weather_app/core/error/failure.dart';
import 'package:weather_app/core/http_client/weather_client.dart';
import 'package:weather_app/features/weather/data/models/model.dart';

import '../../../../core/http_client/api_path.dart';

abstract class WeatherRemoteDataSource {
  Future<List<RegionModel>?> getRegions();
  Future<List<WeatherModel>?> getWeathers(String regionId);
}

@Injectable(as: WeatherRemoteDataSource)
class WeatherRemoteDataSourceImpl implements WeatherRemoteDataSource {
  final WeatherClient _client;

  WeatherRemoteDataSourceImpl(this._client);

  @override
  Future<List<RegionModel>?> getRegions() async {
    try {
      final response = await _client.get('${ApiPath.getWeathers}/wilayah.json');

      if (response.statusCode != 200) {
        throw Failure.serverError(
          statusCode: response.statusCode,
          message: response.statusMessage,
        );
      }

      final data = response.data as List;
      final regions = data.map((e) => RegionModel.fromJson(e)).toList();
      return regions;
    } on DioException catch (e) {
      throw Failure.serverError(
        statusCode: e.response?.statusCode,
        message: e.response?.statusMessage,
      );
    } catch (e) {
      throw const Failure.unexpectedError();
    }
  }

  @override
  Future<List<WeatherModel>?> getWeathers(String regionId) async {
    try {
      final response =
          await _client.get('${ApiPath.getWeathers}/$regionId.json');

      if (response.statusCode != 200) {
        throw Failure.serverError(
          statusCode: response.statusCode,
          message: response.statusMessage,
        );
      }

      final data = response.data as List;
      final weathers = data.map((e) => WeatherModel.fromJson(e)).toList();
      return weathers;
    } on DioException catch (e) {
      throw Failure.serverError(
        statusCode: e.response?.statusCode,
        message: e.response?.statusMessage,
      );
    } catch (e) {
      throw const Failure.unexpectedError();
    }
  }
}
