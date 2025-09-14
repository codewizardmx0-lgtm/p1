import 'package:flutter_app/utils/enum.dart';
import 'package:flutter_app/utils/themes.dart';

class SharedPreferencesKeys {
  // ==================== Keys ====================
  static ThemeModeType _themeMode = ThemeModeType.system;
  static FontFamilyType _fontType = FontFamilyType.workSans;
  static ColorType _colorType = ColorType.Verdigris;

  // ==================== Theme ====================
  Future<ThemeModeType> getThemeMode() async {
    return _themeMode;
  }

  Future<void> setThemeMode(ThemeModeType type) async {
    _themeMode = type;
  }

  // ==================== Font ====================
  Future<FontFamilyType> getFontType() async {
    return _fontType;
  }

  Future<void> setFontType(FontFamilyType type) async {
    _fontType = type;
  }

  // ==================== Color ====================
  Future<ColorType> getColorType() async {
    return _colorType;
  }

  Future<void> setColorType(ColorType type) async {
    _colorType = type;
  }
}
