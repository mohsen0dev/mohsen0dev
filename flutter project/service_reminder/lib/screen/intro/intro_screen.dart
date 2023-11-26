import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:service_reminder/0-models/save_data_model.dart';
import 'package:service_reminder/0-models/set_data_model.dart';
import 'package:service_reminder/controler/add_data_controllrr.dart';
import 'package:service_reminder/controler/home_controller%20.dart';
import 'package:service_reminder/controler/user_controller%20.dart';
import 'package:service_reminder/gen/assets.gen.dart';
import 'package:service_reminder/main.dart';
import 'package:service_reminder/0-models/user_models.dart';
import 'package:service_reminder/screen/02-login/login_screen.dart';
import 'package:service_reminder/services/app_database.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  OnBoardingPageState createState() => OnBoardingPageState();
}

class OnBoardingPageState extends State<OnBoardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();
  final HomeController homeController = Get.put(HomeController());
  final UserController userController = Get.put(UserController());
  final AddDataController addController = Get.put(AddDataController());
  var userBox = Hive.box<UserModels>(UserDb.boxNameUser);
  List<UserModels> userList = [];
  bool isAcont = true;

  @override
  void initState() {
    userList = userBox.values.toList();
    if (userList.isEmpty) {
      userList = [
        UserModels(
          userName: 'test',
        )
      ];
      userBox.addAll(userList);
    }
    userController.getUser.assignAll(userList);
    super.initState();
  }

  void _onIntroEnd() async {
    await Get.off(() => const LoginScreen());
  }

//! logo
  Widget _buildImage(String assetName, [double width = 350]) {
    // return SvgPicture.asset('assets/svg/intro/bakup.svg', width: width);
    return Image.asset('assets/images/$assetName.png', width: width);
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 18.0);

    const pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(fontSize: 25.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return Scaffold(
      body: IntroductionScreen(
        key: introKey,
        globalBackgroundColor: Colors.white,
        allowImplicitScrolling: false,
        autoScrollDuration: 6000,
        infiniteAutoScroll: false,
        globalHeader: Align(
          alignment: Alignment.topRight,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top: 15, right: 15),
              child: _buildImage('logo', 80),
            ),
          ),
        ),
        pages: [
          PageViewModel(
            title: "ثبت نام",
            body:
                'جهت حفاظت از اطلاعات و جلوگیری از دسترسی اشخاص غیرمجاز، میتوانید ثبت نام نمایید',
            image: Padding(
              padding: const EdgeInsets.only(top: 60),
              child: _buildImage('intro/login'),
            ),
            // image: _buildImage('img1.jpg'),
            decoration: pageDecoration,
          ),
          PageViewModel(
            title: "استفاده آسان",
            body:
                "استفاده آسان از برنامه و دسترسی آسان به تنظیمات برای تغییر اطلاعات",
            image: Padding(
              padding: const EdgeInsets.only(top: 50),
              child: _buildImage('intro/easy_us'),
            ),
            // image: Assets.images.logo.image(width: 300),
            decoration: pageDecoration,
          ),
          PageViewModel(
            title: "تم تیره یا روشن",
            body:
                "انتخاب تم تاریک یا روشن برای راحتی چشم در شب یا روز، وابسته به ترجیحات شما و شرایط محیطی است.",
            image: Padding(
              padding: const EdgeInsets.only(top: 50),
              child: _buildImage('intro/dark_mode'),
            ),

            // image: Assets.images.logo.image(width: 300),
            decoration: pageDecoration,
          ),
          PageViewModel(
            title: "پشتیبان‌گیری و بازیابی",
            body:
                "امکان ذخیره‌سازی اطلاعات با ایجاد فایل پشتیبان و امکان بازیابی آسان در مواقع نیاز",
            image: _buildImage('intro/bakup'),
            // image: Assets.images.logo.image(width: 300),

            decoration: pageDecoration.copyWith(
              bodyFlex: 4,
              imageFlex: 4,
              safeArea: 40,
            ),
          ),
          PageViewModel(
            title: "امیدوارم از برنامه لذت ببرید و برایتان مفید باشد",
            bodyWidget: const Text(''),
            decoration: pageDecoration.copyWith(
              bodyFlex: 4,
              imageFlex: 5,
              bodyAlignment: Alignment.bottomCenter,
              imageAlignment: Alignment.topCenter,
            ),
            // image: _buildImage('img1.jpg'),
            image: Assets.images.logo.image(width: 250),
            reverse: true,
          ),
        ],
        onDone: () {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            introKey.currentState?.animateScroll(4);
            saveToHive(true);
            addController.addData(AddDataModel(
                title: 'روغن موتور',
                amount: '0',
                date: '',
                kmetr: '0',
                description: ''));
            homeController.addData(
              const SetDataModel(
                  title: 'روغن موتور',
                  active: true,
                  type: 'کیلومتر',
                  srcName: 'oil',
                  value: '7000'),
            );
            addController.addData(AddDataModel(
                title: 'فیلتر روغن',
                amount: '0',
                date: '',
                kmetr: '0',
                description: ''));
            homeController.addData(
              const SetDataModel(
                  title: 'فیلتر روغن',
                  active: true,
                  type: 'کیلومتر',
                  srcName: 'oil_filter',
                  value: '7000'),
            );
            addController.addData(AddDataModel(
                title: 'فیلتر هوا',
                amount: '0',
                date: '',
                kmetr: '0',
                description: ''));
            homeController.addData(
              const SetDataModel(
                  title: 'فیلتر هوا',
                  active: true,
                  type: 'کیلومتر',
                  srcName: 'car-filter',
                  value: '14000'),
            );
            addController.addData(AddDataModel(
                title: 'فیلتر کابین',
                amount: '0',
                date: '',
                kmetr: '0',
                description: ''));
            homeController.addData(
              const SetDataModel(
                  title: 'فیلتر کابین',
                  active: true,
                  type: 'کیلومتر',
                  srcName: 'air-filter',
                  value: '14000'),
            );
            addController.addData(AddDataModel(
                title: 'ضد یخ',
                amount: '0',
                date: '',
                kmetr: '0',
                description: ''));
            homeController.addData(
              const SetDataModel(
                  title: 'ضد یخ',
                  active: true,
                  type: 'کیلومتر',
                  srcName: 'antifreeze',
                  value: '40000'),
            );
            addController.addData(AddDataModel(
                title: 'شمع',
                amount: '0',
                date: '',
                kmetr: '0',
                description: ''));
            homeController.addData(
              const SetDataModel(
                  title: 'شمع',
                  active: true,
                  type: 'کیلومتر',
                  srcName: 'spark-plug',
                  value: '40000'),
            );
            addController.addData(AddDataModel(
                title: 'باتری',
                amount: '0',
                date: '',
                kmetr: '0',
                description: ''));
            homeController.addData(
              const SetDataModel(
                  title: 'باتری',
                  active: true,
                  type: 'روز',
                  srcName: 'batry',
                  value: '1095'),
            );
            addController.addData(AddDataModel(
                title: 'تسمه تایم',
                amount: '0',
                date: '',
                kmetr: '0',
                description: ''));
            homeController.addData(
              const SetDataModel(
                  title: 'تسمه تایم',
                  active: true,
                  type: 'کیلومتر',
                  srcName: 'timing-belt',
                  value: '40000'),
            );
            addController.addData(AddDataModel(
                title: 'تسمه دینام',
                amount: '0',
                date: '',
                kmetr: '0',
                description: ''));
            homeController.addData(
              const SetDataModel(
                  title: 'تسمه دینام',
                  active: true,
                  type: 'کیلومتر',
                  srcName: 'ac_belt',
                  value: '60000'),
            );
            addController.addData(AddDataModel(
                title: 'لنت ترمز',
                amount: '0',
                date: '',
                kmetr: '0',
                description: ''));
            homeController.addData(
              const SetDataModel(
                  title: 'لنت ترمز',
                  active: true,
                  type: 'کیلومتر',
                  srcName: 'disc-brake',
                  value: '20000'),
            );
            addController.addData(AddDataModel(
                title: 'روغن ترمز',
                amount: '0',
                date: '',
                kmetr: '0',
                description: ''));
            homeController.addData(
              const SetDataModel(
                  title: 'روغن ترمز',
                  active: true,
                  type: 'کیلومتر',
                  srcName: 'brake-oil',
                  value: '40000'),
            );
            addController.addData(AddDataModel(
                title: 'تایر',
                amount: '0',
                date: '',
                kmetr: '0',
                description: ''));
            homeController.addData(
              const SetDataModel(
                  title: 'تایر',
                  active: true,
                  type: 'کیلومتر',
                  srcName: 'taire',
                  value: '60000'),
            );
            addController.addData(AddDataModel(
                title: 'بیمه ثالث',
                amount: '0',
                date: '',
                kmetr: '0',
                description: ''));
            homeController.addData(
              const SetDataModel(
                  title: 'بیمه ثالث',
                  active: true,
                  type: 'روز',
                  srcName: 'insurance',
                  value: '365'),
            );
            addController.addData(AddDataModel(
                title: 'بیمه بدنه',
                amount: '0',
                date: '',
                kmetr: '0',
                description: ''));
            homeController.addData(
              const SetDataModel(
                  title: 'بیمه بدنه',
                  active: true,
                  type: 'روز',
                  srcName: 'car-insurance',
                  value: '365'),
            );

            _onIntroEnd();
          });
          // Future.delayed(Duration(milliseconds: 500), () {
          //   saveToHive(true);
          //   _onIntroEnd();
          // });
        },
        // onDone: () {
        //   WidgetsBinding.instance.addPostFrameCallback((_) {
        //     if (introKey.currentState!.widget!.length == 4) {
        //       introKey.currentState?.animateScroll(4);
        //       saveToHive(true);
        //       _onIntroEnd();
        //     }
        //   });
        // },
        onSkip: () {
          introKey.currentState?.animateScroll(4);
        }, // You can override onSkip callback
        showSkipButton: true,
        skipOrBackFlex: 0,
        nextFlex: 0,
        showBackButton: false,
        //rtl: true, // Display as right-to-left
        back: const Icon(Icons.arrow_back),
        skip: const Text('رد کردن',
            style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Color.fromARGB(255, 181, 143, 247))),
        next: const Icon(Icons.arrow_forward,
            color: Color.fromARGB(255, 174, 132, 247)),
        done: const Text('انجام شد',
            style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Color.fromARGB(255, 181, 143, 247))),
        curve: Curves.fastLinearToSlowEaseIn,
        controlsMargin: const EdgeInsets.all(5),
        controlsPadding: const EdgeInsets.all(12.0),

        dotsDecorator: const DotsDecorator(
          size: Size(10.0, 10.0),
          color: Color(0xFFBDBDBD),
          activeSize: Size(32.0, 10.0),
          activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
          ),
        ),
        dotsContainerDecorator: const ShapeDecoration(
          color: Colors.black87,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
        ),
      ),
    );
  }
}
