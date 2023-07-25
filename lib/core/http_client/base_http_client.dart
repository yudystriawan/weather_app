import 'package:dio/dio.dart';

class BaseHttpClient with DioMixin implements Dio {
  final String baseUrl;

  BaseHttpClient({this.baseUrl = ''}) {
    options = BaseOptions(baseUrl: baseUrl);
    httpClientAdapter = HttpClientAdapter();
  }
}
