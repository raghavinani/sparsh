import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sprash_arch/features/auth/view/login_page.dart';
import 'package:sprash_arch/features/auth/viewModal/login_viewmodal.dart';

import '../../core/constants/secure_storage.dart';


import '../../features/auth/view/splash_screen.dart';

class LogoutService {
  final SecureStorage _secureStorage;

  LogoutService(this._secureStorage);
final loginViewModelProvider = Provider((ref) => LoginViewModel(ref));

  Future<void> logout(BuildContext context, WidgetRef ref) async {
    try {
   
      // Clear stored credentials
      await _secureStorage.deleteAll();

      // Clear providers
      ref.read(loginViewModelProvider).resetProviders();

      // Navigate to login page and remove all previous routes
      if (context.mounted) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => SplashScreen()),
          (Route<dynamic> route) => false,
        );
      }
    } catch (e) {
      debugPrint('Logout error: $e');
      // Handle any errors during logout
      throw Exception('Failed to logout');
    }
  }
}

// Provider for LogoutService
final logoutServiceProvider = Provider<LogoutService>((ref) {
  final secureStorage = ref.read(secureStorageProvider);
  return LogoutService(secureStorage);
});
