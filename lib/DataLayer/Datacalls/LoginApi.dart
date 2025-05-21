import 'package:dio/dio.dart';
import 'package:sparsh/DataLayer/services/dio_client.dart';

import '../../core/constants/secure_storage.dart';
import '../modals/LoginM.dart';
import '../services/network_service.dart';

class ApiException implements Exception {
  final String message;
  final int? statusCode;

  ApiException(this.message, {this.statusCode});

  @override
  String toString() =>
      'ApiException: $message${statusCode != null ? ' (Status code: $statusCode)' : ''}';
}

class NetworkException implements Exception {
  final String message;
  NetworkException(this.message);

  @override
  String toString() => 'NetworkException: $message';
}

class LoginService {
  final String baseUrl;
  Map<String, dynamic>? currentUser;
  List<String>? userRoles;
  Map<String, dynamic>? userData;
  Map<String, dynamic>? responseData;
  // static const String baseUrl = 'https://qa.birlawhite.com:55232/api/Auth/execute';
  final dioClient = DioClient();
  SecureStorage pref = SecureStorage(); // insances of SS and Dio
  LoginService({this.baseUrl = 'https://qa.birlawhite.com:55232'});

  // Login with email and password
  Future<UserLogin> loginWithEmailAndPassword({
    required String email,
    required String password,
    Duration timeout = const Duration(seconds: 30),
  }) async {
    // Input validation
    if (email.isEmpty) {
      throw ApiException('Email cannot be empty');
    }
    if (password.isEmpty) {
      throw ApiException('Password cannot be empty');
    }

    // Basic email format validation
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(email)) {
      throw ApiException('Invalid email format');
    }

    try {
      final response = await NetworkService.post(
        '$baseUrl/api/UserLogin/authenticate',
        data: {'email': email, 'password': password},
        options: Options(
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'Accept': 'application/json',
            'Access-Control-Allow-Origin': '*',
          },
          validateStatus: (status) => status != null && status < 500,
        ),
      );

      switch (response.statusCode) {
        case 200:
          return UserLogin.fromJson(response.data);
        case 400:
          throw ApiException('Invalid request', statusCode: 400);
        case 401:
          throw ApiException(
            'Invalid credentials OR InActive Account',
            statusCode: 401,
          );
        case 500:
          throw ApiException('Server error', statusCode: 500);
        default:
          throw ApiException(
            'Unexpected error: ${response.statusMessage}',
            statusCode: response.statusCode,
          );
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw NetworkException('Request timed out');
      }
      throw NetworkException('Network error: ${e.message}');
    } catch (e) {
      if (e is ApiException || e is NetworkException) {
        rethrow;
      }
      throw ApiException('Unknown error: $e');
    }
  }

  // Login with user ID and password
  Future<Map<String, dynamic>> loginWithUserIdAndPassword({
    required String userId,
    required String password,
    Duration timeout = const Duration(seconds: 30),
  }) async {
    // Input validation
    if (userId.isEmpty) {
      throw ApiException('Invalid user ID');
    }
    if (password.isEmpty) {
      throw ApiException('Password cannot be empty');
    }
    final body = {
      "userID": userId,
      "password": password,
      "appRegId":
          "fdwAEk1NTsmJH7sYzDPmyL:APA91bGBrRhs83rFmzw3jUmAPIrKcz4PlW1u3T-qsBdNwhlkGKEXayxcMxAHbpT57NFG3-ayQC7LGnLrmGGWlhDgeATITJOUmtafRD_IquUDvruXvlRTOkFVOXfTUjJX8JZGm-gwyHu3",
    };

    try {
      final response = await dioClient.dio.post(
        "$baseUrl/api/Auth/execute",
        data: body,
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
          },
        ),
      );

      // Log response data
      print('Received response from API:');
      // print(response.data);

      if (response.statusCode != 200) {
        throw Exception('Login failed with status code ${response.statusCode}');
      }

      try {
        if (response.data == null) {
          throw Exception('Login failed: Response data is null');
        } else {
          responseData = response.data as Map<String, dynamic>;
          userData = responseData?['data'] as Map<String, dynamic>;

          print(userData?['areaCode']);
          print(userData?['roles']);
          print(userData?['pages']);
          print(userData?['emplName']);
        }
      } catch (e) {
        print('Error during login: $e');
        throw Exception("Error during login: $e");
      }

      return userData!;
    } catch (e) {
      print('Error during login: $e');
      throw Exception("Error during login: $e");
    }
  }

  //  Jwt Token call
  Future<String?> getToken(String partnerId, String secretKey) async {
    final Map<String, String> requestBody = {
      'PartnerID': partnerId,
      'SecretKey': secretKey,
    };

    try {
      final response = await dioClient.dio.post(
        '$baseUrl/api/Token/generate',
        data: requestBody,
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = response.data;
        final token = responseData['Token'];
        if (token != null) {
          await pref.storeToken(token);
        }
        return token;
      } else {
        throw Exception(
          'Failed to get token: ${response.statusCode} - ${response.data}',
        );
      }
    } catch (error) {
      throw Exception('Error during token request: $error');
    }
  }

  Future<String?> getStoredToken() async {
    return await pref.getToken();
  }

  Future<void> clearToken() async {
    await pref.deleteToken();
  }
}
