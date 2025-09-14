import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/popular_filter_list.dart';
import 'package:flutter_app/modules/hotel_booking/filter_screen/slider_view.dart';
import 'package:flutter_app/utils/themes.dart';
import 'package:flutter_app/widgets/common_appbar_view.dart';
import 'package:flutter_app/widgets/common_button.dart';
import 'range_slider_view.dart';

class FiltersScreen extends StatefulWidget {
  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  List<PopularFilterListData> popularFilterListData =
      PopularFilterListData.popularFList;
  List<PopularFilterListData> accomodationListData =
      PopularFilterListData.accomodationList;

  RangeValues _values = RangeValues(100, 600);
  double distValue = 50.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.scaffoldBackgroundColor,
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CommonAppbarView(
              iconData: Icons.close,
              onBackClick: () {
                Navigator.pop(context);
              },
              titleText: "الفلاتر", // نص مباشر بدل AppLocalizations
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: Column(
                    children: <Widget>[
                      priceBarFilter(),
                      Divider(height: 1),
                      popularFilter(),
                      Divider(height: 1),
                      distanceViewUI(),
                      Divider(height: 1),
                      allAccommodationUI(),
                    ],
                  ),
                ),
              ),
            ),
            Divider(height: 1),
            Padding(
              padding: EdgeInsets.only(
                  left: 16,
                  right: 16,
                  bottom: 16 + MediaQuery.of(context).padding.bottom,
                  top: 8),
              child: CommonButton(
                  buttonText: "تطبيق", // نص مباشر
                  onTap: () {
                    Navigator.pop(context, true);
                  }),
            )
          ],
        ),
      ),
    );
  }

  Widget allAccommodationUI() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 8),
          child: Text(
            "نوع الإقامة", // نص مباشر
            textAlign: TextAlign.left,
            style: TextStyle(
                color: Colors.grey,
                fontSize: MediaQuery.of(context).size.width > 360 ? 18 : 16,
                fontWeight: FontWeight.normal),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 16, left: 16),
          child: Column(
            children: getAccomodationListUI(),
          ),
        ),
        SizedBox(height: 8),
      ],
    );
  }

  List<Widget> getAccomodationListUI() {
    List<Widget> noList = [];
    for (var i = 0; i < accomodationListData.length; i++) {
      final data = accomodationListData[i];
      noList.add(
        Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.all(Radius.circular(4.0)),
            onTap: () {
              setState(() {
                checkAppPosition(i);
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(data.titleTxt), // النص مباشر
                  ),
                  CupertinoSwitch(
                    activeColor: data.isSelected
                        ? Theme.of(context).primaryColor
                        : Colors.grey.withOpacity(0.6),
                    onChanged: (value) {
                      setState(() {
                        checkAppPosition(i);
                      });
                    },
                    value: data.isSelected,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
      if (i == 0) {
        noList.add(Divider(height: 1));
      }
    }
    return noList;
  }

  void checkAppPosition(int index) {
    if (index == 0) {
      if (accomodationListData[0].isSelected) {
        accomodationListData.forEach((d) {
          d.isSelected = false;
        });
      } else {
        accomodationListData.forEach((d) {
          d.isSelected = true;
        });
      }
    } else {
      accomodationListData[index].isSelected =
          !accomodationListData[index].isSelected;

      var count = 0;
      for (var i = 0; i < accomodationListData.length; i++) {
        if (i != 0 && accomodationListData[i].isSelected) {
          count += 1;
        }
      }

      accomodationListData[0].isSelected =
          count == accomodationListData.length - 1;
    }
  }

  Widget distanceViewUI() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 8),
          child: Text(
            "المسافة من المدينة", // نص مباشر
            textAlign: TextAlign.left,
            style: TextStyle(
                color: Colors.grey,
                fontSize: MediaQuery.of(context).size.width > 360 ? 18 : 16,
                fontWeight: FontWeight.normal),
          ),
        ),
        SliderView(
          distValue: distValue,
          onChnagedistValue: (value) {
            setState(() {
              distValue = value;
            });
          },
        ),
        SizedBox(height: 8),
      ],
    );
  }

  Widget popularFilter() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 8),
          child: Text(
            "الفلاتر الشائعة", // نص مباشر
            textAlign: TextAlign.left,
            style: TextStyle(
                color: Colors.grey,
                fontSize: MediaQuery.of(context).size.width > 360 ? 18 : 16,
                fontWeight: FontWeight.normal),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 16, left: 16),
          child: Column(children: getPList()),
        ),
        SizedBox(height: 8),
      ],
    );
  }

  List<Widget> getPList() {
    List<Widget> noList = [];
    var cout = 0;
    final columCount = 2;
    for (var i = 0; i < popularFilterListData.length / columCount; i++) {
      List<Widget> listUI = [];
      for (var i = 0; i < columCount; i++) {
        try {
          final data = popularFilterListData[cout];
          listUI.add(
            Expanded(
              child: Row(
                children: <Widget>[
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                      onTap: () {
                        setState(() {
                          data.isSelected = !data.isSelected;
                        });
                      },
                      child: Padding(
                        padding:
                            const EdgeInsets.only(left: 8.0, top: 8, bottom: 8, right: 0),
                        child: Row(
                          children: <Widget>[
                            Icon(
                              data.isSelected
                                  ? Icons.check_box
                                  : Icons.check_box_outline_blank,
                              color: data.isSelected
                                  ? Theme.of(context).primaryColor
                                  : Colors.grey.withOpacity(0.6),
                            ),
                            SizedBox(width: 4),
                            FittedBox(fit: BoxFit.cover, child: Text(data.titleTxt)), // نص مباشر
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
          cout += 1;
        } catch (e) {}
      }
      noList.add(Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: listUI,
      ));
    }
    return noList;
  }

  Widget priceBarFilter() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            "السعر", // نص مباشر
            textAlign: TextAlign.left,
            style: TextStyle(
                color: Colors.grey,
                fontSize: MediaQuery.of(context).size.width > 360 ? 18 : 16,
                fontWeight: FontWeight.normal),
          ),
        ),
        RangeSliderView(
          values: _values,
          onChnageRangeValues: (values) {
            setState(() {
              _values = values;
            });
          },
        ),
        SizedBox(height: 8),
      ],
    );
  }
}
