import 'package:flutter/material.dart';
import 'package:flutter_app/utils/enum.dart';

class AppTheme {
  // ==================== Colors ====================
  static Color getColor(ColorType type) {
    switch (type) {
      case ColorType.Verdigris:
        return Color(0xFF4FBE9F);
      case ColorType.Malibu:
        return Color(0xFF5DCAEC);
      case ColorType.DarkSkyBlue:
        return Color(0xFF458CEA);
      case ColorType.BilobaFlower:
        return Color(0xFFFF5F5F);
    }
  }
  static Color get redErrorColor => Color(0xFFAC0000);
  static Color get scaffoldBackgroundColor => Color(0xFFF7F7F7);
  static Color get backgroundColor => Color(0xFFFFFFFF);
  static Color get primaryTextColor => Color(0xFF262626);
  static Color get secondaryTextColor => Color(0xFFADADAD);
  static Color get whiteColor => Color(0xFFFFFFFF);

  // ==================== ThemeData ====================
  static ThemeData getThemeData({
    required bool isLightMode,
    required ColorType colorType,
    required FontFamilyType fontType,
  }) {
    final Color primaryColor = getColor(colorType);
    final String fontFamily = _mapFontFamily(fontType);

    final ColorScheme colorScheme = isLightMode
        ? ColorScheme.light(
            primary: primaryColor,
            secondary: primaryColor,
            background: Color(0xFFFFFFFF),
          )
        : ColorScheme.dark(
            primary: primaryColor,
            secondary: primaryColor,
            background: Color(0xFF2C2C2C),
          );

    final ThemeData base = isLightMode ? ThemeData.light() : ThemeData.dark();

    return base.copyWith(
      colorScheme: colorScheme,
      primaryColor: primaryColor,
      scaffoldBackgroundColor:
          isLightMode ? Color(0xFFF7F7F7) : Color(0xFF1A1A1A),
      canvasColor: isLightMode ? Color(0xFFF7F7F7) : Color(0xFF1A1A1A),
      textTheme: _buildTextTheme(base.textTheme, fontFamily),
      primaryTextTheme: _buildTextTheme(base.textTheme, fontFamily),
      platform: TargetPlatform.iOS,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      buttonTheme: ButtonThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        colorScheme: colorScheme,
        textTheme: ButtonTextTheme.primary,
      ),
      dialogTheme: DialogTheme(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        elevation: 0,
        backgroundColor: isLightMode ? Color(0xFFFFFFFF) : Color(0xFF2C2C2C),
      ),
      cardTheme: CardTheme(
        clipBehavior: Clip.antiAlias,
        color: isLightMode ? Color(0xFFFFFFFF) : Color(0xFF2C2C2C),
        shadowColor: (isLightMode ? Color(0xFFADADAD) : Color(0xFF6D6D6D))
            .withOpacity(0.2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        elevation: 8,
        margin: EdgeInsets.zero,
      ),
    );
  }

  // ==================== TextTheme ====================
  static TextTheme _buildTextTheme(TextTheme base, String fontFamily) {
    return base.copyWith(
      displayLarge: base.displayLarge?.copyWith(fontFamily: fontFamily),
      displayMedium: base.displayMedium?.copyWith(fontFamily: fontFamily),
      displaySmall: base.displaySmall?.copyWith(fontFamily: fontFamily),
      headlineMedium: base.headlineMedium?.copyWith(fontFamily: fontFamily),
      headlineSmall: base.headlineSmall?.copyWith(fontFamily: fontFamily),
      titleLarge: base.titleLarge?.copyWith(
        fontFamily: fontFamily,
        fontWeight: FontWeight.bold,
      ),
      labelLarge: base.labelLarge?.copyWith(fontFamily: fontFamily),
      bodySmall: base.bodySmall?.copyWith(fontFamily: fontFamily),
      bodyLarge: base.bodyLarge?.copyWith(fontFamily: fontFamily),
      bodyMedium: base.bodyMedium?.copyWith(fontFamily: fontFamily),
      titleMedium: base.titleMedium?.copyWith(
        fontFamily: fontFamily,
        fontWeight: FontWeight.bold,
      ),
      titleSmall: base.titleSmall?.copyWith(fontFamily: fontFamily),
      labelSmall: base.labelSmall?.copyWith(fontFamily: fontFamily),
    );
  }

  // ==================== Font Mapper ====================
  static String _mapFontFamily(FontFamilyType type) {
    switch (type) {
      case FontFamilyType.workSans:
        return 'WorkSans';
      case FontFamilyType.roboto:
        return 'Roboto';
      case FontFamilyType.openSans:
        return 'OpenSans';
      case FontFamilyType.montserrat:
        return 'Montserrat';
      case FontFamilyType.varela:
        return 'Varela';
      case FontFamilyType.dancingScript:
        return 'DancingScript';
      case FontFamilyType.satisfy:
        return 'Satisfy';
      case FontFamilyType.kaushanScript:
        return 'KaushanScript';
      default:
        return 'Arial'; // 👈 خط افتراضي
    }
  }
  // ==================== BoxDecorations ====================
  static BoxDecoration mapCardDecoration({required Color dividerColor}) {
    return BoxDecoration(
      color: scaffoldBackgroundColor,
      borderRadius: BorderRadius.all(Radius.circular(24.0)),
      boxShadow: [
        BoxShadow(
          color: dividerColor,
          offset: Offset(4, 4),
          blurRadius: 8,
        ),
      ],
    );
  }

  static BoxDecoration buttonDecoration(
      {required Color dividerColor, required Color buttonColor}) {
    return BoxDecoration(
      color: buttonColor,
      borderRadius: BorderRadius.all(Radius.circular(24.0)),
      boxShadow: [
        BoxShadow(
          color: dividerColor,
          blurRadius: 8,
          offset: Offset(4, 4),
        ),
      ],
    );
  }

  static BoxDecoration searchBarDecoration({required Color dividerColor}) {
    return BoxDecoration(
      color: scaffoldBackgroundColor,
      borderRadius: BorderRadius.all(Radius.circular(38)),
      boxShadow: [
        BoxShadow(
          color: dividerColor,
          blurRadius: 8,
        ),
      ],
    );
  }

  static BoxDecoration boxDecoration({required Color dividerColor}) {
    return BoxDecoration(
      color: scaffoldBackgroundColor,
      borderRadius: BorderRadius.all(Radius.circular(16.0)),
      boxShadow: [
        BoxShadow(
          color: dividerColor,
          blurRadius: 8,
        ),
      ],
    );
  }
}

// ==================== ThemeMode Enum ====================
enum ThemeModeType {
  system,
  dark,
  light,
}
