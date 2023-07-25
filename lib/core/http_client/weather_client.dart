import 'package:injectable/injectable.dart';
import 'package:weather_app/core/http_client/base_http_client.dart';

@lazySingleton
class WeatherClient extends BaseHttpClient {
  WeatherClient() : super(baseUrl: 'https://ibnux.github.io/BMKG-importer');
}
