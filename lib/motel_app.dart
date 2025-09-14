import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/modules/splash/introductionScreen.dart';
import 'package:flutter_app/modules/splash/splashScreen.dart';
import 'package:flutter_app/routes/routes.dart';

BuildContext? applicationContext;

class MotelApp extends StatefulWidget {
  @override
  _MotelAppState createState() => _MotelAppState();
}

class _MotelAppState extends State<MotelApp> {
  bool isLightMode = true; // متغير التحكم بالثيم

  @override
  Widget build(BuildContext context) {
    applicationContext = context;

    return MaterialApp(
      title: 'Motel',
      debugShowCheckedModeBanner: false,
      theme: isLightMode ? ThemeData.light() : ThemeData.dark(),
      routes: _buildRoutes(),
      builder: (BuildContext context, Widget? child) {
        _setStatusBarNavigationBarTheme(Theme.of(context));
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaleFactor: MediaQuery.of(context).size.width > 360
                ? 1.0
                : MediaQuery.of(context).size.width >= 340
                    ? 0.9
                    : 0.8,
          ),
          child: child ?? SizedBox(),
        );
      },
    );
  }

  void _setStatusBarNavigationBarTheme(ThemeData themeData) {
    final brightness = !kIsWeb && Platform.isAndroid
        ? themeData.brightness == Brightness.light
            ? Brightness.dark
            : Brightness.light
        : themeData.brightness;

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: brightness,
      statusBarBrightness: brightness,
      systemNavigationBarColor: themeData.scaffoldBackgroundColor,
      systemNavigationBarDividerColor: Colors.transparent,
      systemNavigationBarIconBrightness: brightness,
    ));
  }

  Map<String, WidgetBuilder> _buildRoutes() {
    return {
      RoutesName.Splash: (BuildContext context) => SplashScreen(),
      RoutesName.IntroductionScreen: (BuildContext context) => IntroductionScreen(),
    };
  }
}
