import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sparsh/core/constants/theme.dart';
import 'package:sparsh/features/Login/repository/pass_reset.dart';

final passwordResetServiceProvider = Provider<PasswordResetService>(
  (ref) => PasswordResetService(),
);

class ForgotPasswordScreen extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  ConsumerState<ForgotPasswordScreen> createState() =>
      _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen> {
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> sendResetLink() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    ref.read(errorMessageProvider.notifier).state = null;
    ref.read(isLoadingProvider.notifier).state = true;

    try {
      final passwordResetService = ref.read(passwordResetServiceProvider);
      await passwordResetService.sendResetLink(_emailController.text);

      ref.read(emailProvider.notifier).state = _emailController.text;
      ref.read(isResetLinkSentProvider.notifier).state = true;
    } catch (e) {
      ref.read(errorMessageProvider.notifier).state = e.toString();
    } finally {
      ref.read(isLoadingProvider.notifier).state = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(isLoadingProvider);
    final errorMessage = ref.watch(errorMessageProvider);
    final isResetLinkSent = ref.watch(isResetLinkSentProvider);
    AppTheme apptheme = AppTheme();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: GestureDetector(
        onHorizontalDragEnd: (details) {
          if (details.primaryVelocity! > 0) {
            Navigator.of(context).pop();
          }
        },
        child: Stack(
          children: [
            // Background image with factory/industrial buildings
            // Container(
            //   decoration: const BoxDecoration(
            //     image: DecorationImage(
            //       image: AssetImage('assets/images/industrial_background.jpg'),
            //       fit: BoxFit.cover,
            //     ),
            //   ),
            // ),

            // Content
            SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Forgot Password Card
                          Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 10,
                                  spreadRadius: 5,
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (!isResetLinkSent) ...[
                                  const Text(
                                    'Please enter your registered email address. We will send you a link to reset your password.',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),

                                  const SizedBox(height: 24),

                                  const Text(
                                    'Email Address',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                    ),
                                  ),

                                  const SizedBox(height: 8),

                                  // Email input
                                  TextFormField(
                                    controller: _emailController,
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: InputDecoration(
                                      hintText: 'Enter your email address',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                            horizontal: 12,
                                            vertical: 16,
                                          ),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your email address';
                                      }
                                      if (!RegExp(
                                        r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                                      ).hasMatch(value)) {
                                        return 'Please enter a valid email address';
                                      }
                                      return null;
                                    },
                                  ),
                                ] else ...[
                                  Icon(
                                    Icons.check_circle,
                                    size: 60,
                                    color: Colors.green.shade600,
                                  ),

                                  const SizedBox(height: 16),

                                  const Text(
                                    'Password Reset Link Sent',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Colors.black87,
                                    ),
                                  ),

                                  const SizedBox(height: 16),

                                  Text(
                                    'A password reset link has been sent to:',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey.shade600,
                                    ),
                                  ),

                                  const SizedBox(height: 8),

                                  Text(
                                    ref.watch(emailProvider),
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                      color: apptheme.primaryColor,
                                    ),
                                  ),

                                  const SizedBox(height: 16),

                                  Text(
                                    'Please check your email and follow the link to reset your password. If you don\'t receive an email within a few minutes, please check your spam folder.',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                ],

                                if (errorMessage != null &&
                                    !isResetLinkSent) ...[
                                  const SizedBox(height: 16),
                                  Text(
                                    errorMessage,
                                    style: const TextStyle(
                                      color: Colors.red,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],

                                const SizedBox(height: 24),

                                // Action Button
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed:
                                        isLoading || isResetLinkSent
                                            ? null
                                            : sendResetLink,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: apptheme.primaryColor,
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 16,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    child:
                                        isLoading
                                            ? const SizedBox(
                                              height: 20,
                                              width: 20,
                                              child: CircularProgressIndicator(
                                                strokeWidth: 2,
                                                color: Colors.white,
                                              ),
                                            )
                                            : Text(
                                              isResetLinkSent
                                                  ? 'Back to Login'
                                                  : 'Reset Password',
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                              ),
                                            ),
                                  ),
                                ),

                                if (isResetLinkSent) ...[
                                  const SizedBox(height: 16),

                                  SizedBox(
                                    width: double.infinity,
                                    child: OutlinedButton(
                                      onPressed: () {
                                        ref
                                            .read(
                                              isResetLinkSentProvider.notifier,
                                            )
                                            .state = false;
                                      },
                                      style: OutlinedButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 16,
                                        ),
                                        side: BorderSide(
                                          color: apptheme.primaryColor,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                      ),
                                      child: Text(
                                        'Resend Link',
                                        style: TextStyle(
                                          color: apptheme.primaryColor,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
