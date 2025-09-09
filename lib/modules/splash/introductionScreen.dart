import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_app/utils/localfiles.dart';
import 'package:flutter_app/utils/themes.dart';
import 'package:flutter_app/modules/splash/components/page_pop_view.dart';
import 'package:flutter_app/widgets/common_button.dart';
import 'package:flutter_app/routes/route_names.dart'; 

class IntroductionScreen extends StatefulWidget {
  @override
  _IntroductionScreenState createState() => _IntroductionScreenState();
}

class _IntroductionScreenState extends State<IntroductionScreen> {
  var pageController = PageController(initialPage: 0);
  List<PageViewData> pageViewModelData = [];

  late Timer sliderTimer;
  var currentShowIndex = 0;

  @override
  void initState() {
    super.initState();

    // بيانات الشرائح
    pageViewModelData.add(PageViewData(
      titleText: 'Plan Your Trips',
      subText: 'Book one of your trips',
      assetsImage: Localfiles.introduction1,
    ));

    pageViewModelData.add(PageViewData(
      titleText: 'Find Best Deals',
      subText: 'Find deals for any destination',
      assetsImage: Localfiles.introduction2,
    ));

    pageViewModelData.add(PageViewData(
      titleText: 'Best Travelling All Time',
      subText: 'Find deals for any destination',
      assetsImage: Localfiles.introduction3,
    ));

    // Timer للتنقل التلقائي بين الصفحات
    sliderTimer = Timer.periodic(Duration(seconds: 4), (timer) {
      setState(() {
        currentShowIndex = (currentShowIndex + 1) % pageViewModelData.length;
      });
      pageController.animateTo(
        currentShowIndex * MediaQuery.of(context).size.width,
        duration: Duration(seconds: 1),
        curve: Curves.fastOutSlowIn,
      );
    });
  }

  @override
  void dispose() {
    sliderTimer.cancel();
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          SizedBox(height: MediaQuery.of(context).padding.top),
          Expanded(
            child: PageView(
              controller: pageController,
              onPageChanged: (index) {
                setState(() {
                  currentShowIndex = index;
                });
              },
              children: pageViewModelData
                  .map((data) => PagePopup(imageData: data))
                  .toList(),
            ),
          ),
          // مؤشرات النقاط
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              pageViewModelData.length,
              (index) => Container(
                margin: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                width: currentShowIndex == index ? 12 : 8,
                height: currentShowIndex == index ? 12 : 8,
                decoration: BoxDecoration(
                  color: currentShowIndex == index
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).dividerColor,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
          // زر الدخول
          CommonButton(
            padding:
                const EdgeInsets.only(left: 48, right: 48, bottom: 8, top: 32),
            buttonText: "تسجيل الدخول",
            onTap: () {
                NavigationServices(context).gotoLoginScreen();
            },
          ),
          // زر إنشاء حساب
          CommonButton(
            padding:
                const EdgeInsets.only(left: 48, right: 48, bottom: 32, top: 8),
            buttonText: "إنشاء حساب",
            backgroundColor: AppTheme.backgroundColor,
            textColor: AppTheme.primaryTextColor,
            onTap: () {
              NavigationServices(context).gotoSignScreen();
            },
          ),
          SizedBox(height: MediaQuery.of(context).padding.bottom),
        ],
      ),
    );
  }
}
