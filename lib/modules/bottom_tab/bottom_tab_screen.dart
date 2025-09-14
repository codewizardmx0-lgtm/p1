import 'package:flutter/material.dart';
import 'package:flutter_app/modules/explore/home_explore_screen.dart';
import 'package:flutter_app/modules/myTrips/my_trips_screen.dart';
import 'package:flutter_app/modules/profile/profile_screen.dart';
import 'package:flutter_app/utils/themes.dart';
import 'package:flutter_app/modules/bottom_tab/components/tab_button_UI.dart';
import 'package:flutter_app/widgets/common_card.dart';

class BottomTabScreen extends StatefulWidget {
  @override
  _BottomTabScreenState createState() => _BottomTabScreenState();
}

class _BottomTabScreenState extends State<BottomTabScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  bool _isFirstTime = true;
  Widget _indexView = Container();
  BottomBarType bottomBarType = BottomBarType.Explore;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(duration: Duration(milliseconds: 400), vsync: this);
    _indexView = Container();
    WidgetsBinding.instance.addPostFrameCallback((_) => _startLoadScreen());
  }

  Future _startLoadScreen() async {
    await Future.delayed(const Duration(milliseconds: 480));
    setState(() {
      _isFirstTime = false;
      _indexView = HomeExploreScreen(
        animationController: _animationController,
      );
    });
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void tabClick(BottomBarType tabType) {
    if (tabType != bottomBarType) {
      bottomBarType = tabType;
      _animationController.reverse().then((_) {
        setState(() {
          if (tabType == BottomBarType.Explore) {
            _indexView = HomeExploreScreen(
              animationController: _animationController,
            );
          } else if (tabType == BottomBarType.Trips) {
            _indexView = MyTripsScreen(animationController: _animationController,);
          } else if (tabType == BottomBarType.Profile) {
            _indexView = ProfileScreen(animationController: _animationController,);
          }
        });
        _animationController.forward();
      });
    }
  }

  Widget getBottomBarUI(BottomBarType tabType) {
    return SafeArea(
      child: CommonCard(
        color: AppTheme.backgroundColor,
        radius: 0,
        child: Row(
          mainAxisSize: MainAxisSize.min, // البار ياخذ ارتفاعه الطبيعي
          children: <Widget>[
            TabButtonUI(
              icon: Icons.search,
              isSelected: tabType == BottomBarType.Explore,
              text: "استكشاف",
              onTap: () => tabClick(BottomBarType.Explore),
            ),
            TabButtonUI(
              icon: Icons.favorite,
              isSelected: tabType == BottomBarType.Trips,
              text: "رحلاتي",
              onTap: () => tabClick(BottomBarType.Trips),
            ),
            TabButtonUI(
              icon: Icons.person,
              isSelected: tabType == BottomBarType.Profile,
              text: "ملفي",
              onTap: () => tabClick(BottomBarType.Profile),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: getBottomBarUI(bottomBarType),
      body: _isFirstTime
          ? Center(child: CircularProgressIndicator(strokeWidth: 2))
          : _indexView,
    );
  }
}

enum BottomBarType { Explore, Trips, Profile }
