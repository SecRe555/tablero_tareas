import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeController extends GetxController with WidgetsBindingObserver {
  final Rx<ThemeMode> themeMode = ThemeMode.system.obs;
  final Rx<Color> primaryColor = Colors.blue.obs;

  Brightness get platformBrightness =>
      WidgetsBinding.instance.window.platformBrightness;

  ThemeData get lightTheme => _buildTheme(Brightness.light);
  ThemeData get darkTheme => _buildTheme(Brightness.dark);

  ThemeData get effectiveTheme =>
      themeMode.value == ThemeMode.dark
          ? darkTheme
          : themeMode.value == ThemeMode.light
          ? lightTheme
          : (platformBrightness == Brightness.dark ? darkTheme : lightTheme);

  ThemeMode get effectiveThemeMode =>
      themeMode.value == ThemeMode.system
          ? (platformBrightness == Brightness.dark
              ? ThemeMode.dark
              : ThemeMode.light)
          : themeMode.value;

  @override
  void onInit() {
    WidgetsBinding.instance.addObserver(this);
    super.onInit();
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    super.onClose();
  }

  @override
  void didChangePlatformBrightness() {
    if (themeMode.value == ThemeMode.system) {
      update(); // Actualiza el tema cuando cambia el modo del sistema
    }
  }

  ThemeData _buildTheme(Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    final bgColor = isDark ? const Color(0xFF222222) : Colors.white;

    final lightTheme = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.light(
        primary: primaryColor.value,
        surface: bgColor,
      ),
      fontFamily:
          GoogleFonts.raleway(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ).fontFamily,
      appBarTheme: AppBarTheme(
        backgroundColor: primaryColor.value,
        elevation: 7.0,
        actionsPadding: EdgeInsets.symmetric(horizontal: 20.0),
        titleTextStyle: GoogleFonts.raleway(color: bgColor, fontSize: 24.0),
        iconTheme: IconThemeData(color: bgColor),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor.value,
          foregroundColor: bgColor,
          textStyle: GoogleFonts.raleway(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: const EdgeInsets.symmetric(
          vertical: -5,
          horizontal: 25,
        ),
        filled: true,
        fillColor: const Color(0xFFF0F0F0),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: primaryColor.value),
          borderRadius: const BorderRadius.all(Radius.circular(35)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: primaryColor.value),
          borderRadius: const BorderRadius.all(Radius.circular(35)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: primaryColor.value),
          borderRadius: const BorderRadius.all(Radius.circular(35)),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
          borderRadius: BorderRadius.all(Radius.circular(35)),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        errorStyle: const TextStyle(color: Colors.red),
      ),
    );

    final darkTheme = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.dark(
        primary: primaryColor.value,
        surface: bgColor,
      ),
      fontFamily:
          GoogleFonts.raleway(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ).fontFamily,
      appBarTheme: AppBarTheme(
        backgroundColor: primaryColor.value,
        elevation: 7.0,
        actionsPadding: EdgeInsets.symmetric(horizontal: 20.0),
        titleTextStyle: GoogleFonts.raleway(color: bgColor, fontSize: 24.0),
        iconTheme: IconThemeData(color: bgColor),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor.value,
          foregroundColor: bgColor,
          textStyle: GoogleFonts.raleway(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: const EdgeInsets.symmetric(
          vertical: -5,
          horizontal: 25,
        ),
        filled: true,
        fillColor: const Color(0xFF333333),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: primaryColor.value),
          borderRadius: const BorderRadius.all(Radius.circular(35)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: primaryColor.value),
          borderRadius: const BorderRadius.all(Radius.circular(35)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: primaryColor.value),
          borderRadius: const BorderRadius.all(Radius.circular(35)),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
          borderRadius: BorderRadius.all(Radius.circular(35)),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        errorStyle: const TextStyle(color: Colors.red),
      ),
    );

    return isDark ? darkTheme : lightTheme;
  }

  void updatePrimaryColor(Color color) {
    primaryColor.value = color;
    update(); // Recalcular temas
  }

  void updateThemeMode(ThemeMode mode) {
    themeMode.value = mode;
    update();
  }
}
