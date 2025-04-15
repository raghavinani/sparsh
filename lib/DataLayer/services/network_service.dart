import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';

class NetworkService {
  static Dio? _dio;

  static Dio get dio {
    _dio ??=
        Dio()
          ..options = BaseOptions(
            connectTimeout: const Duration(seconds: 30),
            receiveTimeout: const Duration(seconds: 30),
            validateStatus: (status) => status != null && status < 500,
            headers: {
              'Accept': 'application/json',
              'Content-Type': 'application/json',
            },
          );

    // Configure SSL certificate handling
    (_dio!.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate = (
      client,
    ) {
      client.badCertificateCallback = (
        X509Certificate cert,
        String host,
        int port,
      ) {
        print('SSL Certificate Check - Host: $host, Port: $port');
        print('Certificate Subject: ${cert.subject}');
        print('Certificate Issuer: ${cert.issuer}');

        // For development/testing, accept all certificates
        // In production, you should validate certificates properly
        return true;
      };
      return client;
    };

    _dio!.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          print('Request: ${options.method} ${options.uri}');
          print('Headers: ${options.headers}');
          if (options.data != null) {
            print('Body: ${options.data}');
          }
          return handler.next(options);
        },
        onResponse: (response, handler) {
          print('Response: ${response.statusCode}');
          print('Data: ${response.data}');
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          print('Error Type: ${e.type}');
          print('Error Message: ${e.message}');
          print('Error Response: ${e.response?.data}');
          print('Error Stack: ${e.stackTrace}');
          return handler.next(e);
        },
      ),
    );

    return _dio!;
  }

  static Future<Response> get(
    String url, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      print('Making GET request to: $url');
      final response = await dio.get(
        url,
        queryParameters: queryParameters,
        options: options?.copyWith(
          headers: {
            ...options.headers ?? {},
            'Accept': 'application/json',
            'Content-Type': 'application/json',
          },
        ),
      );
      return response;
    } catch (e) {
      print('Network GET Error: $e');
      if (e is DioException) {
        print('DioError Type: ${e.type}');
        print('DioError Message: ${e.message}');
        print('DioError Response: ${e.response?.data}');
        print('DioError Stack: ${e.stackTrace}');
      }
      throw _handleError(e);
    }
  }

  static Future<Response> post(
    String url, {
    dynamic data,
    Map<String, dynamic>? headers,
    Options? options,
  }) async {
    try {
      print('Making POST request to: $url');
      print('Request data: $data');
      final response = await dio.post(
        url,
        data: data,
        options: options?.copyWith(
          headers: {
            ...options.headers ?? {},
            ...headers ?? {},
            'Accept': 'application/json',
            'Content-Type': 'application/json',
          },
        ),
      );
      return response;
    } catch (e) {
      print('Network POST Error: $e');
      if (e is DioException) {
        print('DioError Type: ${e.type}');
        print('DioError Message: ${e.message}');
        print('DioError Response: ${e.response?.data}');
        print('DioError Stack: ${e.stackTrace}');
      }
      throw _handleError(e);
    }
  }

  static Exception _handleError(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
          return Exception(
            'Connection timeout - Please check your internet connection',
          );
        case DioExceptionType.receiveTimeout:
          return Exception('Receive timeout - Server took too long to respond');
        case DioExceptionType.badCertificate:
          return Exception(
            'SSL Certificate error - Please check server certificate',
          );
        case DioExceptionType.cancel:
          return Exception('Request cancelled');
        case DioExceptionType.connectionError:
          return Exception(
            'Connection error - Please check your internet connection',
          );
        case DioExceptionType.unknown:
          if (error.error is SocketException) {
            return Exception(
              'Network connection error - Please check your internet connection',
            );
          }
          return Exception(
            'Network error: ${error.message ?? 'Unknown error'}',
          );
        default:
          return Exception(
            'Network error: ${error.message ?? 'Unknown error'}',
          );
      }
    }
    return Exception('Unexpected error: $error');
  }
}
