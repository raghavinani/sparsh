import 'dart:convert';
import 'package:dio/dio.dart';

import '../services/dio_client.dart';

class ApiService {
  static const String baseUrl = "https://qa.birlawhite.com:55232/api/Control";
  // qa.birlawhite.com:55232/api/Control

  final dioClient = DioClient();

  Future<List<dynamic>> getAll() async {
    try {
      final response = await dioClient.dio.get(baseUrl);
      if (response.statusCode == 200) {
        return response.data as List<dynamic>;
      }
      throw Exception(
        "Failed to fetch data. Status Code: ${response.statusCode}",
      );
    } catch (e) {
      throw Exception("Error fetching data: $e");
    }
  }

  Future<List> getone(String id) async {
    try {
      final response = await dioClient.dio.get("$baseUrl/$id");
      if (response.statusCode == 200) {
        return response.data as List<dynamic>;
      }
      throw Exception(
        "Failed to fetch data. Status Code: ${response.statusCode}",
      );
    } catch (e) {
      throw Exception("Error fetching data: $e");
    }
  }

  Future<void> del(String id) async {
    try {
      final response = await dioClient.dio.post(
        "$baseUrl/$id",
        options: Options(method: 'DELETE'),
      );
      if (response.statusCode == 200) {
        print("DELETED THE DATA");
      } else {
        throw Exception(
          "Failed to delete data. Status Code: ${response.statusCode}",
        );
      }
    } catch (e) {
      throw Exception("Error deleting data: $e");
    }
  }

  Future<void> sendData(
    String doc,
    String processType,
    String description,
    DateTime date,
    String meetingVenue,
    String location,
    String district,
    String pincode,
    String product,
  ) async {
    final dateString = date.toIso8601String();
    final body = {
      'Doc': doc,
      'Area': pincode,
      'Loc': location,
      'Pro': processType,
      'Act': description,
      'Date': dateString,
      'Met': meetingVenue,
      'Dist': district,
      'Prod': product,
    };

    try {
      final response = await dioClient.dio.post(
        baseUrl,
        data: body,
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      if (response.statusCode == 201) {
        print('Data sent successfully');
      } else {
        throw Exception(
          'Failed to send data. Status Code: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Error sending data: $e');
    }
  }
// can be used to get a distinct column values 
  // Future<List<String>> getDistinctValues(String columnName) async {
  //   try {
  //     final response = await dioClient.dio.get("$baseUrl/distinct/$columnName");
  //     if (response.statusCode == 200) {
  //       return List<String>.from(response.data);
  //     }
  //     throw Exception("Failed to fetch distinct values for $columnName");
  //   } catch (e) {
  //     throw Exception("Error fetching distinct values: $e");
  //   }
  // }



//   get the States that are preloaded in the registration report 
  Future<List<String>> getStates() async {
    try {
      print('Attempting to fetch states from: $baseUrl/getstates');
      final response = await dioClient.dio.get(
        '$baseUrl/getstates',
        options: Options(
          validateStatus: (status) => status != null && status < 500,
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
          },
        ),
      );

      print('Response received: ${response.statusCode}');
      print('Response data: ${response.data}');

      if (response.statusCode == 200) {
        if (response.data == null) {
          print('Warning: Received null response data');
          return []; // Return empty list instead of throwing
        }
        return List<String>.from(response.data);
      } else if (response.statusCode == 404) {
        print('Warning: States endpoint not found (404)');
        return []; // Return empty list for 404
      }
      print('Warning: Unexpected status code: ${response.statusCode}');
      return []; // Return empty list for other status codes
    } on DioException catch (e) {
      print('DioException in getStates: ${e.type}');
      print('DioException message: ${e.message}');
      print('DioException response: ${e.response?.data}');
      return []; // Return empty list for network errors
    } catch (e) {
      print('Unexpected error in getStates: $e');
      return []; // Return empty list for other errors
    }
  }


// Get the distinct Districts for a state the user selects
  Future<List<String>> getAreas(String state) async {
    try {
      final response = await dioClient.dio.get(
        '$baseUrl/getdistricts/$state',
        options: Options(
          validateStatus: (status) => status != null && status < 500,
        ),
      );

      if (response.statusCode == 200) {
        return List<String>.from(response.data);
      }
      throw Exception(
        'Failed to load Areas: Status code ${response.statusCode}',
      );
    } catch (e) {
      throw Exception('Error loading Areas: $e');
    }
  }


// get the areacode that coresponds to States
  Future<String> getAreaCode(String area) async {
    try {
      final response = await dioClient.dio.get(
        '$baseUrl/areaCode/$area',
        options: Options(
          headers: {'Accept': 'application/json'},
          validateStatus: (status) => status != null && status < 500,
        ),
      );

      if (response.statusCode == 200) {
        final areaCode = response.data.toString();
        if (areaCode.isEmpty) {
          throw Exception('Empty area code received');
        }
        return areaCode;
      }
      throw Exception(
        'Failed to get area code. Status: ${response.statusCode}',
      );
    } catch (e) {
      throw Exception('Error fetching area code: $e');
    }
  }




  
}
