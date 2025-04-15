import 'package:dio/dio.dart';
import 'package:dio/io.dart';

class DioClient {
  static final DioClient _instance = DioClient._internal();
  late Dio dio;

  factory DioClient() {
    return _instance;
  }

  DioClient._internal() {
    dio = Dio();
    (dio.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate = (
      client,
    ) {
      client.badCertificateCallback = (cert, host, port) {
        // Accept all certificates for development
        // In production, you should properly validate certificates
        return true;
      };
      return client;
    };
  }
}
