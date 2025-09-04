import 'package:flutter/material.dart';
import 'package:flutter_hotel_booking_ui/utils/enum.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_hotel_booking_ui/providers/theme_provider.dart';
import 'package:flutter_hotel_booking_ui/motel_app.dart';
import 'package:provider/provider.dart';
// import 'legacy_text_theme.dart'; // احذف إذا لم تستخدم الامتداد

class AppTheme {
  static bool get isLightMode {
    return applicationcontext == null
        ? true
        : applicationcontext!.read<ThemeProvider>().isLightMode;
  }

  // Colors
  static Color get primaryColor {
    ColorType _colortypedata = applicationcontext == null
        ? ColorType.Verdigris
        : applicationcontext!.read<ThemeProvider>().colorType;
    return getColor(_colortypedata);
  }

  static Color get scaffoldBackgroundColor =>
      isLightMode ? const Color(0xFFF7F7F7) : const Color(0xFF1A1A1A);

  static Color get redErrorColor =>
      isLightMode ? const Color(0xFFAC0000) : const Color(0xFFAC0000);

  static Color get backgroundColor =>
      isLightMode ? const Color(0xFFFFFFFF) : const Color(0xFF2C2C2C);

  static Color get primaryTextColor =>
      isLightMode ? const Color(0xFF262626) : const Color(0xFFFFFFFF);

  static Color get secondaryTextColor =>
      isLightMode ? const Color(0xFFADADAD) : const Color(0xFF6D6D6D);

  static Color get whiteColor => const Color(0xFFFFFFFF);
  static Color get backColor => const Color(0xFF262626);

  static Color get fontcolor =>
      isLightMode ? const Color(0xFF1A1A1A) : const Color(0xFFF7F7F7);

  static ThemeData get getThemeData =>
      isLightMode ? _buildLightTheme() : _buildDarkTheme();

  static TextTheme _buildTextTheme(TextTheme base) {
    FontFamilyType _fontType = applicationcontext == null
        ? FontFamilyType.WorkSans
        : applicationcontext!.read<ThemeProvider>().fontType;
    return base.copyWith(
      displayLarge: getTextStyle(_fontType, base.displayLarge!),
      displayMedium: getTextStyle(_fontType, base.displayMedium!),
      displaySmall: getTextStyle(_fontType, base.displaySmall!),
      headlineMedium: getTextStyle(_fontType, base.headlineMedium!),
      headlineSmall: getTextStyle(_fontType, base.headlineSmall!),
      titleLarge: getTextStyle(
        _fontType,
        base.titleLarge!.copyWith(fontWeight: FontWeight.bold),
      ),
      labelLarge: getTextStyle(_fontType, base.labelLarge!),
      bodySmall: getTextStyle(_fontType, base.bodySmall!),
      bodyLarge: getTextStyle(_fontType, base.bodyLarge!),
      bodyMedium: getTextStyle(_fontType, base.bodyMedium!),
      titleMedium: getTextStyle(
        _fontType,
        base.titleMedium!.copyWith(fontWeight: FontWeight.bold),
      ),
      titleSmall: getTextStyle(_fontType, base.titleSmall!),
      labelSmall: getTextStyle(_fontType, base.labelSmall!),
    );
  }

  // Light and Dark Color variants
  static Color getColor(ColorType _colordata) {
    switch (_colordata) {
      case ColorType.Verdigris:
        return const Color(0xFF4FBE9F);
      case ColorType.Malibu:
        return const Color(0xFF5DCAEC);
      case ColorType.DarkSkyBlue:
        return const Color(0xFF458CEA);
      case ColorType.BilobaFlower:
        return const Color(0xFFff5f5f);
    }
  }

  static TextStyle getTextStyle(
      FontFamilyType _fontFamilyType, TextStyle textStyle) {
    switch (_fontFamilyType) {
      case FontFamilyType.Montserrat:
        return GoogleFonts.montserrat(textStyle: textStyle);
      case FontFamilyType.WorkSans:
        return GoogleFonts.workSans(textStyle: textStyle);
      case FontFamilyType.Varela:
        return GoogleFonts.varela(textStyle: textStyle);
      case FontFamilyType.Satisfy:
        return GoogleFonts.satisfy(textStyle: textStyle);
      case FontFamilyType.DancingScript:
        return GoogleFonts.dancingScript(textStyle: textStyle);
      case FontFamilyType.KaushanScript:
        return GoogleFonts.kaushanScript(textStyle: textStyle);
      default:
        return GoogleFonts.roboto(textStyle: textStyle);
    }
  }

  static ThemeData _buildLightTheme() {
    final ColorScheme colorScheme = const ColorScheme.light().copyWith(
      primary: primaryColor,
      secondary: primaryColor,
      background: backgroundColor,
    );
    final ThemeData base = ThemeData.light();

    return base.copyWith(
      colorScheme: colorScheme,
      primaryColor: primaryColor,
      scaffoldBackgroundColor: scaffoldBackgroundColor,
      canvasColor: scaffoldBackgroundColor,
      buttonTheme: _buttonThemeData(colorScheme),
      dialogTheme: _dialogTheme(),
      cardTheme: _cardTheme(),
      textTheme: _buildTextTheme(base.textTheme),
      primaryTextTheme: _buildTextTheme(base.textTheme),
      platform: TargetPlatform.iOS,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }

  static ThemeData _buildDarkTheme() {
    final ColorScheme colorScheme = const ColorScheme.dark().copyWith(
      primary: primaryColor,
      secondary: primaryColor,
      background: backgroundColor,
    );
    final ThemeData base = ThemeData.dark();

    return base.copyWith(
      colorScheme: colorScheme,
      primaryColor: primaryColor,
      scaffoldBackgroundColor: scaffoldBackgroundColor,
      canvasColor: scaffoldBackgroundColor,
      buttonTheme: _buttonThemeData(colorScheme),
      dialogTheme: _dialogTheme(),
      cardTheme: _cardTheme(),
      textTheme: _buildTextTheme(base.textTheme),
      primaryTextTheme: _buildTextTheme(base.textTheme),
      platform: TargetPlatform.iOS,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }

  static ButtonThemeData _buttonThemeData(ColorScheme colorScheme) {
    return ButtonThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      colorScheme: colorScheme,
      textTheme: ButtonTextTheme.primary,
    );
  }

  static DialogTheme _dialogTheme() {
    return DialogTheme(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      elevation: 0,
      backgroundColor: backgroundColor,
    );
  }

  static CardTheme _cardTheme() {
    return CardTheme(
      clipBehavior: Clip.antiAlias,
      color: backgroundColor,
      shadowColor: secondaryTextColor.withValues(alpha: 0.2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      elevation: 8,
      margin: const EdgeInsets.all(0),
    );
  }

  static get mapCardDecoration => BoxDecoration(
        color: AppTheme.scaffoldBackgroundColor,
        borderRadius: const BorderRadius.all(Radius.circular(24.0)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Theme.of(applicationcontext!).dividerColor,
            offset: const Offset(4, 4),
            blurRadius: 8.0,
          ),
        ],
      );

  static get buttonDecoration => BoxDecoration(
        color: AppTheme.primaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(24.0)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Theme.of(applicationcontext!).dividerColor,
            blurRadius: 8,
            offset: const Offset(4, 4),
          ),
        ],
      );

  static get searchBarDecoration => BoxDecoration(
        color: AppTheme.scaffoldBackgroundColor,
        borderRadius: const BorderRadius.all(Radius.circular(38)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Theme.of(applicationcontext!).dividerColor,
            blurRadius: 8,
          ),
        ],
      );

  static get boxDecoration => BoxDecoration(
        color: AppTheme.scaffoldBackgroundColor,
        borderRadius: const BorderRadius.all(Radius.circular(16.0)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Theme.of(applicationcontext!).dividerColor,
            blurRadius: 8,
          ),
        ],
      );
}

enum ThemeModeType {
  system,
  dark,
  light,
}
