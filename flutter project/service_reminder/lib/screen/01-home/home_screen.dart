import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:service_reminder/0-models/save_data_model.dart';
import 'package:service_reminder/const.dart';
import 'package:service_reminder/controler/add_data_controllrr.dart';
import 'package:service_reminder/controler/home_controller%20.dart';
import 'package:service_reminder/controler/user_controller%20.dart';
import 'package:service_reminder/gen/assets.gen.dart';
import 'package:service_reminder/0-models/kilometr_model.dart';
import 'package:service_reminder/0-models/user_models.dart';
import 'package:service_reminder/screen/01-home/widget/dialogs.dart';
import 'package:service_reminder/services/app_database.dart';
import 'package:service_reminder/utils/convert.dart';
import 'package:shamsi_date/shamsi_date.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'widget/drawer.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
  static RxList<KilometrModel> km = <KilometrModel>[].obs;
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController controllerKMh = TextEditingController();
  TextEditingController controllerUp = TextEditingController();
  TextEditingController controllerDate = TextEditingController();
  TextEditingController controllerKmNowh = TextEditingController();
  TextEditingController controllerPrice = TextEditingController();
  TextEditingController controllerNote = TextEditingController();
  final HomeController homeController = Get.put(HomeController());
  final UserController userController = Get.put(UserController());
  final AddDataController addController = Get.put(AddDataController());
  var kMetrBox = Hive.box<KilometrModel>('kilometr');

  bool? isChecked;
  @override
  void initState() {
    var kmList = kMetrBox.values.toList();
    if (kmList.isEmpty) {
      kmList = [
        KilometrModel(
            kmetr: 0,
            change: 0,
            active: false,
            date: '${DateTime.now().toJalali().formatter.date}')
      ];
      kMetrBox.addAll(kmList);
    }
    HomeScreen.km.assignAll(kmList);
    controllerKMh.text = kmList.first.kmetr.toString();
    controllerUp.text = kmList.first.change.toString();
    isChecked = HomeScreen.km[0].active;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // var hi = MediaQuery.of(context).size.height;
    int addCtrlDataLenght = addController.getAddData.length;

    if (controllerKMh.text == '0') {
      controllerKMh.text = '0';
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showDialogs(context,
            start: false,
            isChecked: isChecked,
            controllerKM: controllerKMh,
            controllerUp: controllerUp,
            kMetrBox: kMetrBox,
            homeController: homeController);
      });
      // showDialogs(context,
      //     isChecked: isChecked,
      //     controllerKM: controllerKMh,
      //     controllerUp: controllerUp,
      //     kMetrBox: kMetrBox,
      //     homeController: homeController);
    } else if (HomeScreen.km[0].active!) {
      var lastDate = string2jalali(HomeScreen.km[0].date!);
      var today = Jalali.now();
      var result = today ^ lastDate;
      if (result > 0) {
        HomeScreen.km[0].kmetr += (HomeScreen.km[0].change) * result;
      }
    }
    final fontThem = Theme.of(context).textTheme;
    var mandeServic = '0';
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Constants.bg2Color,
        //! APPbAR
        appBar: AppBar(
          backgroundColor: Constants.bg2Color,
          title: Center(
            child: Text(
              'یادآور سرویس',
              style: fontThem.titleMedium,
            ),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  homeController.getAllData();
                },
                icon: const Icon(Icons.refresh))
          ],
        ),
        //! Drawer
        drawer: const MyDrawer(),
        //! body
        body: DoubleBackToCloseApp(
          //! duoble back exit app
          snackBar: const SnackBar(
            content: Row(
              children: [
                Text('برای خروج دوباره کلید برگشت را فشار دهید'),
                Spacer(),
                Icon(
                  Icons.redo,
                  color: Colors.white,
                )
              ],
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                //! kilometr
                kilometrWidget(context, fontThem),
                //! ListView
                FutureBuilder<List<dynamic>?>(
                    future: _getAllDataa(),
                    builder: (context, snapshot) {
                      //! نمایش لودینگ
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                        //! نمایش ارور
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');

                        //! اگر دیتا وجود داشت لیست زیر ایجاد میشود
                      } else if (snapshot.data != null &&
                          snapshot.data!.isNotEmpty) {
                        // homeController.getData.value =
                        //     snapshot.data!.cast<SetDataModel>();
                      }
                      return GetX<HomeController>(
                          init: HomeController(),
                          builder: (controller) {
                            RxList<AddDataModel> empty = <AddDataModel>[
                              AddDataModel(title: '', kmetr: '0', date: '')
                            ].obs;
                            return ListView.builder(
                              physics: const PageScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: controller.getData.length,
                              itemBuilder: (context, index) {
                                var addAmount = toInt(addController
                                    .getAddData[index].amount
                                    .toString());

                                var nextServic = '';
                                var endText = '';
                                var baseData = controller.getData[index];

                                var addDataValue = addAmount != 0
                                    ? addController.getAddData[index].title ==
                                            baseData.title
                                        ? addController.getAddData[index]
                                        : empty.first
                                    : empty.first;
                                MaterialColor? errorColor;
                                if (baseData.active) {
                                  //! اگر کیلومتر بود
                                  mandeServic = baseData.type == 'کیلومتر'
                                      ? (toInt(baseData.value
                                                  .replaceAll(',', '')) +
                                              toInt(addDataValue.kmetr!
                                                  .replaceAll(',', '')) -
                                              toInt(controllerKMh.text
                                                  .replaceAll(',', '')))
                                          .toString()
                                          .seRagham()
                                      // : '${Jalali(
                                      //     Jalali.now() ^
                                      //         Jalali(
                                      //           int.parse(oldDate[1]),
                                      //           int.parse(oldDate[2]),
                                      //         ),
                                      //   )}';

                                      //! اگر روز بود
                                      : addAmount != 0
                                          ? '${string2jalali(addDataValue.date!).addDays(toInt(baseData.value)) ^ Jalali.now()}'
                                          : '0';

                                  nextServic = (toInt(baseData.value
                                              .replaceAll(',', '')) +
                                          toInt(addDataValue.kmetr!
                                              .replaceAll(',', '')))
                                      .toString()
                                      .seRagham();
                                  endText = 'دیگر کار خواهد کرد';
                                  if (toInt(mandeServic.replaceAll(',', '')) <
                                      0) {
                                    errorColor = Colors.red;
                                    endText = 'به اتمام رسیده است';
                                    mandeServic = (toInt(mandeServic.replaceAll(
                                                ',', '')) *
                                            (-1))
                                        .toString()
                                        .seRagham();
                                  }
                                }
                                return Column(
                                  children: [
                                    // if (baseData.active)
                                    GestureDetector(
                                        onTap: () async {
                                          addData(context,
                                                  index: index,
                                                  title: baseData.title,
                                                  start: true,
                                                  controllerDate:
                                                      controllerDate,
                                                  controllerKmNow:
                                                      controllerKmNowh,
                                                  controllerNote:
                                                      controllerNote,
                                                  controllerPrice:
                                                      controllerPrice,
                                                  addController: addController,
                                                  baseData: baseData)
                                              .then((value) {
                                            if (value) {
                                              homeController.getAllData();
                                              setState(() {});
                                            }
                                          });
                                        },
                                        //! card
                                        child: !baseData.active
                                            ? const SizedBox()
                                            : Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 2),
                                                child: Mcard(
                                                  title: RichText(
                                                    text: TextSpan(
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodySmall!
                                                          .copyWith(
                                                              wordSpacing: -1),
                                                      //! line 1 card
                                                      children: <TextSpan>[
                                                        TextSpan(
                                                          text: baseData.title,
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: addAmount ==
                                                                    0
                                                                ? null
                                                                : errorColor,
                                                          ),
                                                        ),
                                                        TextSpan(
                                                          text: addAmount != 0
                                                              ? ' $mandeServic '
                                                              : null,
                                                          style: TextStyle(
                                                            color: errorColor,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 14,
                                                          ),
                                                        ),
                                                        TextSpan(
                                                            text: addAmount != 0
                                                                ? '${baseData.type} $endText'
                                                                : ' '),
                                                      ],
                                                    ),
                                                  ),
                                                  text1: RichText(
                                                    text: TextSpan(
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodySmall!
                                                          .copyWith(
                                                              letterSpacing: 0,
                                                              height: 1.8),
                                                      //! line 2 card
                                                      text: addAmount != 0
                                                          ? 'سرویس بعدی در'
                                                          : '',
                                                      children: <TextSpan>[
                                                        if (addCtrlDataLenght >
                                                            index)
                                                          TextSpan(
                                                            text: addAmount != 0
                                                                ? ' $nextServic '
                                                                : '',
                                                            style: TextStyle(
                                                                fontSize: 14,
                                                                color:
                                                                    errorColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        if (addAmount != 0)
                                                          TextSpan(
                                                              text:
                                                                  '${baseData.type}\n'),
                                                        //! line 3 card
                                                        TextSpan(
                                                          text: addAmount != 0
                                                              ? 'آخرین سرویس در '
                                                              : 'سرویس ثبت نشده است\nبرای ثبت اطلاعات اینجا کلیک کنید',
                                                          style: addAmount != 0
                                                              ? null
                                                              : const TextStyle(
                                                                  color: Colors
                                                                      .red,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                        ),
                                                        TextSpan(
                                                          text: addAmount == 0
                                                              ? ''
                                                              : '${addController.getAddData[index].date}',
                                                          style: TextStyle(
                                                              color: errorColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        if (addAmount != 0)
                                                          const TextSpan(
                                                            text: ' و ',
                                                          ),
                                                        if (addAmount != 0)
                                                          TextSpan(
                                                            text: addCtrlDataLenght <=
                                                                    index
                                                                ? '0'
                                                                : (addController
                                                                        .getAddData[
                                                                            index]
                                                                        .kmetr)
                                                                    .toString()
                                                                    .seRagham(),
                                                            style: TextStyle(
                                                                color:
                                                                    errorColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        if (addAmount != 0)
                                                          const TextSpan(
                                                            text: ' کیلومتر ',
                                                          ),
                                                      ],
                                                    ),
                                                  ),
                                                  //  'سرویس بعدی در ${nextServic} ${baseData.type} \nآخرین سرویس در ${sabt[index][0]} و ${sabt[index][1].toString().seRagham()} کیلومتر',
                                                  //! line 4 card
                                                  text2: Row(
                                                    children: [
                                                      const Text('زمان مفید'),
                                                      Text(
                                                        ' ${baseData.value.seRagham()}',
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            height: 1.8),
                                                      ),
                                                      Text(' ${baseData.type}'),
                                                      if (baseData.type ==
                                                          'روز')
                                                        if (toInt(baseData
                                                                    .value) /
                                                                30 >
                                                            1)
                                                          Text(
                                                              ' (${toInt(baseData.value) ~/ 30} ماه)'),
                                                      const Spacer(),
                                                      //! اگر اطلاعات ثبت شده بود دکمه نمایش داده شود
                                                      if (addAmount != 0)
                                                        BtnShowData(
                                                            index: index,
                                                            addController:
                                                                addController,
                                                            svgSrc: baseData
                                                                .srcName),
                                                    ],
                                                  ),
                                                  icon1: SvgGenImage(
                                                      'assets/svg/icons/${baseData.srcName}.svg'),
                                                  color: addAmount == 0
                                                      ? Colors.green.shade700
                                                      : errorColor ??
                                                          Colors.green.shade700,
                                                ),
                                              )),
                                    if (baseData.active) const MsizedBox(4),
                                    //! اگر فقط یک ایتم وجود داشت پیغام ظاهر شود
                                    if (controller.getData.length == 1)
                                      const SizedBox(height: 200),
                                    if (controller.getData.length == 1)
                                      Center(child: show1item(fontThem)),
                                  ],
                                );
                              },
                            );
                          });
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }

//! kilometr widget
  InkWell kilometrWidget(BuildContext context, TextTheme fontThem) {
    return InkWell(
      //! on tap kilometr
      onTap: () {
        showDialogs(context,
            isChecked: isChecked,
            controllerKM: controllerKMh,
            controllerUp: controllerUp,
            kMetrBox: kMetrBox,
            homeController: homeController);
      },
      //! getx kilometr
      child: Obx(() {
        return Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  blurRadius: 10,
                  offset: const Offset(4, 4),
                  color: Constants.bgColor.withOpacity(.5))
            ],
            color: Constants.bg3Color,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Colors.black26),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: 120,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Assets.svg.icons.oil.svg(
                        height: 35, color: Colors.black54, fit: BoxFit.cover),
                    Assets.svg.icons.oilFilter.svg(
                        width: 30, color: Colors.black54, fit: BoxFit.cover),
                    Assets.svg.icons.carFilter.svg(
                        width: 25, color: Colors.black54, fit: BoxFit.cover),
                  ],
                ),
              ),
              Column(
                children: [
                  //! line 1 kilometr
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'km',
                        style: fontThem.titleLarge,
                      ),
                      const MsizedBox(),
                      Text(
                        '${HomeScreen.km[0].kmetr}',
                        style: fontThem.displayLarge,
                      ),
                    ],
                  ),
                  //! line 2 kilometr --date
                  Text(
                    DateTime.now().toPersianDateStr(),
                    style: fontThem.titleMedium!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: 120,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Assets.svg.icons.batry.svg(
                        height: 30, color: Colors.black54, fit: BoxFit.cover),
                    Assets.svg.icons.discBrake.svg(
                        width: 30, color: Colors.black54, fit: BoxFit.cover),
                    Assets.svg.icons.timingBelt.svg(
                        width: 28, color: Colors.black54, fit: BoxFit.cover),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Future<List<dynamic>?> _getAllDataa() async {
    return await homeController.db.getAllSetData();
  }

//! نمایش پیغام اگر فقط یک ایتم تو لیست وجود داشت
  Container show1item(TextTheme fontThem) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                blurRadius: 10,
                offset: const Offset(4, 4),
                color: Constants.bgColor.withOpacity(.5))
          ],
          color: Constants.bg3Color,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: Colors.black26)),
      child: TextButton(
          onPressed: () async {
            await Hive.box<UserModels>(UserDb.boxNameUser).deleteAt(0);
          },
          child: Text(
            'برای نمایش یا پنهان کردن آیتم های مختلف و ویرایش آن به "تنظیمات پیشرفته" مراجعه کنید',
            style: fontThem.titleSmall!
                .copyWith(height: 1.9, color: Colors.black54),
          )),
    );
  }
}

class BtnShowData extends StatelessWidget {
  const BtnShowData({
    super.key,
    required this.addController,
    required this.index,
    required this.svgSrc,
  });

  final AddDataController addController;
  final int index;
  final String svgSrc;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  blurRadius: 6,
                  offset: const Offset(2, 3),
                  color: Constants.bgColor.withOpacity(.5))
            ],
            color: Constants.bg3Color,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Colors.black26)),
        child: const Text(
          'نمایش',
          style: TextStyle(fontSize: 10),
        ),
      ),
      onTap: () {
        Get.dialog(
          NewWidget(index: index, addController: addController, svgSrc: svgSrc),
        );
      },
    );
  }
}

//! نمایش اطلاعات ذخیره شده هر ایتم
class NewWidget extends StatefulWidget {
  const NewWidget({
    Key? key,
    required this.addController,
    required this.index,
    required this.svgSrc,
  }) : super(key: key);

  final AddDataController addController;
  final String? svgSrc;
  final int index;

  @override
  // ignore: library_private_types_in_public_api
  _NewWidgetState createState() => _NewWidgetState();
}

class _NewWidgetState extends State<NewWidget> {
  bool _showDate = false;
  bool _showKmetr = false;
  bool _showAmount = false;
  bool _showDescription = false;

  @override
  void initState() {
    super.initState();
    _startDelayedAnimations();
  }

  void _startDelayedAnimations() async {
    await Future.delayed(const Duration(seconds: 0));
    setState(() {
      _showDate = true;
    });

    await Future.delayed(const Duration(milliseconds: 600));
    setState(() {
      _showKmetr = true;
    });

    await Future.delayed(const Duration(milliseconds: 500));
    setState(() {
      _showAmount = true;
    });

    await Future.delayed(const Duration(milliseconds: 500));
    setState(() {
      _showDescription = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SizedBox(
        // width: MediaQuery.sizeOf(context).width,
        width: 150,
        child: AlertDialog(
          title: Row(
            children: [
              Text(widget.addController.getAddData[widget.index].title),
              const Spacer(),
              // SvgPicture.asset(assetName)
              SvgPicture.asset(
                  // 'assets/svg/icons/${Constants.icons[widget.index]}.svg',
                  'assets/svg/icons/${widget.svgSrc}.svg',
                  height: 36,
                  fit: BoxFit.cover),
            ],
          ),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (_showDate)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const SizedBox(width: 10.0, height: 30.0),
                    const Text(
                      'تاریخ : ',
                    ),
                    AnimatedTextKit(
                      totalRepeatCount: 1,
                      animatedTexts: [
                        TyperAnimatedText(
                          widget.addController.getAddData[widget.index].date!,
                          speed: const Duration(milliseconds: 100),
                        ),
                      ],
                    ),
                  ],
                ),
              if (_showKmetr)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const SizedBox(width: 10.0, height: 30.0),
                    const Text(
                      'کیلومتر : ',
                    ),
                    AnimatedTextKit(
                      totalRepeatCount: 1,
                      animatedTexts: [
                        TyperAnimatedText(
                          widget.addController.getAddData[widget.index].kmetr!
                              .seRagham(),
                          speed: const Duration(milliseconds: 100),
                        ),
                      ],
                    ),
                  ],
                ),
              if (_showAmount)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const SizedBox(width: 10.0, height: 30.0),
                    const Text(
                      'مبلغ : ',
                    ),
                    AnimatedTextKit(
                      totalRepeatCount: 1,
                      animatedTexts: [
                        TyperAnimatedText(
                          widget.addController.getAddData[widget.index].amount!
                              .seRagham(),
                          speed: const Duration(milliseconds: 100),
                        ),
                      ],
                    ),
                  ],
                ),
              if (_showDescription)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const SizedBox(width: 10.0, height: 30.0),
                    const Text(
                      'توضیحات : ',
                    ),
                    Expanded(
                      child: AnimatedTextKit(
                        totalRepeatCount: 1,
                        animatedTexts: [
                          TyperAnimatedText(
                            widget.addController.getAddData[widget.index]
                                .description!,
                            speed: const Duration(milliseconds: 80),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
            ],
          ),
          actions: [
            TextButton(
              child: const Text("بستن"),
              onPressed: () => Get.back(),
            ),
          ],
        ),
      ),
    );
  }
}

//! Mycard
class Mcard extends StatelessWidget {
  final Widget? text1, text2, title;
  final SvgGenImage? icon1;
  final IconData? icon2;
  final Color? color;
  final Color? bgCoror;
  final Function()? ontap;
  const Mcard(
      {super.key,
      required this.title,
      this.text1,
      this.text2,
      this.icon1,
      this.icon2,
      this.ontap,
      this.color,
      this.bgCoror});
  @override
  Widget build(BuildContext context) {
    final fontTheme = Theme.of(context).textTheme;
    return Card(
      color: bgCoror,
      child: ListTile(
        // leading: IconButton(onPressed: () {}, icon: Icon(CupertinoIcons.battery_0)),
        leading: icon1 == null
            ? null
            // ignore: deprecated_member_use_from_same_package
            : icon1!.svg(height: 36, color: color, fit: BoxFit.cover),
        title: title!,
        subtitle: text1 == null
            ? null
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [text1!, text2!],
              ),
        dense: true,
        titleTextStyle: fontTheme.titleSmall,
        horizontalTitleGap: 16,
        trailing: icon2 == null
            ? null
            : Icon(
                icon2,
                color: color,
                size: 35,
              ),
        onTap: ontap,
      ),
    );
  }
}
