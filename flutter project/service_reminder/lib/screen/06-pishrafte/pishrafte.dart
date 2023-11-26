import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:service_reminder/const.dart';
import 'package:service_reminder/controler/home_controller%20.dart';
import 'package:service_reminder/0-models/set_data_model.dart';
import 'package:service_reminder/screen/01-home/home_screen.dart';
import 'package:service_reminder/screen/02-login/login_screen.dart';

class PishrafteScreen extends StatefulWidget {
  const PishrafteScreen({super.key});

  @override
  State<PishrafteScreen> createState() => _PishrafteScreenState();
}

class _PishrafteScreenState extends State<PishrafteScreen> {
  HomeController homeController = Get.find<HomeController>();
  TextEditingController controllerT = TextEditingController();
  int _selectedValue = 1;

  String typeVahed = "";
  @override
  Widget build(BuildContext context) {
    // controller.text = '1000';

    var we = MediaQuery.of(context).size.width;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Constants.bg2Color,
        //! appbar
        appBar: AppBar(
          backgroundColor: Constants.bg2Color,
          title: const Text('تنظیمات پیشرفته'),
          centerTitle: true,
        ),
        body: SafeArea(
            child: SingleChildScrollView(
          child: SizedBox(
            // height: double.infinity,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                space(),
                //! intro
                const IntroWidget(
                    text1:
                        'برای تغییر زمان مفید هر آیتم، آن را انتخاب و ویرایش کنید',
                    text3: 'ویرایش اطلاعات'),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 12),
                  width: we < 500 ? we * 0.98 : 400,
                  decoration: BoxDecoration(
                      // color: Constants.bg3Color,
                      borderRadius: BorderRadius.circular(25)),
                  //! list
                  child: GetX<HomeController>(
                    init: HomeController(),
                    builder: (controller) {
                      return GridView.builder(
                        physics: const PageScrollPhysics(),
                        shrinkWrap: true,
                        // itemCount: HomeScreen.setData.length,
                        itemCount: homeController.getData.length,
                        itemBuilder: (context, index) {
                          // var data = HomeScreen.setData[index];
                          var data = homeController.getData[index];
                          return GestureDetector(
                            //! on tap item
                            //! dialog
                            onTap: () async {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  controllerT.text = data.value.seRagham();
                                  if (data.type == 'روز') {
                                    _selectedValue = 2;
                                    typeVahed = 'روز';
                                  } else {
                                    _selectedValue = 1;
                                    typeVahed = 'کیلومتر';
                                  }
                                  return Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: StatefulBuilder(builder:
                                        (BuildContext context,
                                            StateSetter setState) {
                                      return AlertDialog(
                                        //! title dialog
                                        title: Text(
                                          data.title,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium,
                                        ),
                                        //! inpute and radio
                                        content: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            MyTextField(
                                              icon: null,
                                              seRagham: true,
                                              lable: 'زمان مفید به $typeVahed',
                                              textController: controllerT,
                                              txtaction: TextInputAction.send,
                                              keyboardType:
                                                  TextInputType.number,
                                            ),
                                            Row(
                                              children: [
                                                Radio(
                                                  value: 1,
                                                  groupValue: _selectedValue,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      typeVahed = 'کیلومتر';
                                                      _selectedValue = value!;
                                                    });
                                                  },
                                                ),
                                                const Text('کیلومتر'),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Radio(
                                                  value: 2,
                                                  groupValue: _selectedValue,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      _selectedValue = value!;
                                                      typeVahed = 'روز';
                                                    });
                                                  },
                                                ),
                                                const Text('روز'),
                                              ],
                                            ),
                                          ],
                                        ),
                                        //! button save and cancell
                                        actionsAlignment:
                                            MainAxisAlignment.center,
                                        actions: [
                                          ElevatedButton(
                                            onPressed: () async {
                                              await updateData(
                                                  data, data.active, index);
                                              // ignore: use_build_context_synchronously
                                              Navigator.of(context).pop();
                                            },
                                            style: ElevatedButton.styleFrom(
                                                elevation: 8,
                                                backgroundColor:
                                                    Constants.btnColor,
                                                foregroundColor: Colors.white),
                                            child: const Text('ذخیره'),
                                          ),
                                          ElevatedButton(
                                            onPressed: () {
                                              Get.back();
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  Constants.bg2Color,
                                              elevation: 8,
                                            ),
                                            child: const Text('انصراف'),
                                          ),
                                        ],
                                      );
                                    }),
                                  );

                                  //!
                                },
                              );
                            },
                            //! card item
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 5),
                              decoration: BoxDecoration(
                                  color:
                                      data.active ? Colors.white : Colors.grey,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(25)),
                                  border: Border.all(color: Colors.black26),
                                  boxShadow: [
                                    BoxShadow(
                                        color:
                                            Constants.btnColor.withOpacity(.5),
                                        blurRadius: 9,
                                        offset: const Offset(4, 3),
                                        spreadRadius: 1)
                                  ]),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      CupertinoSwitch(
                                          thumbColor: Constants.bg3Color,
                                          activeColor: Constants.bgColor,
                                          trackColor: Colors.black,
                                          value: data.active,
                                          onChanged: (value) async {
                                            await updateData(
                                                data, value, index, true);
                                          }),
                                      SvgPicture.asset(
                                          'assets/svg/icons/${data.srcName}.svg',
                                          height: 55),
                                    ],
                                  ),
                                  Expanded(
                                    child: Mcard(
                                      bgCoror: data.active
                                          ? Colors.white
                                          : Colors.grey,
                                      title: Text(
                                        'زمان استاندارد تعویض ${data.title} هر ${data.value.seRagham()} ${data.type} می باشد',
                                        style: const TextStyle(fontSize: 12),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 200,
                                childAspectRatio: 7 / 6,
                                crossAxisSpacing: 20,
                                mainAxisSpacing: 15),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        )),
      ),
    );
  }

  Future<void> updateData(SetDataModel data, bool value, int index,
      [bool onOff = false]) async {
    final updateData = Hive.box<SetDataModel>('setData')
        .values
        .firstWhere((element) {
      return data.title == element.title;
    }).copyWith(
            newTitle: data.title,
            newActive: value,
            newType: onOff ? data.type : typeVahed,
            newValue: onOff ? data.value : controllerT.text);
    await Hive.box<SetDataModel>('setData').putAt(index, updateData);
    homeController.getData.value =
        await homeController.db.getAllSetData() as List<SetDataModel>;

    // await homeController.db.getAllSetData().then((List<dynamic>? data) {
    //   if (data != null) {
    //     setState(() {
    //       homeController.getData.value = data.cast<SetDataModel>();
    //     });
    //   }
    // });
  }

  SizedBox space([double? height]) => SizedBox(height: height ?? 16.0);
}
