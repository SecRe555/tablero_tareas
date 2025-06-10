import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tablero_tareas/constants/theme.dart';

class ThemeController extends GetxController with WidgetsBindingObserver {
  var mode = ThemeMode.system.obs;

  Rx<Color> primaryColor = Colors.teal.obs;
  Rx<Color> backgroundColor = Colors.white.obs;

  final brightness = Brightness.light.obs;

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
    _updateBrightness();
  }

  ThemeData get lightTheme => ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryColor.value,
      brightness: Brightness.light,
    ),
  );

  ThemeData get darkTheme => ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryColor.value,
      brightness: Brightness.dark,
    ),
  );

  ThemeMode get themeMode => mode.value;

  void setThemeMode(ThemeMode newMode) {
    mode.value = newMode;
    _updateBrightness();
  }

  void setPrimaryColor(Color color) {
    primaryColor.value = color;
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

  bool get isDark => brightness.value == Brightness.dark;
  bool get isLight => brightness.value == Brightness.light;

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
