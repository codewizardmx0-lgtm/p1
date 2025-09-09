import 'package:flutter/material.dart';
import 'package:flutter_app/utils/enum.dart';
import 'package:flutter_app/utils/shared_preferences_keys.dart';
import 'package:flutter_app/utils/themes.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeProvider({
    required this.isLightMode,
    required this.colorType,
    required this.fontType,
  });

  bool isLightMode;
  ColorType colorType;
  FontFamilyType fontType;

  ThemeData get themeData => AppTheme.getThemeData(
        isLightMode: isLightMode,
        colorType: colorType,
        fontType: fontType,
      );

  ThemeModeType themeModeType = ThemeModeType.system;

  // ==================== ThemeMode ====================
  Future<void> updateThemeMode(ThemeModeType type, {Brightness? systemBrightness}) async {
    await SharedPreferencesKeys().setThemeMode(type);
    themeModeType = type;

    if (type == ThemeModeType.system && systemBrightness != null) {
      isLightMode = systemBrightness == Brightness.light;
    } else if (type == ThemeModeType.light) {
      isLightMode = true;
    } else {
      isLightMode = false;
    }

    notifyListeners();
  }

  Future<void> checkAndSetThemeMode({Brightness? systemBrightness}) async {
    themeModeType = await SharedPreferencesKeys().getThemeMode();

    if (themeModeType == ThemeModeType.system && systemBrightness != null) {
      isLightMode = systemBrightness == Brightness.light;
    } else if (themeModeType == ThemeModeType.light) {
      isLightMode = true;
    } else {
      isLightMode = false;
    }

    notifyListeners();
  }

  // ==================== FontType ====================
  Future<void> checkAndSetFontType() async {
    final font = await SharedPreferencesKeys().getFontType();
    if (font != fontType) {
      fontType = font;
      notifyListeners();
    }
  }

  Future<void> updateFontType(FontFamilyType font) async {
    await SharedPreferencesKeys().setFontType(font);
    fontType = font;
    notifyListeners();
  }

  // ==================== ColorType ====================
  Future<void> checkAndSetColorType() async {
    final color = await SharedPreferencesKeys().getColorType();
    if (color != colorType) {
      colorType = color;
      notifyListeners();
    }
  }

  Future<void> updateColorType(ColorType color) async {
    await SharedPreferencesKeys().setColorType(color);
    colorType = color;
    notifyListeners();
  }
}