import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sprash_arch/DataLayer/Datacalls/LoginApi.dart';
import 'package:sprash_arch/core/constants/secure_storage.dart';
import 'package:sprash_arch/core/constants/theme.dart';
import 'package:sprash_arch/features/auth/view/forgetpass.dart';
import 'package:sprash_arch/features/auth/viewModal/login_viewmodal.dart';
import 'package:sprash_arch/features/auth/widgets/custom_text_field.dart';

import '../widgets/footer.dart';
import 'login_otp.dart';



// Secure storage provider
final secureStorageProvider = Provider<SecureStorage>((ref) => SecureStorage());


class MyLogin extends ConsumerStatefulWidget {
  const MyLogin({super.key});

  @override
  ConsumerState<MyLogin> createState() => _MyLoginState();
}

class _MyLoginState extends ConsumerState<MyLogin>
    with TickerProviderStateMixin {
  late AnimationController _animationController;

  final service = LoginService();
final loginViewModelProvider = Provider((ref) => LoginViewModel(ref));

  late Animation<Offset> _animation2;

  final TextEditingController _idController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(loginViewModelProvider).loadStoredCredentials(
            _idController,
            _passwordController,
          );
    });
  }

  void _setupAnimations() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    );
    _animation2 = Tween<Offset>(
      begin: const Offset(0, -2),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    _animationController.forward();
  }
  // In _MyLoginState class, modify _loadStoredCredentials:

  
  @override
  void dispose() {
    _animationController.dispose();
    _idController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.watch(loginViewModelProvider);
    final errorMessage = ref.watch(viewModel.errorMessageProvider);
    final rememberMe = ref.watch(viewModel.rememberMeProvider);
    // final id = ref.watch(viewModel.idProvider);
    // final password = ref.watch(viewModel.passwordProvider);
 

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onHorizontalDragEnd: (details) {
          if (details.primaryVelocity! > 0) {
            Navigator.of(context).pop();
          }
        },
        child: Stack(
          children: [
            // Background Image (Fixed)
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/firstScreen.png"),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            // Content Layout
            Column(
              children: [
                // Welcome Text Section (30% of screen)
                Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: SafeArea(
                    child: SlideTransition(
                      position: _animation2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Welcome Back',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Center(
                            child: Text(
                              'SPARSH',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 42,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                // White Container Section (70% of screen)
                Container(
                  height: MediaQuery.of(context).size.height * 0.7,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    children: [
                      // Main Content
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 20,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Log In',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 20),
                              if (errorMessage != null)
                                Text(
                                  errorMessage,
                                  style: const TextStyle(color: Colors.red),
                                ),
                              const SizedBox(height: 10),
                              customTextField(
                                controller: _idController,
                                hintText: "Username",
                                onChanged: (value) => ref.read(viewModel.idProvider.notifier).state = value,
                              ),
                              const SizedBox(height: 15),
                              customTextField(
                                controller: _passwordController,
                                hintText: "Password",
                                obscureText: true,
                                onChanged: (value) => ref.read(viewModel.passwordProvider.notifier).state = value,
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Checkbox(
                                    value: rememberMe,
                                    onChanged: (value) {
                                      ref.read(viewModel.rememberMeProvider.notifier)
                                          .state = value ?? false;
                                    },
                                  ),
                                  const Text(
                                    "Remember Me",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  Spacer(),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder:
                                              (context) =>
                                                  const ForgotPasswordScreen(),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      "Forgot Password?",
                                      style: TextStyle(
                                        color: AppTheme().primaryColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppTheme().primaryColor,
                                  shape: const StadiumBorder(),
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 12,
                                    horizontal: 50,
                                  ),
                                ),
                                onPressed: () => viewModel.login(_idController.text, _passwordController.text, context),
                                child: const Text(
                                  "Log In",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (context) => const LoginWithOtp(),
                                    ),
                                  );
                                },
                                child: Text(
                                  "Log in With OTP",
                                  style: TextStyle(
                                    color: AppTheme().primaryColor,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Footer
                      Container(
                        padding: EdgeInsets.only(bottom: 20),
                        child: Footer(
                          text: "Developed By Birla White IT",
                          backgroundColor: Colors.white,
                          textStyle: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
