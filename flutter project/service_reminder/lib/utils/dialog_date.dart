import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:service_reminder/const.dart';
import 'package:service_reminder/gen/fonts.gen.dart';
import 'package:shamsi_date/shamsi_date.dart';

Future<int?> showPersianDatePickerTimestamp({
  required BuildContext context,
  DateTime? initialDate,
  bool isJalali = true,
  // PersianDateTimeStyle? persianDateTimeStyle,
}) async {
  final picked = await showPersianDatePicker(
    context: context,
    initialDate: initialDate,
    isJalali: isJalali,
    // persianDateTimeStyle: persianDateTimeStyle,
  );

  return picked?.millisecondsSinceEpoch;
}

Future<DateTime?> showPersianDatePicker({
  required BuildContext context,
  DateTime? initialDate,
  bool isJalali = true,
  // PersianDateTimeStyle? persianDateTimeStyle,
}) async {
  DateTime? picked;
  // final style = persianDateTimeStyle ??= PersianDateTimeStyle(
  //   color: Theme.of(context).colorScheme.secondary,
  // )..saveButtonTextColor = Theme.of(context).colorScheme.secondary;

  int year = isJalali
      ? (initialDate == null
          ? Jalali.now().year
          : Jalali.fromDateTime(initialDate).year)
      : (initialDate == null
          ? Gregorian.now().year
          : Gregorian.fromDateTime(initialDate).year);

  int month = isJalali
      ? (initialDate == null
          ? Jalali.now().month
          : Jalali.fromDateTime(initialDate).month)
      : (initialDate == null
          ? Gregorian.now().month
          : Gregorian.fromDateTime(initialDate).month);

  int day = isJalali
      ? (initialDate == null
          ? Jalali.now().day
          : Jalali.fromDateTime(initialDate).day)
      : (initialDate == null
          ? Gregorian.now().day
          : Gregorian.fromDateTime(initialDate).day);

  await showDialog(
    context: context,
    builder: (context) {
      return Directionality(
        textDirection: TextDirection.ltr,
        child: AlertDialog(
          title: Text(
            isJalali ? 'انتخاب تاریخ' : 'Pick a date',
            // style: style.headingStyle,
            textAlign: TextAlign.center,
          ),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Constants.bg2Color,
                elevation: 8,
              ),
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pop();
              },
              child: Text(
                isJalali ? 'لغو' : 'Cancel',
                // style: style.cancelButtonTextStyle,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (isJalali) {
                  picked = Gregorian.fromJalali(Jalali(year, month, day))
                      .toDateTime();
                } else {
                  picked = DateTime(year, month, day);
                }

                Navigator.of(context, rootNavigator: true).pop();
              },
              style: ElevatedButton.styleFrom(
                  elevation: 8,
                  backgroundColor: Constants.btnColor,
                  foregroundColor: Colors.white),
              child: Text(
                isJalali ? 'ثبت' : 'Save',
                // style: style.saveButtonTextStyle,
              ),
            ),
          ],
          content: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Directionality(
              textDirection: isJalali ? TextDirection.ltr : TextDirection.rtl,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          isJalali ? 'سال' : 'Year',
                          // style: style.titleStyle,
                        ),
                        Theme(
                          data: ThemeData(
                              primarySwatch: Colors.deepPurple,
                              fontFamily: FontFamily.sans),
                          child: NumberPicker(
                            haptics: true,
                            infiniteLoop: true,
                            value: year,
                            textStyle: const TextStyle(color: Colors.grey),
                            // textStyle: style.numbersStyle,
                            minValue: isJalali ? 1300 : 1900,
                            maxValue: isJalali ? 1500 : 2100,
                            onChanged: (value) => setState(() => year = value),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 28),
                    child: const Text(
                      '/',
                      style: TextStyle(color: Colors.black),
                      // style: style.numbersStyle,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          isJalali ? 'ماه' : 'Month',
                          // style: style.titleStyle,
                        ),
                        Theme(
                          data: ThemeData(
                              primarySwatch: Colors.deepPurple,
                              fontFamily: FontFamily.sans),
                          child: NumberPicker(
                            value: month,
                            textStyle: const TextStyle(color: Colors.grey),
                            // textStyle: style.numbersStyle,
                            minValue: 1,
                            maxValue: 12,
                            onChanged: (value) => setState(() => month = value),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 28),
                    child: const Text(
                      '/',
                      style: TextStyle(color: Colors.black),
                      // style: style.numbersStyle,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          isJalali ? 'روز' : 'Day',

                          // style: style.titleStyle,
                        ),
                        Theme(
                          data: ThemeData(
                              primarySwatch: Colors.deepPurple,
                              fontFamily: FontFamily.sans),
                          child: NumberPicker(
                            value: day,
                            textStyle: const TextStyle(color: Colors.grey),
                            // textStyle: style.numbersStyle,
                            minValue: 1,
                            maxValue: 31,
                            onChanged: (value) => setState(() => day = value),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      );
    },
  );

  return picked;
}
