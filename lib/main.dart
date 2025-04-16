import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sprash_arch/features/auth/view/splash_screen.dart';
import 'package:sprash_arch/features/bottombar/try.dart';
import 'package:sprash_arch/features/home/view/home_page.dart';

import 'core/constants/secure_storage.dart';
import 'core/constants/theme.dart' as sparsh;
import 'features/auth/view/login_page.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // DioClient();
  // Preload the font
  await GoogleFonts.pendingFonts([GoogleFonts.poppins()]);
  runApp(const ProviderScope(child: SparshApp()));
}

class SparshApp extends ConsumerStatefulWidget {
  const SparshApp({super.key});

  @override
  ConsumerState<SparshApp> createState() => _SparshAppState();
}

class _SparshAppState extends ConsumerState<SparshApp> {
  Widget? _initialPage;
  final SecureStorage _secureStorage = SecureStorage();

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    final storedEmail = await _secureStorage.readData('email');
    final storedPassword = await _secureStorage.readData('password');

    if (mounted) {
      setState(() {
        // If logged in, go to ContentPage, otherwise go to MyLogin
        _initialPage =
            (storedEmail != null && storedPassword != null)
                ?  SplashScreen()
                : const MyLogin();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = ref.watch(sparsh.themeProvider);
    final themeMode = ref.watch(sparsh.themeModeProvider);

    // Set theme based on theme mode
    final currentTheme =
        (themeMode == ThemeMode.dark)
            ? ref.read(sparsh.darkThemeProvider)
            : appTheme;

    return MaterialApp(
      title: 'SPARSH',
      debugShowCheckedModeBanner: false,
      theme: currentTheme.toThemeData(),
      home: MyLogin(),
    );
  }
}

/// ResponsiveWrapper to handle different screen sizes
class ResponsiveWrapper extends StatelessWidget {
  final Widget child;

  const ResponsiveWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      // Override text scaling to ensure consistent text size
      data: MediaQuery.of(context).copyWith(textScaler: TextScaler.linear(1.0)),
      child: Container(child: child),
    );
  }
}