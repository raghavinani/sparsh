import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sparsh/features/home/view/home_page.dart';

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
  // State providers
  final StateProvider<String> loginuserRoleProvider = StateProvider<String>(
    (ref) => '',
  );
  final idProvider = StateProvider<String>((ref) => '');
  final passwordProvider = StateProvider<String>((ref) => '');
  final rememberMeProvider = StateProvider<bool>((ref) => false);
  final errorMessageProvider = StateProvider<String?>((ref) => null);
  final showBannerProvider = StateProvider<bool>((ref) => true);
  final userRoleProvider = StateProvider<String>((ref) => '');

  void resetProviders() {
    ref.read(idProvider.notifier).state = '';
    ref.read(passwordProvider.notifier).state = '';
    ref.read(rememberMeProvider.notifier).state = false;
    ref.read(errorMessageProvider.notifier).state = null;
    ref.read(userRoleProvider.notifier).state = 'user'; // default ??
    ref.read(showBannerProvider.notifier).state = false;
  }

  Future<bool> login(String id, String password, BuildContext context) async {
    final secureStorage = ref.read(secureStorageProvider);
    final rememberMe = ref.read(rememberMeProvider);

    if (id == 'admin' && password == 'admin' ||
        id == 'custm' && password == 'custm') {
      handleSuccessfulLogin(id, password, rememberMe, secureStorage);

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );

      ref.read(userRoleProvider.notifier).state = id;
      ref.read(showBannerProvider.notifier).state = true;
      return true;
    } else {
      try {
        final response = await service.loginWithUserIdAndPassword(
          userId: id,
          password: password,
        );

        if (response.isNotEmpty) {
          handleSuccessfulLogin(id, password, rememberMe, secureStorage);

          if (response["roles"] != null) {
            String role = response["roles"].toString().toLowerCase();
            ref.read(userRoleProvider.notifier).state =
                role == 'admin' ? 'admin' : 'custm';
            ref.read(showBannerProvider.notifier).state = true;
          }
        }
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
        return true;
      } catch (e) {
        ref.read(errorMessageProvider.notifier).state =
            e is ApiException
                ? "Invalid username or password"
                : e is NetworkException
                ? "Please check your internet connection"
                : "Something went wrong. Please try again.";
        return false;
      }
    }
  }

  Future<void> handleSuccessfulLogin(
    String id,
    String password,
    bool rememberMe,
    SecureStorage secureStorage,
  ) async {
    if (rememberMe) {
      await secureStorage.saveData('id', id);
      await secureStorage.saveData('password', password);
    }
  }

  Future<void> loadStoredCredentials(
    TextEditingController idController,
    TextEditingController passwordController,
  ) async {
    final secureStorage = ref.read(secureStorageProvider);
    final storedid = await secureStorage.readData('id');
    final storedPassword = await secureStorage.readData('password');

    if (storedid != null && storedPassword != null) {
      idController.text = storedid;
      passwordController.text = storedPassword;
      ref.read(idProvider.notifier).state = storedid;
      ref.read(passwordProvider.notifier).state = storedPassword;
      ref.read(rememberMeProvider.notifier).state = true;
    } else {
      idController.clear();
      passwordController.clear();
      ref.read(idProvider.notifier).state = '';
      ref.read(passwordProvider.notifier).state = '';
      ref.read(rememberMeProvider.notifier).state = false;
    }
  }
}
