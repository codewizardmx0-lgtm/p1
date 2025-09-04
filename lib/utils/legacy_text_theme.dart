import 'package:flutter/material.dart';

extension LegacyTextTheme on TextTheme {
  // display
  TextStyle? get headline1 => displayLarge;
  TextStyle? get headline2 => displayMedium;
  TextStyle? get headline3 => displaySmall;

  // headline
  TextStyle? get headline4 => headlineMedium;
  TextStyle? get headline5 => headlineSmall;
  TextStyle? get headline6 => titleLarge;

  // titles / subtitles
  TextStyle? get subtitle1 => titleMedium;
  TextStyle? get subtitle2 => titleSmall;

  // body
  TextStyle? get bodyText1 => bodyLarge;
  TextStyle? get bodyText2 => bodyMedium;

  // misc
  TextStyle? get caption => bodySmall;
  TextStyle? get button => labelLarge;
  TextStyle? get overline => labelSmall;
}
