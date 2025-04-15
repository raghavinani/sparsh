import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginBanner extends StatefulWidget {
  const LoginBanner({super.key});

  @override
  _LoginBannerState createState() => _LoginBannerState();
}

class _LoginBannerState extends State<LoginBanner> {
  bool showBanner = false;

  @override
  void initState() {
    super.initState();
    Future.microtask(() => checkFirstLogin());
  }

  Future<void> checkFirstLogin() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final bool hasSeenBanner = prefs.getBool('hasSeenBanner') ?? false;

      if (!hasSeenBanner) {
        setState(() => showBanner = true);

        // Hide the banner after 5 seconds
        Future.delayed(const Duration(seconds: 5), () {
          if (mounted) {
            setState(() => showBanner = false);
          }
        });

        // Mark banner as seen
        await prefs.setBool('hasSeenBanner', true);
      }
    } catch (e) {
      debugPrint("SharedPreferences Error: $e");
    }
  }

  void closeBanner() {
    setState(() => showBanner = false);
  }

  @override
  Widget build(BuildContext context) {
    if (!showBanner) return const SizedBox.shrink();

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        // Blurred Background
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(color: Colors.black26),
          ),
        ),

        // Centered Banner
        Center(
          child: Stack(
            children: [
              Container(
                width: screenWidth * 0.8,
                height: screenHeight * 0.6,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: const DecorationImage(
                    image: AssetImage('assets/carousel/index_1.jpg'),
                    fit: BoxFit.fill,
                  ),
                ),
              ),

              // Close Button
              Positioned(
                top: 4,
                right: 4,
                child: GestureDetector(
                  onTap: closeBanner,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      border: Border.all(color: Colors.black, width: 2),
                    ),
                    child: const Icon(
                      Icons.close,
                      color: Colors.black,
                      size: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
