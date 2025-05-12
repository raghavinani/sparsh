import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginBanner extends StatefulWidget {
  final void Function(bool) onVisibilityChanged;
  const LoginBanner({super.key, required this.onVisibilityChanged});

  @override
  _LoginBannerState createState() => _LoginBannerState();
}

class _LoginBannerState extends State<LoginBanner> {
  bool showImageBanner = false;
  bool showFormBanner = false;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController departmentController = TextEditingController();
  final TextEditingController locationController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() => checkFirstLogin());
  }

  Future<void> checkFirstLogin() async {
    final prefs = await SharedPreferences.getInstance();
    final bool hasSeenBanner = prefs.getBool('hasSeenBanner') ?? false;
    final bool hasSeenFormBanner = prefs.getBool('hasSeenFormBanner') ?? false;

    if (!hasSeenBanner) {
      setState(() => showImageBanner = true);
      widget.onVisibilityChanged(true);

      Future.delayed(const Duration(seconds: 5), () {
        if (mounted) {
          setState(() => showImageBanner = false);
          widget.onVisibilityChanged(false);
          _showFormBanner();
        }
      });

      await prefs.setBool('hasSeenBanner', true);
    } else if (!hasSeenFormBanner) {
      _showFormBanner();
    }
  }

  void _showFormBanner() {
    setState(() => showFormBanner = true);
    widget.onVisibilityChanged(true);
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('hasSeenFormBanner', true);
      setState(() => showFormBanner = false);
      widget.onVisibilityChanged(false);
    }
  }

  void _closeImageBannerEarly() {
    setState(() => showImageBanner = false);
    _showFormBanner();
  }

  @override
  Widget build(BuildContext context) {
    if (!showImageBanner && !showFormBanner) return const SizedBox.shrink();

    return Stack(
      children: [
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(color: Colors.black26),
          ),
        ),

        // 🖼️ Image Banner
        if (showImageBanner)
          Center(
            child: Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height * 0.6,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: const DecorationImage(
                      image: AssetImage('assets/carousel/index_1.jpg'),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Positioned(
                  top: 4,
                  right: 4,
                  child: GestureDetector(
                    onTap: _closeImageBannerEarly,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        border: Border.all(color: Colors.black, width: 2),
                      ),
                      child: const Icon(
                        Icons.close,
                        size: 16,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

        // 📝 Form Banner
        if (showFormBanner)
          Center(
            child: Container(
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              width: MediaQuery.of(context).size.width * 0.85,
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Welcome! Please complete this form.",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: departmentController,
                      decoration: const InputDecoration(
                        labelText: 'Department',
                      ),
                      validator:
                          (value) =>
                              value == null || value.isEmpty
                                  ? 'Required'
                                  : null,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: locationController,
                      decoration: const InputDecoration(labelText: 'Location'),
                      validator:
                          (value) =>
                              value == null || value.isEmpty
                                  ? 'Required'
                                  : null,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _submitForm,
                      child: const Text("Submit"),
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}
