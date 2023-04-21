import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:signinator/core/core.dart';
import 'package:signinator/dependencies_injection.dart';
import 'package:signinator/utils/utils.dart';

typedef ResponseConverter<T> = T Function(dynamic response);

class DioClient {
  String baseUrl = "https://reqres.in";

  String? _auth;
  bool _isUnitTest = false;
  late Dio _dio;

  DioClient({bool isUnitTest = false}) {
    _isUnitTest = isUnitTest;

    try {
      _auth = sl<PrefManager>().token;
    } catch (_) {}

    _dio = _createDio();

    if (!_isUnitTest) _dio.interceptors.add(DioInterceptor());
  }

  Dio get dio {
    if (_isUnitTest) {
      /// Return static dio if is unit test
      return _dio;
    } else {
      /// We need to recreate dio to avoid token issue after login
      try {
        _auth = sl<PrefManager>().token;
      } catch (_) {}

      final dio = _createDio();

      if (!_isUnitTest) dio.interceptors.add(DioInterceptor());

      return dio;
    }
  }

  Dio _createDio() => Dio(
        BaseOptions(
          baseUrl: baseUrl,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            if (_auth != null) ...{
              'Authorization': _auth,
            },
          },
          receiveTimeout: 60000,
          connectTimeout: 60000,
          validateStatus: (int? status) {
            return status! > 0;
          },
        ),
      );

  Future<Either<Failure, T>> getRequest<T>(
    String url, {
    Map<String, dynamic>? queryParameters,
    required ResponseConverter<T> converter,
  }) async {
    try {
      final response = await dio.get(url, queryParameters: queryParameters);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return Right(converter(response.data));
      }

      throw DioError(
        requestOptions: response.requestOptions,
        response: response,
      );
    } on DioError catch (e) {
      return Left(
        ServerFailure(_relevantErrorMessage(e)),
      );
    }
  }

  Future<Either<Failure, T>> postRequest<T>(
    String url, {
    Map<String, dynamic>? data,
    required ResponseConverter<T> converter,
  }) async {
    try {
      final response = await dio.post(url, data: data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return Right(converter(response.data));
      }

      throw DioError(
        requestOptions: response.requestOptions,
        response: response,
      );
    } on DioError catch (e) {
      return Left(
        ServerFailure(_relevantErrorMessage(e)),
      );
    }
  }

  String? _relevantErrorMessage(DioError e) =>
      e.response?.data['description'] as String? ??
      e.response?.data['error'] as String? ??
      e.message;
}
