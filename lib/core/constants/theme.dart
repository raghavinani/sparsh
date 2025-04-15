import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

/// FontSizes class to maintain consistent font sizes across the app
class FontSizes {
  final double xsmall;
  final double small;
  final double medium;
  final double large;
  final double xlarge;
  final double xxlarge;

  const FontSizes({
    this.xsmall = 12,
    this.small = 14,
    this.medium = 16,
    this.large = 18,
    this.xlarge = 22,
    this.xxlarge = 28,
  });
}

/// Spacing class to maintain consistent spacing across the app
class Spacing {
  final double xsmall;
  final double small;
  final double medium;
  final double large;
  final double xlarge;

  const Spacing({
    this.xsmall = 4,
    this.small = 8,
    this.medium = 12,
    this.large = 16,
    this.xlarge = 20,
  });
}

class BordRadius {
  final double small;
  final double medium;
  final double large;
  const BordRadius({this.small = 5, this.medium = 10, this.large = 15});
}

/// AppTheme class to hold all theme-related properties
class AppTheme {
  // Primary colors
  final Color primaryColor;
  final Color primaryLightColor;
  final Color primaryDarkColor;
  final Color onPrimaryColor;

  // Background colors
  final Color backgroundColor;
  final Color surfaceColor;
  final Color cardColor;

  // Text colors
  final Color textColor;
  final Color textSecondaryColor;
  final Color textDisabledColor;

  // Status colors
  final Color successColor;
  final Color warningColor;
  final Color errorColor;
  final Color infoColor;
  final Color neutralColor;

  // Font sizes
  final FontSizes fontSizes;

  // Spacing
  final Spacing spacing;

  // Border radius
  final double borderRadius;
  final double cardBorderRadius;
  final double buttonBorderRadius;
  final double inputBorderRadius;

  // Elevations

  // Font family
  final String? fontFamily;

  final BordRadius radius;

  final dynamic margin;

  const AppTheme({
    // Default primary blue color as shown in the example
    this.primaryColor = const Color(0xFF0277BD),
    this.primaryLightColor = const Color(0xFF009DFF),
    this.primaryDarkColor = const Color(0xFF004c8c),
    this.onPrimaryColor = Colors.white,

    // Background colors
    this.backgroundColor = const Color(0xFFF5F5F5),
    this.surfaceColor = Colors.white,
    this.cardColor = Colors.white,

    // Text colors
    this.textColor = const Color(0xFF212121),
    this.textSecondaryColor = const Color(0xFF757575),
    this.textDisabledColor = const Color(0xFFBDBDBD),

    // Status colors
    this.successColor = const Color(0xFF4CAF50),
    this.warningColor = const Color(0xFFFFC107),
    this.errorColor = const Color(0xFFF44336),
    this.infoColor = const Color(0xFF2196F3),
    this.neutralColor = const Color(0xFF9E9E9E),

    // Font sizes
    this.fontSizes = const FontSizes(),

    // Spacing
    this.spacing = const Spacing(),

    // Border radius
    this.borderRadius = 8.0,
    this.cardBorderRadius = 8.0,
    this.buttonBorderRadius = 8.0,
    this.inputBorderRadius = 8.0,

    // Font family
    this.fontFamily = 'Poppins',

    //margins
    this.margin = const EdgeInsets.symmetric(horizontal: 8.0),

    // Radius
    this.radius = const BordRadius(),
  });

  // Method to create a copy of the current theme with some properties changed
  AppTheme copyWith({
    Color? primaryColor,
    Color? primaryLightColor,
    Color? primaryDarkColor,
    Color? onPrimaryColor,
    Color? secondaryColor,
    Color? secondaryLightColor,
    Color? secondaryDarkColor,
    Color? onSecondaryColor,
    Color? backgroundColor,
    Color? surfaceColor,
    Color? cardColor,
    Color? textColor,
    Color? textSecondaryColor,
    Color? textDisabledColor,
    Color? successColor,
    Color? warningColor,
    Color? errorColor,
    Color? infoColor,
    Color? neutralColor,
    FontSizes? fontSizes,
    Spacing? spacing,
    double? borderRadius,
    double? cardBorderRadius,
    double? buttonBorderRadius,
    double? inputBorderRadius,
    double? cardElevation,
    double? buttonElevation,
    double? dialogElevation,
    String? fontFamily,
  }) {
    return AppTheme(
      primaryColor: primaryColor ?? this.primaryColor,
      primaryLightColor: primaryLightColor ?? this.primaryLightColor,
      primaryDarkColor: primaryDarkColor ?? this.primaryDarkColor,
      onPrimaryColor: onPrimaryColor ?? this.onPrimaryColor,

      backgroundColor: backgroundColor ?? this.backgroundColor,
      surfaceColor: surfaceColor ?? this.surfaceColor,
      cardColor: cardColor ?? this.cardColor,
      textColor: textColor ?? this.textColor,
      textSecondaryColor: textSecondaryColor ?? this.textSecondaryColor,
      textDisabledColor: textDisabledColor ?? this.textDisabledColor,
      successColor: successColor ?? this.successColor,
      warningColor: warningColor ?? this.warningColor,
      errorColor: errorColor ?? this.errorColor,
      infoColor: infoColor ?? this.infoColor,
      neutralColor: neutralColor ?? this.neutralColor,
      fontSizes: fontSizes ?? this.fontSizes,
      spacing: spacing ?? this.spacing,
      borderRadius: borderRadius ?? this.borderRadius,
      cardBorderRadius: cardBorderRadius ?? this.cardBorderRadius,
      buttonBorderRadius: buttonBorderRadius ?? this.buttonBorderRadius,
      inputBorderRadius: inputBorderRadius ?? this.inputBorderRadius,
      fontFamily: fontFamily ?? this.fontFamily,
    );
  }

  // Convert to ThemeData for Flutter MaterialApp
  ThemeData toThemeData() {
    return ThemeData(
      primaryColor: primaryColor,
      scaffoldBackgroundColor: backgroundColor,
      cardColor: cardColor,
      fontFamily: GoogleFonts.getFont(fontFamily!).fontFamily,
      colorScheme: ColorScheme(
        primary: primaryColor,
        primaryContainer: primaryDarkColor,
        secondary: primaryLightColor,
        surface: surfaceColor,
        error: errorColor,
        onPrimary: onPrimaryColor,
        onSecondary: primaryLightColor,
        onSurface: textColor,
        onError: Colors.white,
        brightness: Brightness.light,
      ),
      textTheme: TextTheme(
        displayLarge: TextStyle(fontSize: fontSizes.xxlarge, color: textColor),
        displayMedium: TextStyle(fontSize: fontSizes.xlarge, color: textColor),
        displaySmall: TextStyle(fontSize: fontSizes.large, color: textColor),
        headlineMedium: TextStyle(
          fontSize: fontSizes.large,
          color: textColor,
          fontWeight: FontWeight.bold,
        ),
        titleLarge: TextStyle(
          fontSize: fontSizes.medium,
          color: textColor,
          fontWeight: FontWeight.bold,
        ),
        bodyLarge: TextStyle(fontSize: fontSizes.medium, color: textColor),
        bodyMedium: TextStyle(fontSize: fontSizes.small, color: textColor),
        labelLarge: TextStyle(
          fontSize: fontSizes.small,
          color: textColor,
          fontWeight: FontWeight.bold,
        ),
      ),
      cardTheme: CardTheme(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(cardBorderRadius),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(buttonBorderRadius),
          ),
          backgroundColor: primaryColor,
          foregroundColor: onPrimaryColor,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(buttonBorderRadius),
          ),
          side: BorderSide(color: primaryColor),
          foregroundColor: primaryColor,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: primaryColor),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(inputBorderRadius),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(inputBorderRadius),
          borderSide: BorderSide(color: primaryColor, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(inputBorderRadius),
          borderSide: BorderSide(color: errorColor, width: 1),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: spacing.medium,
          vertical: spacing.medium,
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: primaryColor,
        foregroundColor: onPrimaryColor,
        elevation: 0,
      ),
    );
  }
}

// Theme provider to use with Riverpod
final themeProvider = StateProvider<AppTheme>((ref) {
  return const AppTheme();
});

// Theme modes (light, dark)
enum ThemeMode { light, dark }

// Theme mode provider
final themeModeProvider = StateProvider<ThemeMode>((ref) {
  return ThemeMode.light;
});

// Dark theme
final darkThemeProvider = Provider<AppTheme>((ref) {
  return const AppTheme(
    primaryColor: Color(0xFF0277BD),
    primaryLightColor: Color(0xFF58a5f0),
    primaryDarkColor: Color(0xFF004c8c),
    onPrimaryColor: Colors.white,
    backgroundColor: Color(0xFF121212),
    surfaceColor: Color(0xFF1E1E1E),
    cardColor: Color(0xFF2C2C2C),
    textColor: Colors.white,
    textSecondaryColor: Color(0xFFB0B0B0),
    textDisabledColor: Color(0xFF6E6E6E),
  );
});

// Method to apply responsive font size scaling
double getResponsiveFontSize(BuildContext context, double fontSize) {
  final width = MediaQuery.of(context).size.width;

  // Base width for which the font size is designed
  const double baseWidth = 375;

  // Scale factor to adjust font size based on screen width
  final double scaleFactor = width / baseWidth;

  // Apply scaling with constraints to avoid too large or too small fonts
  return fontSize *
      (scaleFactor > 1.2 ? 1.2 : (scaleFactor < 0.8 ? 0.8 : scaleFactor));
}

// Extension method for BuildContext to easily get app theme
extension ThemeExtension on BuildContext {
  AppTheme get appTheme => ProviderScope.containerOf(this).read(themeProvider);

  // Get responsive font size
  double responsiveFontSize(double fontSize) =>
      getResponsiveFontSize(this, fontSize);
}
