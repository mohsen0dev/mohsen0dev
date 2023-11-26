import 'package:flutter/material.dart';
import 'package:service_reminder/const.dart';
import 'package:service_reminder/screen/02-login/login_screen.dart';
// import 'package:service_reminder/screen/profile/profile_screen.dart';
// import 'package:service_reminder/screen/login/login_screen.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  // bool _saveLoginInfo = false;
  final inputName = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var we = MediaQuery.of(context).size.width;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('تغییر رمز و نام کاربری'),
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
                          const IntroWidget(
                              text2: 'برای امنیت بیشتر از رمز قوی استفاده کنید',
                              text1: 'میتوانید نام و رمز ورود را تغییر دهید. '),
                          space(),
                          //! نام کاربری
                          MyTextField(
                              obstxt: true,
                              icon: Icons.lock_open_outlined,
                              lable: 'رمز قبلی',
                              textController: inputName),
                          space(),
                          //! نام کاربری
                          MyTextField(
                              icon: Icons.person_outline,
                              lable: 'نام کاربری',
                              textController: inputName),
                          space(),
                          //! نام کاربری
                          MyTextField(
                              icon: Icons.phone_android_outlined,
                              lable: 'تلفن',
                              textController: inputName),
                          space(),
                          //! نام کاربری
                          MyTextField(
                              obstxt: true,
                              icon: Icons.lock_open_outlined,
                              lable: 'رمز ورود',
                              textController: inputName),
                          space(),
                          //! نام کاربری
                          MyTextField(
                              obstxt: true,
                              icon: Icons.lock_open_outlined,
                              lable: 'تکرار رمز ورود',
                              textController: inputName),
                          space(),
                          //! نام کاربری
                          MyTextField(
                              icon: Icons.help_center_outlined,
                              lable: 'یادآور رمز',
                              textController: inputName),
                          space(),
                          //! دکمه ورود
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 50,
                                ),
                                elevation: 8,
                                backgroundColor: Constants.btnColor,
                                foregroundColor: Colors.white),
                            child: const Text(
                              'ثبت',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  SizedBox space([double? height]) => SizedBox(height: height ?? 16.0);
}
