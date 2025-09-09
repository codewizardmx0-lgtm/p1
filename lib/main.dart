import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/motel_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // قفل الوضع العمودي
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isLightMode = true;

  void toggleTheme() {
    setState(() {
      isLightMode = !isLightMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Motel',
      debugShowCheckedModeBanner: false,
      theme: isLightMode ? ThemeData.light() : ThemeData.dark(),
      home: MotelApp(),
    );
  }
}
