import 'package:flutter/material.dart';

import '../../../core/constants/theme.dart';
import '../widgets/footer.dart';
import 'login_page.dart';

class LoginWithOtp extends StatefulWidget {
  const LoginWithOtp({super.key});

  @override
  _LoginWithOtpState createState() => _LoginWithOtpState();
}

class _LoginWithOtpState extends State<LoginWithOtp>
    with SingleTickerProviderStateMixin {
  TextEditingController mobileController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  // final service = LoginService();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppTheme apptheme = AppTheme();

    return GestureDetector(
      onHorizontalDragEnd: (details) {
        if (details.primaryVelocity! > 0) {
          Navigator.of(context).pop();
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            Positioned.fill(
              child: Image.asset("assets/firstScreen.png", fit: BoxFit.fill),
            ),
            Column(
              children: [
                // Welcome Text Section (30% of screen)
                Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),
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
                // White Container Section (70% of screen)
                Container(
                  height: MediaQuery.of(context).size.height * 0.7,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(10),
                              child: Text(
                                'Log In Mobile No.',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            TextField(
                              controller: mobileController,
                              keyboardType: TextInputType.phone,
                              style: const TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                fillColor: Colors.grey.shade100,
                                filled: true,
                                hintText: "Enter no",
                                hintStyle: TextStyle(
                                  color: apptheme.primaryColor,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            TextField(
                              controller: otpController,
                              keyboardType: TextInputType.number,
                              style: const TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                fillColor: Colors.grey.shade100,
                                filled: true,
                                hintText: "Enter OTP",
                                hintStyle: TextStyle(
                                  color: apptheme.primaryColor,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () {},
                                child: Text(
                                  "Resend OTP",
                                  style: TextStyle(
                                    color: apptheme.primaryColor,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 30),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: apptheme.primaryColor,
                                shape: const StadiumBorder(),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                  horizontal: 50,
                                ),
                              ),
                              onPressed: () {},
                              child: const Text(
                                "Verify Now",
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
                                    builder: (context) => MyLogin(),
                                  ),
                                );
                              },
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                              ),
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.arrow_back,
                                    color: Colors.black,
                                    size: 18,
                                  ),
                                  Text(
                                    "Go back",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                      Footer(
                        text: "Developed By Birla White IT",
                        backgroundColor: Colors.white,
                        textStyle: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
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
