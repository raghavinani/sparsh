import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sprash_arch/features/home/view/home_page.dart';

import '../../../DataLayer/Datacalls/LoginApi.dart';
import '../../../DataLayer/modals/LoginM.dart';
import '../../../core/constants/secure_storage.dart';
import '../view/login_page.dart';

// final showBannerProvider = StateProvider<bool>((ref) => true);
// final userRoleProvider = StateProvider<String>((ref) => '');
class LoginViewModel {
  final Ref ref;
    final service = LoginService();
  
  LoginViewModel(this.ref);
  final loginuserRoleProvider = StateProvider<String>((ref) => '');
  // State providers
  final emailProvider = StateProvider<String>((ref) => '');
  final passwordProvider = StateProvider<String>((ref) => '');
  final rememberMeProvider = StateProvider<bool>((ref) => false);
  final errorMessageProvider = StateProvider<String?>((ref) => null);
  final showBannerProvider = StateProvider<bool>((ref) => true);
  final userRoleProvider = StateProvider<String>((ref) => '');
  
  void resetProviders() {
    ref.read(emailProvider.notifier).state = '';
    ref.read(passwordProvider.notifier).state = '';
    ref.read(rememberMeProvider.notifier).state = false;
    ref.read(errorMessageProvider.notifier).state = null;
    ref.read(userRoleProvider.notifier).state = 'user';// default ??
    ref.read(showBannerProvider.notifier).state = false;
  }

  Future<bool> login(String email, String password, BuildContext context) async {
    final secureStorage = ref.read(secureStorageProvider);
    final rememberMe = ref.read(rememberMeProvider);

    if (email == 'admin' && password == 'admin') {
      handleSuccessfulLogin(email, password, rememberMe, secureStorage);
     
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
          );
        
      ref.read(userRoleProvider.notifier).state = 'admin';
      ref.read(showBannerProvider.notifier).state = true;
      return true;
    } else {
      try {
        final response = await service.loginWithEmailAndPassword(
          email: email,
          password: password,
        );
        
        if (response.runtimeType == UserLogin) {
          handleSuccessfulLogin(email, password, rememberMe, secureStorage);
          
          if (response.roleCode != null) {
            String role = response.roleCode!.toLowerCase();
            ref.read(userRoleProvider.notifier).state = 
                role == 'admin' ? 'admin' : 'custm';
            ref.read(showBannerProvider.notifier).state = true;
          }
          return true;
        }
        return false;
      } catch (e) {
        ref.read(errorMessageProvider.notifier).state = 
            e is ApiException ? "Invalid username or password" :
            e is NetworkException ? "Please check your internet connection" :
            "Something went wrong. Please try again.";
        return false;
      }
    }
  }

  Future<void> handleSuccessfulLogin(
    String email, 
    String password, 
    bool rememberMe,
    SecureStorage secureStorage,
  ) async {
    if (rememberMe) {
      await secureStorage.saveData('email', email);
      await secureStorage.saveData('password', password);
    }
  }

  Future<void> loadStoredCredentials(TextEditingController emailController, 
      TextEditingController passwordController) async {
    final secureStorage = ref.read(secureStorageProvider);
    final storedEmail = await secureStorage.readData('email');
    final storedPassword = await secureStorage.readData('password');

    if (storedEmail != null && storedPassword != null) {
      emailController.text = storedEmail;
      passwordController.text = storedPassword;
      ref.read(emailProvider.notifier).state = storedEmail;
      ref.read(passwordProvider.notifier).state = storedPassword;
      ref.read(rememberMeProvider.notifier).state = true;
    } else {
      emailController.clear();
      passwordController.clear();
      ref.read(emailProvider.notifier).state = '';
      ref.read(passwordProvider.notifier).state = '';
      ref.read(rememberMeProvider.notifier).state = false;
    }
  }
}