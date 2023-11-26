import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart' as intl;
// import 'package:persian_datetimepickers/persian_datetimepickers.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:service_reminder/0-models/kilometr_model.dart';
import 'package:service_reminder/0-models/save_data_model.dart';
import 'package:service_reminder/0-models/set_data_model.dart';
import 'package:service_reminder/const.dart';
import 'package:service_reminder/controler/add_data_controllrr.dart';
import 'package:service_reminder/controler/home_controller%20.dart';
import 'package:service_reminder/screen/01-home/home_screen.dart';
import 'package:service_reminder/screen/01-home/widget/animated_alert_dialog.dart';
import 'package:service_reminder/screen/02-login/login_screen.dart';
import 'package:service_reminder/services/add_crud.dart';
import 'package:service_reminder/utils/convert.dart';
import 'package:service_reminder/utils/dialog_date.dart';
import 'package:shamsi_date/shamsi_date.dart';

//! دیالوگ مربوط به کیلومتر فعلی و اپدیت روزانه
void showDialogs(
  BuildContext context, {
  bool? start = true,
  required bool? isChecked,
  required TextEditingController controllerUp,
  required TextEditingController controllerKM,
  HomeController? homeController,
  required Box<KilometrModel> kMetrBox,
}) async {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  intl.NumberFormat numberFormat = intl.NumberFormat("#,###");
  await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
        controllerKM.text = controllerKM.text.seRagham();
        controllerUp.text = controllerUp.text.seRagham();
        return Directionality(
          textDirection: TextDirection.rtl,
          child: AnimatedAlertDialog(
            title: 'کیلومتر فعلی',
            content: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    autocorrect: true,
                    style: const TextStyle(
                        fontSize: 20.0, fontWeight: FontWeight.bold),
                    controller: controllerKM,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    maxLength: 12,
                    decoration: const InputDecoration(
                      labelText: 'عدد را وارد کنید',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (inp) {
                      if (inp == '') {
                        inp = '0';
                      }
                      String formatText = numberFormat.format(toInt(inp));
                      controllerKM.value = TextEditingValue(
                        text: formatText,
                        selection: controllerKM.selection,
                      );
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty || value == '0') {
                        return 'لطفاً یک مقدار معتبر وارد کنید';
                      }
                      return null; // اعتبارسنجی موفقیت آمیز بوده است
                    },
                  ),
                  const Divider(
                    thickness: 1,
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        isChecked = !isChecked!;
                      });
                    },
                    child: Row(
                      children: [
                        Checkbox(
                          value: isChecked,
                          onChanged: (value) {
                            setState(() {
                              isChecked = value!;
                            });
                          },
                        ),
                        const Text('بروزرسانی روزانه'),
                      ],
                    ),
                  ),
                  if (!isChecked!) const MsizedBox(),
                  AnimatedOpacity(
                    opacity: isChecked! ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 500),
                    child: Visibility(
                      visible: isChecked!,
                      child: Column(
                        children: [
                          const Text(
                            'روزانه چند کیلومتر رانندگی می کنید؟',
                            // style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const MsizedBox(),
                          TextField(
                            style: const TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.bold),
                            controller: controllerUp,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            maxLength: 9,
                            decoration: const InputDecoration(
                              labelText: 'عدد را وارد کنید',
                              border: OutlineInputBorder(),
                            ),
                            onChanged: (text) {
                              String formattedText =
                                  numberFormat.format(toInt(text));
                              controllerUp.value = TextEditingValue(
                                text: formattedText,
                                selection: controllerUp.selection,
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    elevation: 8,
                    backgroundColor: Constants.btnColor,
                    foregroundColor: Colors.white),
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    if (controllerKM.text.isNotEmpty) {
                      Navigator.of(context).pop();
                      HomeScreen.km.assign(KilometrModel(
                        kmetr: toInt(controllerKM.text.replaceAll(',', '')),
                        change: toInt(controllerUp.text.replaceAll(',', '')),
                        active: isChecked,
                        date: jalali2string(Jalali.now()),
                      ));
                      kMetrBox.put(
                        0,
                        KilometrModel(
                          kmetr: toInt(controllerKM.text.replaceAll(',', '')),
                          change: toInt(controllerUp.text.replaceAll(',', '')),
                          active: isChecked,
                          date: jalali2string(Jalali.now() - 2),
                        ),
                      );
                      homeController!.getAllData();
                    }
                  }
                },
                child: const Text('ثبت'),
              ),
              if (start == true)
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Constants.bg2Color,
                    elevation: 8,
                  ),
                  onPressed: () {
                    // controllerUp.dispose();
                    Navigator.of(context).pop();
                  },
                  child: const Text('انصراف'),
                ),
            ],
          ),
        );
      });
    },
  );
}

//! دیالوگ ثبت اطلاعات ایتم های لیست باکس
Future<bool> addData(
  BuildContext context, {
  bool? start = true,
  required int index,
  required String title,
  required SetDataModel baseData,
  required TextEditingController controllerDate,
  required TextEditingController controllerKmNow,
  required TextEditingController controllerPrice,
  required TextEditingController controllerNote,
  required AddDataController addController,
}) async {
  var addAmount = toInt(addController.getAddData[index].amount.toString());
  controllerDate.text = addAmount != 0
      ? addController.getAddData[index].date!
      : jalali2string(Jalali.now());
  controllerKmNow.text = addAmount != 0
      ? addController.getAddData[index].kmetr!.seRagham()
      : HomeScreen.km[0].kmetr.toString().seRagham();
  controllerPrice.text =
      addAmount != 0 ? addController.getAddData[index].amount!.seRagham() : '0';
  controllerNote.text =
      addAmount != 0 ? addController.getAddData[index].description! : '';
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool update = false;
  await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: SingleChildScrollView(
            child: AnimatedAlertDialog(
              //! عنوان دیالوگ
              title: title,
              content: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    //! تاریخ
                    MyTextField(
                      onTap: () async {
                        DateTime? date = await showPersianDatePicker(
                          isJalali: true,
                          context: context,
                        );
                        if (date != null) {
                          setState(() {
                            controllerDate.text =
                                jalali2string(Jalali.fromDateTime(date));
                          });
                        }
                      },
                      lable: 'برای انتخاب تاریخ کلیک کنید',
                      lableColor: Constants.btnColor,
                      enabled: true,
                      readonly: true,
                      textController: controllerDate,
                      textAlign: TextAlign.center,
                    ),
                    const MsizedBox(),
                    //! کیلومتر فعلی
                    MyTextField(
                      lable: 'کیلومتر فعلی',
                      textController: controllerKmNow,
                      validator: (value) {
                        if (value == null || value.isEmpty || value == '0') {
                          return 'لطفاً یک مقدار معتبر وارد کنید';
                        }
                        return null; // اعتبارسنجی موفقیت آمیز بوده است
                      },
                    ),
                    const MsizedBox(),
                    //! مبلغ سرویس
                    MyTextField(
                      lable: 'مبلغ سرویس',
                      keyboardType: TextInputType.number,
                      seRagham: true,
                      textController: controllerPrice,
                      validator: (value) {
                        if (value == null || value.isEmpty || value == '0') {
                          return 'لطفاً یک مقدار معتبر وارد کنید';
                        }
                        return null; // اعتبارسنجی موفقیت آمیز بوده است
                      },
                    ),
                    const MsizedBox(),
                    //! توضیحات
                    MyTextField(
                      lable: 'توضیحات',
                      textController: controllerNote,
                    ),
                    const MsizedBox(),
                  ],
                ),
              ),
              actions: [
                //! دکمه ثبت
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      elevation: 8,
                      backgroundColor: Constants.btnColor,
                      foregroundColor: Colors.white),
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      if (controllerKmNow.text.isNotEmpty) {
                        final box =
                            Hive.box<AddDataModel>(AddCRUDdb.boxAddName);
                        //! اگر از قبل اطلاعات موجود بود اطلاعات اپدیت شود

                        if (index < box.length) {
                          final updateData = box.values
                              .elementAt(index)
                              .copyWith(
                                newTitle: title,
                                newDate: controllerDate.text,
                                newAmount:
                                    controllerPrice.text.replaceAll(',', ''),
                                newKmetr:
                                    controllerKmNow.text.replaceAll(',', ''),
                                newDescription: controllerNote.text,
                              );
                          await box.putAt(index, updateData);
                          await addController.db
                              .getAllSetData()
                              .then((List<dynamic>? data) {
                            if (data != null) {
                              // setState(() {
                              addController.getAddData.value =
                                  data.cast<AddDataModel>();
                              addController.getData();
                              Navigator.of(context).pop();
                              update = true;
                              // });
                            }
                          });
                        }
                        //! اگر داده ای ثبت نبود اطلاعات جدید باید ذخیره شود
                        else {
                          addController.db.createTask(
                              data: AddDataModel(
                            title: title,
                            date: controllerDate.text,
                            amount: controllerPrice.text.replaceAll(',', ''),
                            kmetr: controllerKmNow.text.replaceAll(',', ''),
                            description: controllerNote.text,
                          ));
                          await addController.db
                              .getAllSetData()
                              .then((List<dynamic>? data) {
                            if (data != null) {
                              // setState(() {
                              addController.getAddData.value =
                                  data.cast<AddDataModel>();
                              addController.getData();
                            }
                          });
                          // ignore: use_build_context_synchronously
                          Navigator.of(context).pop();
                          update = true;
                          // عنصر در مقدار index وجود ندارد
                          // انجام عملیات مورد نظر
                        }
                      }
                    }
                  },
                  child: const Text('ثبت'),
                ),
                if (start == true)
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Constants.bg2Color,
                      elevation: 8,
                    ),
                    onPressed: () {
                      // controllerUp.dispose();

                      Navigator.of(context).pop();
                    },
                    child: const Text('انصراف'),
                  ),
              ],
            ),
          ),
        );
      });
    },
  );
  return update;
}
