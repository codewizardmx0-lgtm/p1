import 'package:flutter/material.dart';
import 'package:flutter_app/models/room_data.dart';
import 'package:flutter_app/utils/themes.dart';

class Helper {
  // نص ثابت للغرف والأشخاص
  static String getRoomText(RoomData roomData) {
    return "${roomData.numberRoom} room(s), ${roomData.people} person(s)";
  }

  // نص ثابت للتواريخ
  static String getDateText(DateText dateText) {
    // نعرض اليوم والشهر من التاريخ الأول فقط
    return "${dateText.startDate}";
  }

  static String getLastSearchDate(DateText dateText) {
    // نعرض التاريخ الأول فقط
    return "${dateText.startDate}";
  }

  static String getPeopleandChildren(RoomData roomData) {
    return "Sleeps ${roomData.numberRoom} people + ${roomData.numberRoom} children";
  }

  // نجوم التقييم بدون مكتبة خارجية
  static Widget ratingStar({double rating = 4.5}) {
    int fullStars = rating.floor();
    bool halfStar = (rating - fullStars) >= 0.5;
    int emptyStars = 5 - fullStars - (halfStar ? 1 : 0);

    List<Widget> stars = [];

    for (int i = 0; i < fullStars; i++) {
      stars.add(Icon(Icons.star, color: AppTheme.primaryColor, size: 18));
    }

    if (halfStar) {
      stars.add(Icon(Icons.star_half, color: AppTheme.primaryColor, size: 18));
    }

    for (int i = 0; i < emptyStars; i++) {
      stars.add(Icon(Icons.star_border, color: AppTheme.secondaryTextColor, size: 18));
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: stars,
    );
  }

  // نافذة حوارية ثابتة
  Future<bool> showCommonPopup(
      String title, String descriptionText, BuildContext context,
      {bool isYesOrNoPopup = false, bool barrierDismissible = true}) async {
    bool isOkClick = false;
    return await showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) => AlertDialog(
        title: Text(title),
        content: Text(descriptionText),
        actions: isYesOrNoPopup
            ? <Widget>[
                TextButton(
                  child: Text("NO"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: Text("YES"),
                  onPressed: () {
                    isOkClick = true;
                    Navigator.of(context).pop();
                  },
                )
              ]
            : <Widget>[
                TextButton(
                  child: Text("OK"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
      ),
    ).then((_) {
      return isOkClick;
    });
  }
}
