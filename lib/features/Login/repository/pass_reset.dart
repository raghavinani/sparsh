// Providers
import 'package:flutter_riverpod/flutter_riverpod.dart';

final emailProvider = StateProvider<String>((ref) => '');
final isLoadingProvider = StateProvider<bool>((ref) => false);
final errorMessageProvider = StateProvider<String?>((ref) => null);
final isResetLinkSentProvider = StateProvider<bool>((ref) => false);

// Password Reset Service
class PasswordResetService {
  Future<bool> sendResetLink(String email) async {
    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    // Validate email (simple validation)
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
      throw Exception('Please enter a valid email address');
    }

    return true;
  }
}
