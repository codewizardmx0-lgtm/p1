import 'package:flutter/material.dart';
import 'package:flutter_app/utils/localfiles.dart';
import 'package:flutter_app/widgets/common_button.dart';
import 'package:flutter_app/routes/routes.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isLoad = false;

  @override
  void initState() {
    super.initState();
    // محاكاة تحميل أي بيانات
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        isLoad = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          // خلفية الصورة
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Image.asset(Localfiles.introduction, fit: BoxFit.cover),
          ),
          Column(
            children: <Widget>[
              Expanded(flex: 1, child: SizedBox()),
              // أيقونة التطبيق
              Center(
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.black26,
                        offset: Offset(1.1, 1.1),
                        blurRadius: 10.0,
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    child: Image.asset(Localfiles.appIcon),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Expanded(flex: 4, child: SizedBox()),
              // زر الانتقال
              AnimatedOpacity(
                opacity: isLoad ? 1.0 : 0.0,
                duration: Duration(milliseconds: 680),
                child: CommonButton(
                  padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 8),
                  buttonText: "Get Started",
                  onTap: () {
                    // الانتقال إلى صفحة المقدمة (IntroductionScreen)
                    Navigator.pushNamed(context, RoutesName.IntroductionScreen);
                  },
                ),
              ),
              SizedBox(height: 24),
            ],
          ),
        ],
      ),
    );
  }
}
