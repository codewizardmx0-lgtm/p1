import 'package:flutter/material.dart';
import 'package:flutter_app/models/hotel_list_data.dart';
import 'package:flutter_app/utils/themes.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapUIView extends StatefulWidget {
  final List<HotelListData> hotelList;
  const GoogleMapUIView({Key? key, required this.hotelList}) : super(key: key);

  @override
  _GoogleMapUIViewState createState() => _GoogleMapUIViewState();
}

class _GoogleMapUIViewState extends State<GoogleMapUIView> {
  GoogleMapController? _mapController;
  List<HotelListData> hotelList = [];

  @override
  void initState() {
    super.initState();
    hotelList = widget.hotelList;
  }

  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }

  void updateUI() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // تحديث المنطقة المرئية للشاشة لكل فندق
        for (var hotel in hotelList) {
          hotel.screenMapPin ??= Offset(0, 0); // تأكد من وجود قيمة
        }

        return Stack(
          children: [
            GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(51.507896, -0.128006),
                zoom: 13,
              ),
              mapType: MapType.normal,
              mapToolbarEnabled: false,
              compassEnabled: false,
              myLocationButtonEnabled: false,
              rotateGesturesEnabled: false,
              tiltGesturesEnabled: false,
              myLocationEnabled: true,
              zoomControlsEnabled: false,
              onMapCreated: (GoogleMapController controller) async {
                _mapController = controller;
                // استخدام الثيم الحالي بدل AppTheme.isLightMode
                bool isLightMode =
                    Theme.of(context).brightness == Brightness.light;
                await _mapController?.setMapStyle(
                  await DefaultAssetBundle.of(context).loadString(
                    isLightMode
                        ? "assets/json/mapstyle_light.json"
                        : "assets/json/mapstyle_dark.json",
                  ),
                );
                updateUI();
              },
            ),
            for (var item in hotelList)
              item.screenMapPin != null
                  ? AnimatedPositioned(
                      duration: Duration(milliseconds: 1),
                      top: item.screenMapPin!.dy - 48,
                      left: item.screenMapPin!.dx - 40,
                      child: SizedBox(
                        height: 48,
                        width: 80,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                color: item.isSelected
                                    ? AppTheme.primaryColor
                                    : AppTheme.backgroundColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(24.0)),
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                    color: AppTheme.secondaryTextColor,
                                    blurRadius: 16,
                                    offset: Offset(4, 4),
                                  ),
                                ],
                              ),
                              child: Material(
                                color: Colors.transparent,
                                child: GestureDetector(
                                  behavior: HitTestBehavior.translucent,
                                  onTap: () {
                                    if (!item.isSelected) {
                                      for (var f in hotelList) {
                                        f.isSelected = false;
                                      }
                                      item.isSelected = true;
                                    }
                                    updateUI();
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8, right: 8, top: 4, bottom: 4),
                                    child: Text(
                                      "\$${item.perNight}",
                                      style: TextStyle(
                                        color: item.isSelected
                                            ? AppTheme.backgroundColor
                                            : AppTheme.primaryColor,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            IgnorePointer(
                              child: Container(
                                width: 1,
                                color: item.isSelected
                                    ? AppTheme.primaryColor
                                    : AppTheme.backgroundColor,
                                height: 13,
                              ),
                            ),
                            IgnorePointer(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  shape: BoxShape.circle,
                                ),
                                width: 4,
                                height: 4,
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  : SizedBox(),
          ],
        );
      },
    );
  }
}
