
import 'package:dio/dio.dart';

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

  // Login with mobile number and password
  Future<UserLogin> loginWithMobileAndPassword({
    required String mobileNumber,
    required String password,
    Duration timeout = const Duration(seconds: 30),
  }) async {
    // Input validation
    if (mobileNumber.isEmpty) {
      throw ApiException('Mobile number cannot be empty');
    }
    if (password.isEmpty) {
      throw ApiException('Password cannot be empty');
    }

    // Basic mobile number format validation
    final mobileRegex = RegExp(r'^\d{10}$');
    if (!mobileRegex.hasMatch(mobileNumber)) {
      throw ApiException('Invalid mobile number format (must be 10 digits)');
    }

    try {
      // First, get the user details by mobile number
      final userInfo = await getUserByMobileNumber(
        mobileNumber,
        timeout: timeout,
      );

      if (userInfo == null) {
        throw ApiException(
          'User not found with this mobile number',
          statusCode: 404,
        );
      }

      // Then authenticate with the retrieved email and provided password
      if (userInfo.emailAddress == null || userInfo.emailAddress!.isEmpty) {
        throw ApiException(
          'User account has no email associated',
          statusCode: 400,
        );
      }

      return await loginWithEmailAndPassword(
        email: userInfo.emailAddress!,
        password: password,
        timeout: timeout,
      );
    } catch (e) {
      if (e is ApiException || e is NetworkException) {
        rethrow;
      }
      throw ApiException('Unknown error during mobile login: $e');
    }
  }

  // Get user by mobile number
  Future<UserLogin?> getUserByMobileNumber(
    String mobileNumber, {
    Duration timeout = const Duration(seconds: 30),
  }) async {
    if (mobileNumber.isEmpty) {
      throw ApiException('Mobile number cannot be empty');
    }

    try {
      final response = await NetworkService.get(
        '$baseUrl/api/UserLogin/mobile/$mobileNumber',
        options: Options(
          validateStatus: (status) => status != null && status < 500,
        ),
      );

      switch (response.statusCode) {
        case 200:
          return UserLogin.fromJson(response.data);
        case 400:
          throw ApiException('Invalid request', statusCode: 400);
        case 404:
          return null; // User not found
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
  Future<UserLogin> loginWithUserIdAndPassword({
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

    try {
      // First, get the user details by ID
      final userInfo = await getUserById(userId, timeout: timeout);

      if (userInfo == null) {
        throw ApiException('User not found with this ID', statusCode: 404);
      }

      // Then authenticate with the retrieved email and provided password
      if (userInfo.emailAddress == null || userInfo.emailAddress!.isEmpty) {
        throw ApiException(
          'User account has no email associated',
          statusCode: 400,
        );
      }

      return await loginWithEmailAndPassword(
        email: userInfo.emailAddress!,
        password: password,
        timeout: timeout,
      );
    } catch (e) {
      if (e is ApiException || e is NetworkException) {
        rethrow;
      }
      throw ApiException('Unknown error during user ID login: $e');
    }
  }

  // Get user by ID
  Future<UserLogin?> getUserById(
    String userId, {
    Duration timeout = const Duration(seconds: 30),
  }) async {
    if (userId.isEmpty) {
      throw ApiException('Invalid user ID');
    }

    try {
      final response = await NetworkService.get(
        '$baseUrl/api/UserLogin/$userId',
        options: Options(
          validateStatus: (status) => status != null && status < 500,
        ),
      );

      switch (response.statusCode) {
        case 200:
          return UserLogin.fromJson(response.data);
        case 400:
          throw ApiException('Invalid request', statusCode: 400);
        case 404:
          return null; // User not found
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
}
