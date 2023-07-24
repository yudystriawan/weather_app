import '../../domain/entities/entity.dart';

abstract class WeatherRemoteDataSource {
  Future<List<Region>> getRegions();
  Future<Region> getRegion({
    required double lat,
    required double long,
  });
  Future<List<Weather>> getWeathers(String regionId);
}

class WeatherRemoteDataSourceImpl implements WeatherRemoteDataSource {
  @override
  Future<Region> getRegion({required double lat, required double long}) {
    // TODO: implement getRegion
    throw UnimplementedError();
  }

  @override
  Future<List<Region>> getRegions() {
    // TODO: implement getRegions
    throw UnimplementedError();
  }

  @override
  Future<List<Weather>> getWeathers(String regionId) {
    // TODO: implement getWeathers
    throw UnimplementedError();
  }
}
