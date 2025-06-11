import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tablero_tareas/constants/theme.dart';

class ThemeController extends GetxController with WidgetsBindingObserver {
  var mode = ThemeMode.dark.obs;
  Rx<CustomColor> primaryColor = CustomColor.blue.obs;

  final _lightBackgroundColor = Colors.white;
  final _darkBackgroundColor = const Color(0xFF222222);

  final brightness = Brightness.light.obs;

  // Aquí guardamos los temas ya generados
  final Rx<ThemeData> lightTheme = ThemeData().obs;
  final Rx<ThemeData> darkTheme = ThemeData().obs;

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
    _updateBrightness();
    _generateThemes(); // Generamos los temas al arrancar

    // Escuchamos los cambios de color para regenerar temas si cambia el primary
    ever(primaryColor, (_) => _generateThemes());
  }

  // Getters que usa tu MaterialApp
  ThemeMode get themeMode => mode.value;
  bool get isDark => brightness.value == Brightness.dark;
  bool get isLight => brightness.value == Brightness.light;

  void setThemeMode(ThemeMode newMode) {
    mode.value = newMode;
    _updateBrightness();
  }

  void setPrimaryColor(CustomColor color) {
    primaryColor.value = color;
  }

  // Este método crea los temas con el color actualizado
  void _generateThemes() {
    final Color _primaryColor = Color(getMain(primaryColor.value));

    final baseFont = GoogleFonts.raleway(
      fontSize: 18,
      fontWeight: FontWeight.w500,
    );

    lightTheme.value = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.light(
        primary: _primaryColor,
        surface: _lightBackgroundColor,
      ),
      fontFamily: baseFont.fontFamily,
      appBarTheme: AppBarTheme(
        backgroundColor: _primaryColor,
        elevation: 7.0,
        actionsPadding: EdgeInsets.symmetric(horizontal: 20.0),
        titleTextStyle: baseFont.copyWith(
          color: _lightBackgroundColor,
          fontSize: 24.0,
        ),
        iconTheme: IconThemeData(color: _lightBackgroundColor),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: _primaryColor,
          foregroundColor: _lightBackgroundColor,
          textStyle: baseFont,
        ),
      ),
      inputDecorationTheme: _inputTheme(
        primary: _primaryColor,
        fill: const Color(0xFFF0F0F0),
      ),
    );

    darkTheme.value = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.dark(
        primary: _primaryColor,
        surface: _darkBackgroundColor,
      ),
      fontFamily: baseFont.fontFamily,
      appBarTheme: AppBarTheme(
        backgroundColor: _primaryColor,
        elevation: 7.0,
        actionsPadding: EdgeInsets.symmetric(horizontal: 20.0),
        titleTextStyle: baseFont.copyWith(
          color: _darkBackgroundColor,
          fontSize: 24.0,
        ),
        iconTheme: IconThemeData(color: _darkBackgroundColor),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: _primaryColor,
          foregroundColor: _darkBackgroundColor,
          textStyle: baseFont,
        ),
      ),
      inputDecorationTheme: _inputTheme(
        primary: _primaryColor,
        fill: const Color(0xFF333333),
      ),
    );
  }

  // Tema base para los inputs, reusado para light y dark
  InputDecorationTheme _inputTheme({
    required Color primary,
    required Color fill,
  }) {
    return InputDecorationTheme(
      contentPadding: const EdgeInsets.symmetric(vertical: -5, horizontal: 25),
      filled: true,
      fillColor: fill,
      border: OutlineInputBorder(
        borderSide: BorderSide(color: primary),
        borderRadius: const BorderRadius.all(Radius.circular(35)),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: primary),
        borderRadius: const BorderRadius.all(Radius.circular(35)),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: primary),
        borderRadius: const BorderRadius.all(Radius.circular(35)),
      ),
      errorBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red),
        borderRadius: BorderRadius.all(Radius.circular(35)),
      ),
      floatingLabelBehavior: FloatingLabelBehavior.auto,
      errorStyle: const TextStyle(color: Colors.red),
    );
  }

  void _updateBrightness() {
    switch (mode.value) {
      case ThemeMode.light:
        brightness.value = Brightness.light;
        break;
      case ThemeMode.dark:
        brightness.value = Brightness.dark;
        break;
      case ThemeMode.system:
        brightness.value = WidgetsBinding.instance.window.platformBrightness;
        break;
    }
  }

  @override
  void didChangePlatformBrightness() {
    if (mode.value == ThemeMode.system) {
      _updateBrightness();
    }
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    super.onClose();
  }

  ColorShades getColor(CustomColor color) {
    return getShades(color, brightness.value);
  }

  int getMain(CustomColor color) => getColor(color).main;
  int getLight(CustomColor color) => getColor(color).light;
  int getDark(CustomColor color) => getColor(color).dark;

  Color getColorValue(CustomColor color) => Color(getMain(color));
}
