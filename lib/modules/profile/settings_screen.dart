import 'package:flutter/material.dart';
import 'package:flutter_app/models/setting_list_data.dart';
import 'package:flutter_app/routes/route_names.dart';
import 'package:flutter_app/utils/enum.dart';
import 'package:flutter_app/utils/helper.dart';
import 'package:flutter_app/utils/text_styles.dart';
import 'package:flutter_app/utils/themes.dart';
import 'package:flutter_app/widgets/common_appbar_view.dart';
import 'package:flutter_app/widgets/common_card.dart';
import 'package:flutter_app/widgets/remove_focuse.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> with Helper {
  List<SettingsListData> settingsList = SettingsListData.settingsList;
  var country = 'Australia';
  var currency = '\$ AUD';
  int selectedradioTile = 0;
  List<String> languages = ["English", "French", "Arabic", "Japanese"];
  ThemeModeType themeModeType = ThemeModeType.system;
  FontFamilyType fontType = FontFamilyType.workSans;
  ColorType colorType = ColorType.BilobaFlower;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RemoveFocuse(
        onClick: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CommonAppbarView(
              iconData: Icons.arrow_back,
              onBackClick: () {
                Navigator.pop(context);
              },
              titleText: "Settings",
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.only(top: 16),
                itemCount: settingsList.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      if (index == 1) {
                        // إعادة تشغيل التطبيق أو أي إجراء آخر
                      } else if (index == 6) {
                        NavigationServices(context)
                            .gotoCurrencyScreen()
                            .then((value) {
                          if (value is String && value != "")
                            setState(() {
                              currency = value;
                            });
                        });
                      } else if (index == 5) {
                        NavigationServices(context)
                            .gotoCountryScreen()
                            .then((value) {
                          if (value is String && value != "") {
                            setState(() {
                              country = value;
                            });
                          }
                        });
                      } else if (index == 2) {
                        _getFontPopUI();
                      } else if (index == 3) {
                        _getColorPopUI();
                      } else if (index == 4) {
                        _getLanguageUI();
                      } else if (index == 10) {
                        _gotoSplashScreen();
                      }
                    },
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 8, right: 16),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Text(
                                    settingsList[index].titleTxt,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16),
                                  ),
                                ),
                              ),
                              index == 5
                                  ? Padding(
                                      padding: const EdgeInsets.all(16),
                                      child: getTextUi(country))
                                  : index == 6
                                      ? Padding(
                                          padding: const EdgeInsets.all(16),
                                          child: getTextUi(currency),
                                        )
                                      : index == 1
                                          ? _themeUI()
                                          : Padding(
                                              padding: const EdgeInsets.all(16),
                                              child: Icon(
                                                  settingsList[index].iconData,
                                                  color: AppTheme
                                                      .secondaryTextColor),
                                            )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16, right: 16),
                          child: Divider(
                            height: 1,
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _themeUI() {
    return Padding(
      padding: const EdgeInsets.only(right: 4.0),
      child: PopupMenuButton<ThemeModeType>(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        onSelected: (type) {
          setState(() {
            themeModeType = type;
          });
        },
        icon: Icon(
            themeModeType == ThemeModeType.system
                ? Icons.adjust
                : themeModeType == ThemeModeType.light
                    ? Icons.wb_sunny
                    : Icons.nights_stay,
            color: AppTheme.secondaryTextColor),
        offset: Offset(10, 18),
        itemBuilder: (context) => [
          ...ThemeModeType.values.toList().map(
                (e) => PopupMenuItem(
                  value: e,
                  child: _getSelectedUI(
                    e == ThemeModeType.system
                        ? Icons.adjust
                        : e == ThemeModeType.light
                            ? Icons.wb_sunny
                            : Icons.nights_stay,
                    e.toString().split(".")[1],
                    e == themeModeType,
                  ),
                ),
              ),
        ],
      ),
    );
  }

  Widget getTextUi(String text) {
    return Container(
      child: Text(
        text,
        style: TextStyles(context).getDescriptionStyle().copyWith(
              fontSize: 16,
            ),
      ),
    );
  }

  Widget _getSelectedUI(IconData icon, String text, bool isCurrent) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Icon(
            icon,
            color: isCurrent ? AppTheme.primaryColor : AppTheme.primaryTextColor,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            child: Text(
              text,
              style: TextStyles(context).getRegularStyle().copyWith(
                    color: isCurrent
                        ? AppTheme.primaryColor
                        : AppTheme.primaryTextColor,
                  ),
            ),
          )
        ],
      ),
    );
  }

_getFontPopUI() {
  final List<Widget> fontArray = [];

  FontFamilyType.values.toList().forEach((element) {
    fontArray.add(
      Expanded(
        child: InkWell(
          splashColor: Colors.transparent,
          borderRadius: BorderRadius.circular(8.0),
          onTap: () {
            setState(() {
              fontType = element;
            });
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Hello",
                  style: TextStyle(
                    fontFamily: element.toString().split('.').last, // اسم الخط
                    fontSize: 16,
                    color: fontType == element
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                ),
                SizedBox(height: element == FontFamilyType.workSans ? 3 : 0),
                Text(
                  element.toString().split('.').last,
                  style: TextStyle(
                    fontFamily: element.toString().split('.').last,
                    fontSize: 10,
                    color: fontType == element
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  });

  showDialog(
    barrierDismissible: true,
    context: context,
    builder: (BuildContext context) => Center(
      child: Padding(
        padding: const EdgeInsets.all(48.0),
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          color: Theme.of(context).scaffoldBackgroundColor,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  "Select Font",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).textTheme.titleLarge?.color,
                  ),
                ),
              ),
              Divider(height: 1),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: fontArray.sublist(0, 3),
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: fontArray.sublist(3),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

  _getColorPopUI() {
    final List<Widget> colorArray = [];

    ColorType.values.toList().forEach((element) {
      colorArray.add(
        Expanded(
          child: InkWell(
            splashColor: Colors.transparent,
            borderRadius: BorderRadius.circular(8.0),
            onTap: () {
              setState(() {
                colorType = element;
              });
              Navigator.pop(context);
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                    height: 48,
                    width: 48,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: colorType == element
                                ? AppTheme.getColor(element)
                                : Colors.transparent)),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: AppTheme.getColor(element)),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });

    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(48.0),
            child: CommonCard(
              color: AppTheme.backgroundColor,
              radius: 8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      "Select Color",
                      style: TextStyles(context).getBoldStyle().copyWith(fontSize: 22),
                    ),
                  ),
                  Divider(height: 16),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: colorArray,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

_getLanguageUI() {
  final List<String> languages = ["English", "French", "Arabic", "Japanese"];

  final List<Widget> languageArray = languages.map((lang) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Icon(Icons.radio_button_off), // لأننا لا نخزن الاختيار
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text(lang),
          )
        ],
      ),
    );
  }).toList();

  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) => Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 240,
          child: CommonCard(
            color: AppTheme.backgroundColor,
            radius: 8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 16.0, bottom: 8),
                  child: Text(
                    "Select Language",
                    style: TextStyles(context).getBoldStyle().copyWith(fontSize: 22),
                  ),
                ),
                Divider(height: 16),
                ...languageArray,
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

  void _gotoSplashScreen() async {
    bool isOk = await showCommonPopup(
      "Are you sure?",
      "You want to Sign Out.",
      context,
      barrierDismissible: true,
      isYesOrNoPopup: true,
    );
    if (isOk) {
      NavigationServices(context).gotoSplashScreen();
    }
  }
}
