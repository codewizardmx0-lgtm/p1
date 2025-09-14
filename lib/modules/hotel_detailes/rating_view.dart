import 'package:flutter/material.dart';
import 'package:flutter_app/utils/text_styles.dart';
import 'package:flutter_app/utils/themes.dart';
import 'package:flutter_app/widgets/common_card.dart';
import '../../models/hotel_list_data.dart';

class RatingView extends StatelessWidget {
  final HotelListData hotelData;

  const RatingView({Key? key, required this.hotelData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CommonCard(
      color: AppTheme.backgroundColor,
      radius: 16,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                SizedBox(
                  width: 60,
                  child: Text(
                    (hotelData.rating * 2).toStringAsFixed(1),
                    textAlign: TextAlign.left,
                    style: TextStyles(context).getBoldStyle().copyWith(
                          fontSize: 38,
                          color: Theme.of(context).primaryColor,
                        ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Overall Rating", // نص مؤقت بدل AppLocalizations
                          textAlign: TextAlign.left,
                          style: TextStyles(context).getRegularStyle().copyWith(
                                fontSize: 14,
                                color: Theme.of(context)
                                    .disabledColor
                                    .withOpacity(0.8),
                              ),
                        ),
                        // يمكنك إضافة النجوم هنا إذا أحببت
                      ],
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 4),
            getBarUI('Room', 95.0, context),
            SizedBox(height: 4),
            getBarUI('Service', 80.0, context),
            SizedBox(height: 4),
            getBarUI('Location', 65.0, context),
            SizedBox(height: 4),
            getBarUI('Price', 85, context),
          ],
        ),
      ),
    );
  }

  Widget getBarUI(String text, double percent, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          width: 60,
          child: Text(
            text, // نص مؤقت بدل AppLocalizations
            textAlign: TextAlign.left,
            style: TextStyles(context).getRegularStyle().copyWith(
                  fontSize: 14,
                  color: Theme.of(context).disabledColor.withOpacity(0.8),
                ),
          ),
        ),
        SizedBox(width: 8),
        Expanded(
          child: Row(
            children: <Widget>[
              Expanded(
                flex: percent.toInt(),
                child: Padding(
                  padding: const EdgeInsets.only(top: 2),
                  child: SizedBox(
                    height: 4,
                    child: CommonCard(
                      color: AppTheme.primaryColor,
                      radius: 8,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 100 - percent.toInt(),
                child: SizedBox(),
              )
            ],
          ),
        )
      ],
    );
  }
}
