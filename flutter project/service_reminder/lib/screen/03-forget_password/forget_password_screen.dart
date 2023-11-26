import 'package:flutter/material.dart';
import 'package:service_reminder/const.dart';
import 'package:service_reminder/screen/02-login/login_screen.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final inputName = TextEditingController();
  bool resetPas = false;
  @override
  Widget build(BuildContext context) {
    inputName.text = "mohsen";
    var we = MediaQuery.of(context).size.width;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('بازیابی رمز و نام کاربری'),
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
                            text2: 'برای بازیابی رمز، اطلاعات را وارد کنید',
                            // text1: 'میتوانید نام و رمز ورود را تغییر دهید. '
                          ),
                          space(),
                          //! نام کاربری
                          MyTextField(
                              icon: Icons.person_outline,
                              readonly: false,
                              lable: 'نام کاربری',
                              textController: inputName),
                          space(),
                          //! نام کاربری
                          MyTextField(
                              icon: Icons.help_center_outlined,
                              lable: 'یادآور رمز',
                              readonly: true,
                              textController: inputName),
                          space(),
                          //! نام کاربری
                          MyTextField(
                              icon: Icons.phone_android_outlined,
                              lable: 'تلفن',
                              textController: inputName),
                          space(), //! دکمه ورود
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                resetPas = true;
                              });
                            },
                            style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 50,
                                ),
                                elevation: 8,
                                backgroundColor: Constants.btnColor,
                                foregroundColor: Colors.white),
                            child: const Text(
                              'بازیابی رمز',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                          space(),
                          //! نام کاربری
                          Visibility(
                            visible: resetPas,
                            child: MyTextField(
                                readonly: true,
                                icon: Icons.lock_open_outlined,
                                lable: 'رمز ورود',
                                textController: inputName),
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
