import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_app/utils/localfiles.dart';
import 'package:flutter_app/utils/text_styles.dart';
import 'package:flutter_app/utils/themes.dart';

class HomeExploreSliderView extends StatefulWidget {
  final double opValue;
  final VoidCallback click;

  const HomeExploreSliderView(
      {Key? key, this.opValue = 0.0, required this.click})
      : super(key: key);

  @override
  _HomeExploreSliderViewState createState() => _HomeExploreSliderViewState();
}

class _HomeExploreSliderViewState extends State<HomeExploreSliderView> {
  var pageController = PageController(initialPage: 0);
  List<PageViewData> pageViewModelData = [];
  late Timer sliderTimer;
  var currentShowIndex = 0;

  @override
  void initState() {
    pageViewModelData.add(PageViewData(
      titleText: 'Cape Town',
      subText: 'Five Star',
      assetsImage: LocalFiles.explore_2,
    ));
    pageViewModelData.add(PageViewData(
      titleText: 'Find Best Deals',
      subText: 'Five Star',
      assetsImage: LocalFiles.explore_1,
    ));
    pageViewModelData.add(PageViewData(
      titleText: 'Find Best Deals',
      subText: 'Five Star',
      assetsImage: LocalFiles.explore_3,
    ));

    sliderTimer = Timer.periodic(Duration(seconds: 4), (timer) {
      if (mounted) {
        if (currentShowIndex == 0) {
          pageController.animateTo(MediaQuery.of(context).size.width,
              duration: Duration(seconds: 1), curve: Curves.fastOutSlowIn);
        } else if (currentShowIndex == 1) {
          pageController.animateTo(MediaQuery.of(context).size.width * 2,
              duration: Duration(seconds: 1), curve: Curves.fastOutSlowIn);
        } else if (currentShowIndex == 2) {
          pageController.animateTo(0,
              duration: Duration(seconds: 1), curve: Curves.fastOutSlowIn);
        }
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    sliderTimer.cancel();
    pageController.dispose();
    super.dispose();
  }

  Widget buildIndicator() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(pageViewModelData.length, (index) {
        bool isActive = index == currentShowIndex;
        return AnimatedContainer(
          duration: Duration(milliseconds: 300),
          margin: EdgeInsets.symmetric(horizontal: 4),
          width: isActive ? 16 : 10,
          height: 10,
          decoration: BoxDecoration(
            color: isActive ? Theme.of(context).primaryColor : Colors.grey,
            borderRadius: BorderRadius.circular(5),
          ),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Stack(
        children: <Widget>[
          PageView(
            controller: pageController,
            pageSnapping: true,
            onPageChanged: (index) {
              setState(() {
                currentShowIndex = index;
              });
            },
            scrollDirection: Axis.horizontal,
            children: pageViewModelData
                .map((data) => PagePopup(
                      imageData: data,
                      opValue: widget.opValue,
                    ))
                .toList(),
          ),
          Positioned(
            bottom: 32,
            left: 32,
            child: buildIndicator(),
          ),
        ],
      ),
    );
  }
}

class PagePopup extends StatelessWidget {
  final PageViewData imageData;
  final double opValue;

  const PagePopup({Key? key, required this.imageData, this.opValue = 0.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.width * 1.3,
          width: MediaQuery.of(context).size.width,
          child: Image.asset(
            imageData.assetsImage,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          bottom: 80,
          left: 24,
          right: 24,
          child: Opacity(
            opacity: opValue,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  imageData.titleText,
                  textAlign: TextAlign.left,
                  style: TextStyles(context)
                      .getTitleStyle()
                      .copyWith(color: AppTheme.whiteColor),
                ),
                SizedBox(height: 8),
                Text(
                  imageData.subText,
                  textAlign: TextAlign.left,
                  style: TextStyles(context).getRegularStyle().copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: AppTheme.whiteColor),
                ),
                SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class PageViewData {
  String titleText;
  String subText;
  String assetsImage;

  PageViewData(
      {required this.titleText,
      required this.subText,
      required this.assetsImage});
}
