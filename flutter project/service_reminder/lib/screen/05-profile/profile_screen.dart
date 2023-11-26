import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:service_reminder/const.dart';
import 'package:service_reminder/0-models/user_models.dart';
import 'package:service_reminder/screen/02-login/login_screen.dart';
import 'package:service_reminder/services/app_database.dart';

import '../../controler/user_controller .dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    userList = userBox.values.toList();
    inputName.text = userList[0].name ?? '';
    inputNameCar.text = userList[0].nameCar ?? '';
    inputColor.text = userList[0].colorCar ?? '';
    inputYear.text = userList[0].year ?? '';
    inputPelak.text = userList[0].carNumber ?? '';
    inputShasi.text = userList[0].shasi ?? '';
    inputGovahi.text = userList[0].govahinameNumber ?? '';
    super.initState();
  }

  final inputName = TextEditingController();
  final inputNameCar = TextEditingController();
  final inputColor = TextEditingController();
  final inputYear = TextEditingController();
  final inputPelak = TextEditingController();
  final inputShasi = TextEditingController();
  final inputGovahi = TextEditingController();
  final UserController userController = Get.find<UserController>();
  var userBox = Hive.box<UserModels>(UserDb.boxNameUser);
  var userList = [];

  @override
  Widget build(BuildContext context) {
    var we = MediaQuery.of(context).size.width;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('پروفایل'),
          centerTitle: true,
        ),
        body: SafeArea(
            child: SingleChildScrollView(
          child: SizedBox(
            // height: double.infinity,
            width: double.infinity,
            // color: Colors.amber,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                space(),
                Container(
                    padding: const EdgeInsets.all(16),
                    // height: 300,
                    width: we < 500 ? we * 0.9 : 400,
                    // width: 300,
                    decoration: BoxDecoration(
                        color: Constants.bg2Color,
                        borderRadius: BorderRadius.circular(25)),
                    child: Column(
                      children: [
                        const IntroWidget(),
                        space(20),
                        userList[0].userName == 'test'
                            ? freeScreen()
                            : proScreen(),
                      ],
                    )),
              ],
            ),
          ),
        )),
      ),
    );
  }

  Column proScreen() {
    return Column(
      // crossAxisAlignment: CrossAxisAlignment.baseline,
      children: [
        Row(
          children: [
            const Text(
              'نام کاربری : ',
              style: TextStyle(),
            ),
            Text(
              userList[0].userName.toString(),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        space(),
        //! نام کاربری
        MyTextField(
            icon: Icons.person,
            lable: 'نام و فامیلی',
            textController: inputName),
        space(),
        //! نام کاربری
        MyTextField(
            icon: Icons.car_repair,
            lable: 'نام خودرو',
            textController: inputNameCar),
        space(),
        //! نام کاربری
        MyTextField(
            icon: Icons.color_lens, lable: 'رنگ', textController: inputColor),
        space(),
        //! نام کاربری
        MyTextField(
            icon: Icons.date_range,
            lable: 'سال ساخت',
            textController: inputYear),
        space(),
        //! نام کاربری
        MyTextField(
            icon: Icons.numbers, lable: 'پلاک', textController: inputPelak),
        space(),
        //! نام کاربری
        MyTextField(
            icon: Icons.abc, lable: 'شماره شاسی', textController: inputShasi),
        space(),
        //! نام کاربری
        MyTextField(
            icon: Icons.abc,
            lable: 'شماره گواهی نامه',
            textController: inputGovahi),

        space(),
        //! دکمه ورود
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(
                horizontal: 50,
              ),
              elevation: 8,
              backgroundColor: Constants.btnColor,
              foregroundColor: Colors.white),
          onPressed: () async {
            final updateUser =
                Hive.box<UserModels>(UserDb.boxNameUser).values.first.copyWith(
                      newName: inputName.text,
                      newNameCar: inputNameCar.text,
                      newColorCar: inputColor.text,
                      newYear: inputYear.text,
                      newCarNumber: inputPelak.text,
                      newShasi: inputShasi.text,
                      newGovahiname: inputGovahi.text,
                    );
            try {
              await Hive.box<UserModels>(UserDb.boxNameUser)
                  .putAt(0, updateUser);
              await userController.dbuser
                  .getAllSetData()
                  .then((List<dynamic>? data) {
                if (data != null) {
                  userController.getUser.value = data as List<UserModels>;
                }
              });
              Get.snackbar('', '',
                  titleText: const Text('ثبت اطلاعات',
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center),
                  messageText: const Text('اطلاعات با موفقیت بروزرسانی شد',
                      textAlign: TextAlign.right));
              navigator!.pop();
            } catch (e) {
              debugPrint('debug: $e');
              Get.snackbar('', '',
                  titleText: const Text('خطا',
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center),
                  messageText: const Text('اطلاعات ثبت نشد. مجدد تلاش کنید',
                      textAlign: TextAlign.right),
                  icon: const Icon(
                    Icons.error,
                    color: Colors.red,
                    size: 35,
                  ),
                  borderWidth: 1,
                  borderColor: Colors.red,
                  // borderRadius: 50,
                  snackPosition: SnackPosition.BOTTOM);
            }
          },
          child: const Text(
            'ثبت',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  Column freeScreen() {
    return Column(
      children: [
        space(30),
        const Text(
          "شما در حال استفاده از اکانت میهمان هستید.\nبرای ثبت نام و تکمیل پروفایل، لطفاً ابتدا یک اکانت کاربری بسازید و اطلاعات خود را به‌روز کنید.",
          style: TextStyle(fontSize: 16, height: 2),
        ),
        space(20),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(
                horizontal: 50,
              ),
              elevation: 8,
              backgroundColor: Constants.btnColor,
              foregroundColor: Colors.white),
          onPressed: () {
            Get.offAll(() => const LoginScreen());
          },
          child: const Text(
            'صفحه ورود',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        space(20),
      ],
    );
  }

  SizedBox space([double? height]) => SizedBox(height: height ?? 16.0);
}

class IntroWidget extends StatelessWidget {
  const IntroWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text.rich(
          textDirection: TextDirection.rtl,
          TextSpan(
            children: [
              TextSpan(
                text: "لطفا مشخصات را کامل کنید",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          textAlign: TextAlign.justify,
        ),
        SizedBox(height: 8),
        Row(
          children: <Widget>[
            Expanded(child: Divider()),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("اطلاعات حساب"),
            ),
            Expanded(child: Divider()),
          ],
        ),
      ],
    );
  }
}
