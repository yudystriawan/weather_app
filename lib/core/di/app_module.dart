import 'package:injectable/injectable.dart';
import 'package:weather_app/core/http_client/base_http_client.dart';

@module
abstract class AppModule {
  @lazySingleton
  BaseHttpClient get httpClient => BaseHttpClient();
}
