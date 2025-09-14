import 'package:flutter/material.dart';
import 'package:flutter_app/utils/text_styles.dart';
import 'package:flutter_app/utils/themes.dart';
import 'package:intl/intl.dart';

class CustomCalendarView extends StatefulWidget {
  final DateTime minimumDate;
  final DateTime maximumDate;
  final DateTime initialStartDate;
  final DateTime initialEndDate;
  final Function(DateTime, DateTime) startEndDateChange;

  const CustomCalendarView(
      {Key? key,
      required this.initialStartDate,
      required this.initialEndDate,
      required this.startEndDateChange,
      required this.minimumDate,
      required this.maximumDate})
      : super(key: key);

  @override
  _CustomCalendarViewState createState() => _CustomCalendarViewState();
}

class _CustomCalendarViewState extends State<CustomCalendarView> {
  List<DateTime> dateList = [];
  var currentMonthDate = DateTime.now();
  DateTime? startDate;
  DateTime? endDate;

  @override
  void initState() {
    setListOfDate(currentMonthDate);
    startDate = widget.initialStartDate;
    endDate = widget.initialEndDate;
    super.initState();
  }

  void setListOfDate(DateTime monthDate) {
    dateList.clear();
    var newDate = DateTime(monthDate.year, monthDate.month, 0);
    int privusMothDay = 0;
    if (newDate.weekday < 7) {
      privusMothDay = newDate.weekday;
      for (var i = 1; i <= privusMothDay; i++) {
        dateList.add(newDate.subtract(Duration(days: privusMothDay - i)));
      }
    }
    for (var i = 0; i < (42 - privusMothDay); i++) {
      dateList.add(newDate.add(Duration(days: i + 1)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Row(
            children: <Widget>[
              _getCircleUi(() {
                setState(() {
                  currentMonthDate = DateTime(currentMonthDate.year, currentMonthDate.month, 0);
                  setListOfDate(currentMonthDate);
                });
              }, Icons.keyboard_arrow_left),
              Expanded(
                child: Center(
                  child: Text(
                    DateFormat("MMMM, yyyy").format(currentMonthDate),
                    style: TextStyles(context).getRegularStyle().copyWith(fontSize: 20),
                  ),
                ),
              ),
              _getCircleUi(() {
                setState(() {
                  currentMonthDate = DateTime(currentMonthDate.year, currentMonthDate.month + 2, 0);
                  setListOfDate(currentMonthDate);
                });
              }, Icons.keyboard_arrow_right)
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 8, left: 8, bottom: 4),
          child: Row(
            children: getDaysNameUI(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 8, left: 8, bottom: 8),
          child: Column(
            children: getDaysNoUI(),
          ),
        ),
      ],
    );
  }

  Widget _getCircleUi(VoidCallback onTap, IconData icon) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 38,
        width: 38,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(24.0)),
          border: Border.all(color: Colors.grey),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.all(Radius.circular(24.0)),
            onTap: onTap,
            child: Icon(icon, color: Colors.grey),
          ),
        ),
      ),
    );
  }

  List<Widget> getDaysNameUI() {
    List<Widget> listUI = [];
    for (var i = 0; i < 7; i++) {
      listUI.add(
        Expanded(
          child: Center(
            child: Text(
              DateFormat("EEE").format(dateList[i]),
              style: TextStyles(context).getRegularStyle().copyWith(color: AppTheme.primaryColor),
            ),
          ),
        ),
      );
    }
    return listUI;
  }

  List<Widget> getDaysNoUI() {
    List<Widget> noList = [];
    var count = 0;
    for (var i = 0; i < dateList.length / 7; i++) {
      List<Widget> listUI = [];
      for (var i = 0; i < 7; i++) {
        final date = dateList[count];
        listUI.add(
          Expanded(
            child: AspectRatio(
              aspectRatio: 1.0,
              child: InkWell(
                onTap: () {
                  if (currentMonthDate.month == date.month) {
                    if (!date.isBefore(widget.minimumDate) && !date.isAfter(widget.maximumDate)) {
                      onDateClick(date);
                    }
                  }
                },
                child: Center(
                  child: Text(
                    "${date.day}",
                    style: TextStyles(context).getDescriptionStyle().copyWith(
                          color: getIsItStartAndEndDate(date)
                              ? AppTheme.primaryTextColor
                              : currentMonthDate.month == date.month
                                  ? AppTheme.primaryTextColor
                                  : AppTheme.secondaryTextColor,
                          fontWeight: getIsItStartAndEndDate(date) ? FontWeight.bold : FontWeight.normal,
                        ),
                  ),
                ),
              ),
            ),
          ),
        );
        count += 1;
      }
      noList.add(Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: listUI,
      ));
    }
    return noList;
  }

  bool getIsInRange(DateTime date) {
    if (startDate != null && endDate != null) {
      return date.isAfter(startDate!) && date.isBefore(endDate!);
    }
    return false;
  }

  bool getIsItStartAndEndDate(DateTime date) {
    if (startDate != null && startDate!.day == date.day && startDate!.month == date.month) return true;
    if (endDate != null && endDate!.day == date.day && endDate!.month == date.month) return true;
    return false;
  }

  void onDateClick(DateTime date) {
    if (startDate == null) {
      startDate = date;
    } else if (startDate != date && endDate == null) {
      endDate = date;
    } else if (startDate!.day == date.day && startDate!.month == date.month) {
      startDate = null;
    } else if (endDate!.day == date.day && endDate!.month == date.month) {
      endDate = null;
    }

    if (startDate == null && endDate != null) {
      startDate = endDate;
      endDate = null;
    }

    if (startDate != null && endDate != null) {
      if (!endDate!.isAfter(startDate!)) {
        var d = startDate;
        startDate = endDate;
        endDate = d;
      }
      if (date.isBefore(startDate!)) startDate = date;
      if (date.isAfter(endDate!)) endDate = date;
    }

    setState(() {
      widget.startEndDateChange(startDate!, endDate!);
    });
  }
}
