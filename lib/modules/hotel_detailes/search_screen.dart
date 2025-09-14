import 'package:flutter/material.dart';
import 'package:flutter_app/models/hotel_list_data.dart';
import 'package:flutter_app/modules/hotel_detailes/search_type_list.dart';
import 'package:flutter_app/modules/hotel_detailes/search_view.dart';
import 'package:flutter_app/utils/themes.dart';
import 'package:flutter_app/widgets/common_appbar_view.dart';
import 'package:flutter_app/widgets/common_card.dart';
import 'package:flutter_app/widgets/common_search_bar.dart';
import 'package:flutter_app/widgets/remove_focuse.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with TickerProviderStateMixin {
  List<HotelListData> lastsSearchesList = HotelListData.lastsSearchesList;

  late AnimationController animationController;
  final myController = TextEditingController();

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.scaffoldBackgroundColor,
      body: RemoveFocuse(
        onClick: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // AppBar
            CommonAppbarView(
              iconData: Icons.close,
              onBackClick: () {
                Navigator.pop(context);
              },
              titleText: "Search Hotel", // نص مباشر
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 24, right: 24, top: 16, bottom: 16),
                          child: CommonCard(
                            color: AppTheme.backgroundColor,
                            radius: 36,
                            child: CommonSearchBar(
                              textEditingController: myController,
                              iconData: Icons.search, // أيقونة Flutter
                              enabled: true,
                              text: "Where are you going?", // نص مباشر
                            ),
                          ),
                        ),
                        SearchTypeListView(),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 24, right: 24, top: 8),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  "Last Search", // نص مباشر
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ),
                              Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(4.0)),
                                  onTap: () {
                                    setState(() {
                                      myController.text = '';
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Text(
                                      "Clear All", // نص مباشر
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                        color:
                                            Theme.of(context).primaryColor,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ] +
                      getPList(myController.text.toString()) +
                      [
                        SizedBox(
                          height: MediaQuery.of(context).padding.bottom + 16,
                        )
                      ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> getPList(String searchValue) {
    List<Widget> noList = [];
    var count = 0;
    final columCount = 2;
    List<HotelListData> custList = lastsSearchesList
        .where((element) =>
            element.titleTxt.toLowerCase().contains(searchValue.toLowerCase()))
        .toList();

    for (var i = 0; i < (custList.length / columCount).ceil(); i++) {
      List<Widget> listUI = [];
      for (var j = 0; j < columCount; j++) {
        try {
          final hotel = custList[count];
          var animation = Tween(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(
              parent: animationController,
              curve: Interval((1 / custList.length) * count, 1.0,
                  curve: Curves.fastOutSlowIn),
            ),
          );
          animationController.forward();
          listUI.add(Expanded(
            child: SerchView(
              hotelInfo: hotel,
              animation: animation,
              animationController: animationController,
            ),
          ));
          count += 1;
        } catch (e) {}
      }
      noList.add(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: listUI,
          ),
        ),
      );
    }
    return noList;
  }
}
