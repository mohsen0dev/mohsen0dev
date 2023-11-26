import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:service_reminder/const.dart';
import 'package:service_reminder/controler/user_controller%20.dart';
import 'package:service_reminder/gen/assets.gen.dart';
import 'package:service_reminder/0-models/user_models.dart';
import 'package:service_reminder/screen/03-forget_password/forget_password_screen.dart';
import 'package:service_reminder/screen/01-home/home_screen.dart';
import 'package:service_reminder/services/app_database.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _saveLoginInfo = false.obs, logIn = false.obs, obscureText = true.obs;
  String sabnam = '', txtbtn = '';
  final inputName = TextEditingController();
  final inputPass = TextEditingController();
  final inputPas2 = TextEditingController();
  final inputMobile = TextEditingController();
  final inputEmail = TextEditingController();
  final inputHelp = TextEditingController();
  final focusName = FocusNode();
  final focusPass = FocusNode();
  final UserController userController = Get.put(UserController());
  var userBox = Hive.box<UserModels>(UserDb.boxNameUser);
  List<UserModels> userList = [];
  bool isAcont = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
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
    inputName.text = userList.first.userName.toString();
  }

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
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

      inputName.text = userList.first.userName.toString();
      if (userList.first.remember == true) {
        inputPass.text = userList.first.password.toString();
        _saveLoginInfo.value = true;
        setState(() {});
      }
    });
    super.initState();
  }

//! sing in button
  void singInPressedFunction() async {
    if (inputName.text.isEmpty) {
      Get.snackbar(
        borderWidth: 1,
        borderColor: Colors.red,
        icon: const Icon(
          Icons.error,
          color: Colors.red,
          size: 35,
        ),
        '',
        '',
        titleText: const Text('خطا',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
            textAlign: TextAlign.center),
        messageText: const Text('لطفا نام کاربری را وارد کنید',
            textDirection: TextDirection.rtl, textAlign: TextAlign.right),
      );
      FocusScope.of(context).requestFocus(focusName);
    } else if (inputPass.text != inputPas2.text) {
      Get.snackbar(
        borderWidth: 1,
        borderColor: Colors.red,
        icon: const Icon(
          Icons.error,
          color: Colors.red,
          size: 35,
        ),
        '',
        '',
        titleText: const Text('خطا',
            style: TextStyle(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center),
        messageText: const Text('رمز ورود و تکرار آن برابر نیست',
            textDirection: TextDirection.rtl, textAlign: TextAlign.right),
      );
      FocusScope.of(context).requestFocus(focusPass);
    } else {
      final updateData = Hive.box<UserModels>(UserDb.boxNameUser)
          .values
          .first
          .copyWith(
              newUserName: inputName.text,
              newPassword: inputPass.text,
              newHelpPassword: inputHelp.text);
      await Hive.box<UserModels>(UserDb.boxNameUser).putAt(0, updateData);
      await userController.dbuser.getAllSetData().then((List<dynamic>? data) {
        if (data != null) {
          userController.getUser.value = data.cast<UserModels>();
        }
      });
      Get.snackbar(
        '',
        '',
        titleText: const Text('درود',
            style: TextStyle(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center),
        messageText: const Text('نام کاربری با موفقیت ایجاد شد',
            textDirection: TextDirection.rtl, textAlign: TextAlign.right),
      );
      setState(() {
        logIn.value = !logIn.value;
      });
      // Get.off(() => HomeScreen());
    }
  }

//! log in
  void logInPressedFunction() async {
    userController.getAllData();

    if (userController.getUser[0].userName == 'test' && inputPass.text == '') {
      Get.snackbar('ورود میهمان', '',
          titleText: const Text('ورود میهمان',
              style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center),
          messageText: const Text('شما با یوزر میهمان وارد شدید',
              textAlign: TextAlign.right));
      Get.off(() => const HomeScreen());
    } else if (inputName.text.isEmpty) {
      Get.snackbar('', '',
          titleText: const Text('ورود غیر مجاز',
              style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center),
          messageText: const Text('لطفا نام کاربری را وارد کنید',
              textDirection: TextDirection.rtl, textAlign: TextAlign.right));
    } else if (inputName.text == userController.getUser[0].userName &&
        inputPass.text == userController.getUser[0].password) {
      userController.updateUser(
          currentTitle: userList.first.userName,
          distance: _saveLoginInfo.value.toString()
          // distance: newValue.toString(),
          );
      Get.off(() => const HomeScreen());
    } else {
      Get.snackbar('', '',
          titleText: const Text('ورود غیر مجاز',
              style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center),
          messageText: const Text('نام کاربری یا رمز ورود اشتباه است',
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
  }

  @override
  Widget build(BuildContext context) {
    if (userList.first.userName != 'test') {
      isAcont = false;
    }
    if (logIn.value) {
      sabnam = 'ورود با نام کاربری';
      txtbtn = 'ثبت نام';
      inputName.text = '';
    } else {
      sabnam = 'ثبت نام';
      txtbtn = 'ورود';
      inputName.text = userBox.values.toList().first.userName.toString();
    }
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          backgroundColor: Constants.bgColor,
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
                  const MsizedBox(15),

                  const MsizedBox(15),
                  //! لوگو
                  Container(
                    child: Assets.images.logo.image(height: 120),
                  ),
                  const MsizedBox(),
                  //! عنوان
                  const Text(
                    'یادآور سرویس خودرو',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  const MsizedBox(),
                  Container(
                      padding: const EdgeInsets.all(16),
                      // height: 300,
                      width: 300,
                      decoration: BoxDecoration(
                          color: Constants.bg2Color,
                          borderRadius: BorderRadius.circular(25)),
                      child: Column(
                        children: [
                          const IntroWidget(
                              text1:
                                  "برای استفاده از خدمات با نام کاربری خود وارد شوید ",
                              text2: "اگر حساب کاربری ندارید ثبت نام کنید"),
                          const MsizedBox(),
                          //! نام کاربری
                          MyTextField(
                              icon: Icons.person_outline,
                              lable: 'نام کابری',
                              focusName: focusName,
                              textController: inputName),
                          const MsizedBox(),
                          //! رمز ورود
                          MyTextField(
                              obstxt: true,
                              icon: Icons.lock_open_rounded,
                              lable: 'رمز ورود',
                              focusName: focusPass,
                              txtaction: logIn.value
                                  ? TextInputAction.next
                                  : TextInputAction.done,
                              textController: inputPass),
                          const MsizedBox(4),
                          if (logIn.value)
                            Column(
                              children: [
                                const MsizedBox(),
                                //! رمز ورود 2
                                MyTextField(
                                    obstxt: true,
                                    icon: Icons.lock_open_outlined,
                                    lable: 'تکرار رمز ورود',
                                    textController: inputPas2),

                                const MsizedBox(),

                                //! تافن
                                MyTextField(
                                    icon: Icons.phone_android_rounded,
                                    lable: 'موبایل',
                                    keyboardType: TextInputType.number,
                                    textController: inputMobile),
                                const MsizedBox(),
                                //! ایمیل
                                MyTextField(
                                    icon: Icons.alternate_email_rounded,
                                    lable: 'ایمیل',
                                    keyboardType: TextInputType.emailAddress,
                                    textController: inputEmail),
                                const MsizedBox(),
                                //! راهنمای رمز
                                MyTextField(
                                    icon: Icons.help_center_outlined,
                                    lable: 'یاداور رمز',
                                    txtaction: TextInputAction.done,
                                    textController: inputHelp),
                              ],
                            ),
                          if (!logIn.value)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CheckboxListTile(
                                  title: const Text('ذخیره نام و رمز ورود'),
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 15.0),
                                  value: _saveLoginInfo.value,
                                  onChanged: (newValue) {
                                    setState(() {
                                      _saveLoginInfo.value = newValue!;
                                    });
                                  },
                                ),
                                Container(
                                  // height: 40,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5.0),
                                  // color: Colors.yellow,
                                  child: TextButton(
                                    onPressed: () {
                                      Get.to(
                                          () => const ForgetPasswordScreen());
                                    },
                                    child: const Text(
                                      'رمز را فراموش کردید؟',
                                      style: TextStyle(
                                          // color: Constants.btnColor,
                                          fontSize: 15,
                                          fontWeight: FontWeight.normal),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          const MsizedBox(8),
                          //! دکمه ورود
                          ElevatedButton(
                            onPressed: logIn.value
                                ? singInPressedFunction
                                : logInPressedFunction,
                            style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 50,
                                ),
                                elevation: 8,
                                backgroundColor: Constants.btnColor,
                                foregroundColor: Colors.white),
                            child: Text(
                              txtbtn,
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                          const MsizedBox(8),

                          //! دکمه ثبت نام
                          Visibility(
                            visible: isAcont,
                            child: TextButton(
                              onPressed: () {
                                setState(() {
                                  logIn.value = !logIn.value;
                                });
                              },
                              child: Text(
                                sabnam,
                                style: TextStyle(
                                    color: Constants.btnColor,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      )),
                ],
              ),
            ),
          )),
        ));
  }
}

class MyTextField extends StatefulWidget {
  final bool? obstxt;
  final bool? readonly, enabled, seRagham;
  final IconData? icon;
  final String? lable;
  final Color? lableColor;
  final TextInputAction? txtaction;
  final TextInputType? keyboardType;
  final TextEditingController? textController;
  final FocusNode? focusName;
  final TextAlign? textAlign;
  final String? Function(String?)? validator;
  final VoidCallback? onTap;

  const MyTextField({
    Key? key,
    this.obstxt = false,
    this.readonly = false,
    this.seRagham = false,
    this.enabled = true,
    this.focusName,
    this.lableColor,
    this.icon,
    this.lable,
    this.txtaction = TextInputAction.next,
    this.textController,
    this.keyboardType = TextInputType.text,
    this.textAlign,
    this.validator,
    this.onTap,
  }) : super(key: key);

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  bool isObscured = true;

  @override
  Widget build(BuildContext context) {
    // isObscured = !widget.obstxt!;
    return TextFormField(
      onTap: widget.onTap,
      textAlign: widget.textAlign ?? TextAlign.start,
      textAlignVertical: TextAlignVertical.center,
      focusNode: widget.focusName,
      obscureText: widget.obstxt == true ? isObscured : false,
      keyboardType: widget.keyboardType,
      enabled: widget.enabled!,
      readOnly: widget.readonly!,
      textInputAction: widget.txtaction,
      controller: widget.textController,
      style: TextStyle(color: widget.lableColor),
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
        filled: true,
        fillColor: Constants.bg3Color, // رنگ پس‌زمینه فیلد
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16), // گوشه‌های گرد فیلد
          borderSide: BorderSide.none, // حذف خط حاشیه فیلد
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        prefixIcon: widget.icon == null ? null : Icon(widget.icon),
        suffixIcon: widget.obstxt!
            ? IconButton(
                icon: Icon(isObscured
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined),
                onPressed: () {
                  setState(() {
                    isObscured = !isObscured;
                  });
                },
              )
            : null,
        labelText: widget.lable, // پیشنهاد متن برای ورودی
      ),
      inputFormatters: const [
        // FilteringTextInputFormatter.digitsOnly,
      ],
      onChanged: (value) {
        if (widget.seRagham == true) {
          String formattedValue = value.seRagham();
          setState(
            () {
              widget.textController!.value = TextEditingValue(
                text: formattedValue,
                selection:
                    TextSelection.collapsed(offset: formattedValue.length),
              );
            },
          );
        }
      },
      validator: widget.validator,
    );
  }
}

// class MyTextField extends StatefulWidget {
//   bool? obstxt;
//   final bool? readonly, enabled, seRagham;
//   final IconData? icon;
//   final String? lable;
//   final TextInputAction? txtaction;
//   final TextInputType? keyboardType;
//   final TextEditingController? textController;
//   final FocusNode? focusName;
//   MyTextField({
//     Key? key,
//     this.obstxt = false,
//     this.readonly = false,
//     this.seRagham = false,
//     this.enabled = true,
//     this.focusName,
//     this.icon = Icons.api_outlined,
//     this.lable,
//     this.txtaction = TextInputAction.next,
//     this.textController,
//     this.keyboardType = TextInputType.text,
//   }) : super(key: key);

//   @override
//   State<MyTextField> createState() => _MyTextFieldState();
// }

// class _MyTextFieldState extends State<MyTextField> {
//   // bool obst = obstxt;
//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//         focusNode: widget.focusName,
//         obscureText: widget.obstxt ?? false,
//         // obscureText: widget.obstxt!,
//         keyboardType: widget.keyboardType,
//         enabled: widget.enabled!,
//         readOnly: widget.readonly!,
//         textInputAction: widget.txtaction,
//         controller: widget.textController,
//         decoration: InputDecoration(
//           contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
//           filled: true,
//           fillColor: Constants.bg3Color, // رنگ پس‌زمینه فیلد
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(16), // گوشه‌های گرد فیلد
//             borderSide: BorderSide.none, // حذف خط حاشیه فیلد
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(16),
//           ),
//           prefixIcon: widget.icon == null ? null : Icon(widget.icon),
//           suffixIcon: widget.obstxt!
//               ? IconButton(
//                   icon: Icon(widget.obstxt!
//                       ? Icons.visibility_outlined
//                       : Icons.visibility_off_outlined),
//                   onPressed: () {
//                     setState(() {
//                       print('obstxt= ${widget.obstxt!}');
//                       widget.obstxt = !widget.obstxt!;
//                     });
//                   },
//                 )
//               : null,
//           labelText: widget.lable, // پیشنهاد متن برای ورودی
//         ),
//         inputFormatters: [
//           // FilteringTextInputFormatter.digitsOnly,
//         ],
//         onChanged: (value) {
//           if (widget.seRagham == true) {
//             String formattedValue = value.seRagham();
//             setState(
//               () {
//                 widget.textController!.value = TextEditingValue(
//                   text: formattedValue,
//                   selection:
//                       TextSelection.collapsed(offset: formattedValue.length),
//                 );
//               },
//             );
//           }
//         });
//   }
// }

class IntroWidget extends StatelessWidget {
  final String? text1, text2, text3;
  const IntroWidget(
      {Key? key, this.text1 = '', this.text2 = '', this.text3 = 'اطلاعات حساب'})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text.rich(
          textDirection: TextDirection.rtl,
          TextSpan(
            children: [
              TextSpan(
                text: text1,
                // text: "برای استفاده از خدمات با نام کاربری خود وارد شوید ",
              ),
              TextSpan(
                text: text2,
                // text: "اگر حساب کاربری ندارید ثبت نام کنید",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          textAlign: TextAlign.justify,
        ),
        const SizedBox(height: 8),
        Row(
          children: <Widget>[
            const Expanded(child: Divider()),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(text3!),
            ),
            const Expanded(child: Divider()),
          ],
        ),
      ],
    );
  }
}
