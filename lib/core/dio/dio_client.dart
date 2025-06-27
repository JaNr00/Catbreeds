import 'package:dio/dio.dart';

class DioClient {
  final Dio _dio;

  DioClient({required String baseUrl})
      : _dio = Dio(
          BaseOptions(
            baseUrl: baseUrl,
            connectTimeout: const Duration(seconds: 10),
            receiveTimeout: const Duration(seconds: 10),
            headers: {
              'Content-Type': 'application/json',
            },
          ),
        ) {
    _dio.interceptors.add(LogInterceptor(
      request: true,
      requestBody: true,
      responseBody: true,
      error: true,
    ));
  }

  Dio get dio => _dio;

  Future<Response> get(String path,
      {Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers}) async {
    return await _dio.get(
      path,
      queryParameters: queryParameters,
      options: Options(
        headers: {..._dio.options.headers, if (headers != null) ...headers},
      ),
    );
  }

  Future<Response> post(String path,
      {dynamic data,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers}) async {
    return await _dio.post(
      path,
      data: data,
      queryParameters: queryParameters,
      options: Options(
        headers: {..._dio.options.headers, if (headers != null) ...headers},
      ),
    );
  }
}
