// Add these imports at the top
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:async';

import '../Datacalls/ApiCon.dart';


// First, create a service class to handle business logic
class RetailerService {
  final ApiService api;
  final FlutterSecureStorage _secureStorage;
  
  RetailerService({
    required this.api,
  }) : _secureStorage = const FlutterSecureStorage();

  // Cache for area codes and states
  final Map<String, String> _areaCodeCache = {};
  final Map<String, List<String>> _areasCache = {};

   Future<String> generateDocumentNumber(
    String year,
    String areaCode,
    String retailCode,
  ) async {
    try {
      if (areaCode.isEmpty || retailCode.isEmpty) {
        throw Exception('Area code or retail code is empty');
      }

      // Format: YY[AREACODE][RETAILCODE]Sequential
      String sequential = await _getSequentialNumber();
      return '$year$areaCode$retailCode$sequential';
    } catch (e) {
      throw Exception('Failed to generate document number: $e');
    }
  }

  // Get sequential number (you might want to store and increment this in your database)
  Future<String> _getSequentialNumber() async {
    // This should ideally come from your database
    return '001'; // Placeholder - implement actual sequential number generation
  }

  
  Future<String?> getAreaCode(String district) async {
    try {
      // Check cache first
      if (_areaCodeCache.containsKey(district)) {
        return _areaCodeCache[district];
      }

      final code = await api.getAreaCode(district);
      _areaCodeCache[district] = code;
    
      return code;
    } catch (e) {
      throw Exception('Failed to get area code: $e');
    }
  }

  Future<List<String>> getAreas(String state) async {
    try {
      // Check cache first
      if (_areasCache.containsKey(state)) {
        return _areasCache[state]!;
      }

      final areas = await api.getAreas(state);
      _areasCache[state] = areas;
      return areas ?? [];
    } catch (e) {
      throw Exception('Failed to get areas: $e');
    }
  }

  

  Future<void> submitRetailerData({
    required String doc,
    required String processType,
    required String gst,
    required DateTime time,
    required String mobile,
    required String area,
    required String district,
    required String retailCategory,
    required String address,
  }) async {
    try {
      // Validate inputs
      if (!_isValidGST(gst)) throw Exception('Invalid GST format');
      if (!_isValidMobile(mobile)) throw Exception('Invalid mobile number');
      
      // Implement retry logic
      int retryCount = 0;
      while (retryCount < 3) {
        try {
          await api.sendData(
            doc,
            processType,
            gst,
            time,
            mobile,
            area,
            district,
            retailCategory,
            address,
          );
          break;
        } catch (e) {
          retryCount++;
          if (retryCount == 3) rethrow;
          await Future.delayed(Duration(seconds: 2));
        }
      }
    } catch (e) {
      throw Exception('Failed to submit data: $e');
    }
  }

  bool _isValidGST(String gst) {
    return RegExp(r'^\d{2}[A-Z]{5}\d{4}[A-Z]{1}\d[Z]{1}\d{1}$').hasMatch(gst);
  }

  bool _isValidMobile(String mobile) {
    return RegExp(r'^\d{10}$').hasMatch(mobile);
  }
}

// Modify your RetailerRegistrationPage state class
