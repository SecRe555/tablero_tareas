import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tablero_tareas/states/theme_controller.dart';

enum CustomColor {
  red,
  orange,
  amber,
  yellow,
  lime,
  green,
  emerald,
  teal,
  cyan,
  sky,
  blue,
  indigo,
  violet,
  purple,
  fucshia,
  pink,
  rose,
  slate,
  gray,
  zinc,
  neutral,
  stone,
}

class ColorShades {
  final int light;
  final int main;
  final int dark;

  const ColorShades({
    required this.light,
    required this.main,
    required this.dark,
  });
}

class ColorTheme {
  final ColorShades light;
  final ColorShades dark;

  const ColorTheme({required this.light, required this.dark});
}

const Map<CustomColor, ColorTheme> _colorThemes = {
  CustomColor.red: ColorTheme(
    light: ColorShades(light: 0xFFfef2f2, main: 0xFFB91C1C, dark: 0xFF7F1D1D),
    dark: ColorShades(light: 0xFFFEE2E2, main: 0xFFFF6467, dark: 0xFFEF4444),
  ),
  CustomColor.orange: ColorTheme(
    light: ColorShades(light: 0xFFFB923C, main: 0xFFC2410C, dark: 0xFF7C2D12),
    dark: ColorShades(light: 0xFFFFEDD5, main: 0xFFFED7AA, dark: 0xFFFB923C),
  ),
  CustomColor.amber: ColorTheme(
    light: ColorShades(light: 0xFFFBBF24, main: 0xFFB45309, dark: 0xFF78350F),
    dark: ColorShades(light: 0xFFFEF3C7, main: 0xFFFDE68A, dark: 0xFFFBBF24),
  ),
  CustomColor.yellow: ColorTheme(
    light: ColorShades(light: 0xFFEAB308, main: 0xFFA16207, dark: 0xFF854D0E),
    dark: ColorShades(light: 0xFFFEF9C3, main: 0xFFFEF08A, dark: 0xFFFDE047),
  ),
  CustomColor.lime: ColorTheme(
    light: ColorShades(light: 0xFF84CC16, main: 0xFF4D7C0F, dark: 0xFF365314),
    dark: ColorShades(light: 0xFFECFCCB, main: 0xFFD9F99D, dark: 0xFFA3E635),
  ),
  CustomColor.green: ColorTheme(
    light: ColorShades(light: 0xFF22C55E, main: 0xFF15803D, dark: 0xFF14532D),
    dark: ColorShades(light: 0xFFDCFCE7, main: 0xFFBBF7D0, dark: 0xFF4ADE80),
  ),
  CustomColor.emerald: ColorTheme(
    light: ColorShades(light: 0xFF10B981, main: 0xFF065F46, dark: 0xFF064E3B),
    dark: ColorShades(light: 0xFFD1FAE5, main: 0xFFA7F3D0, dark: 0xFF34D399),
  ),
  CustomColor.teal: ColorTheme(
    light: ColorShades(light: 0xFF14B8A6, main: 0xFF115E59, dark: 0xFF134E4A),
    dark: ColorShades(light: 0xFFCCFBF1, main: 0xFF99F6E4, dark: 0xFF2DD4BF),
  ),
  CustomColor.cyan: ColorTheme(
    light: ColorShades(light: 0xFF06B6D4, main: 0xFF0E7490, dark: 0xFF164E63),
    dark: ColorShades(light: 0xFFCFFAFE, main: 0xFFA5F3FC, dark: 0xFF22D3EE),
  ),
  CustomColor.sky: ColorTheme(
    light: ColorShades(light: 0xFF0EA5E9, main: 0xFF0369A1, dark: 0xFF075985),
    dark: ColorShades(light: 0xFFE0F2FE, main: 0xFFBAE6FD, dark: 0xFF38BDF8),
  ),
  CustomColor.blue: ColorTheme(
    light: ColorShades(light: 0xFF3B82F6, main: 0xFF193cb8, dark: 0xFF1E40AF),
    dark: ColorShades(light: 0xFFDBEAFE, main: 0xFFBFDBFE, dark: 0xFF60A5FA),
  ),
  CustomColor.indigo: ColorTheme(
    light: ColorShades(light: 0xFF6366F1, main: 0xFF4338CA, dark: 0xFF312E81),
    dark: ColorShades(light: 0xFFE0E7FF, main: 0xFFC7D2FE, dark: 0xFF818CF8),
  ),
  CustomColor.violet: ColorTheme(
    light: ColorShades(light: 0xFF8B5CF6, main: 0xFF6D28D9, dark: 0xFF4C1D95),
    dark: ColorShades(light: 0xFFEDE9FE, main: 0xFFDDD6FE, dark: 0xFFA78BFA),
  ),
  CustomColor.purple: ColorTheme(
    light: ColorShades(light: 0xFFA78BFA, main: 0xFF7C3AED, dark: 0xFF4C1D95),
    dark: ColorShades(light: 0xFFEDE9FE, main: 0xFFC4B5FD, dark: 0xFF8B5CF6),
  ),
  CustomColor.fucshia: ColorTheme(
    light: ColorShades(light: 0xFFD946EF, main: 0xFFA21CAF, dark: 0xFF701A75),
    dark: ColorShades(light: 0xFFFAE8FF, main: 0xFFF5D0FE, dark: 0xFFD946EF),
  ),
  CustomColor.pink: ColorTheme(
    light: ColorShades(light: 0xFFEC4899, main: 0xFFBE185D, dark: 0xFF831843),
    dark: ColorShades(light: 0xFFFCE7F3, main: 0xFFFBCFE8, dark: 0xFFF472B6),
  ),
  CustomColor.rose: ColorTheme(
    light: ColorShades(light: 0xFFF43F5E, main: 0xFF9F1239, dark: 0xFF881337),
    dark: ColorShades(light: 0xFFFFE4E6, main: 0xFFFECDD3, dark: 0xFFFDA4AF),
  ),
  CustomColor.slate: ColorTheme(
    light: ColorShades(light: 0xFF64748B, main: 0xFF334155, dark: 0xFF0F172A),
    dark: ColorShades(light: 0xFFF1F5F9, main: 0xFFE2E8F0, dark: 0xFFCBD5E1),
  ),
  CustomColor.gray: ColorTheme(
    light: ColorShades(light: 0xFF99A1AF, main: 0xFF4A5565, dark: 0xFF1E2939),
    dark: ColorShades(light: 0xFFF3F4F6, main: 0xFFE5E7EB, dark: 0xFF99A1AF),
  ),
  CustomColor.zinc: ColorTheme(
    light: ColorShades(light: 0xFF9F9FA9, main: 0xFF52525C, dark: 0xFF27272A),
    dark: ColorShades(light: 0xFFF4F4F5, main: 0xFFE4E4E7, dark: 0xFF9F9FA9),
  ),
  CustomColor.neutral: ColorTheme(
    light: ColorShades(light: 0xFFA1A1A1, main: 0xFF525252, dark: 0xFF262626),
    dark: ColorShades(light: 0xFFF5F5F5, main: 0xFFE5E5E5, dark: 0xFFA1A1A1),
  ),
  CustomColor.stone: ColorTheme(
    light: ColorShades(light: 0xFFA6A09B, main: 0xFF57534D, dark: 0xFF292524),
    dark: ColorShades(light: 0xFFF5F5F4, main: 0xFFE7E5E4, dark: 0xFFA6A09B),
  ),
};

ColorShades getShades(CustomColor color, Brightness brightness) {
  final theme = _colorThemes[color]!;
  return brightness == Brightness.dark ? theme.dark : theme.light;
}

extension CustomColorGetX on CustomColor {
  Color get main => Get.find<ThemeController>().getColorValue(this);
  Color get light => Color(Get.find<ThemeController>().getLight(this));
  Color get dark => Color(Get.find<ThemeController>().getDark(this));
}
