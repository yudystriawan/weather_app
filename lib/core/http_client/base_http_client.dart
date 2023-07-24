import 'package:dio/dio.dart';

class BaseHttpClient with DioMixin implements Dio {
  final String? baseUrl;

  BaseHttpClient([this.baseUrl]);

  @override
  set options(BaseOptions options) {
    super.options = options.copyWith(
      baseUrl: baseUrl,
    );
  }
}
