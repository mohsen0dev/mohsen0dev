import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_reminder/const.dart';
import 'package:service_reminder/controler/user_controller%20.dart';
import 'package:service_reminder/screen/06-pishrafte/pishrafte.dart';
import 'package:service_reminder/screen/04-change_password/change_password_screen.dart';
import 'package:service_reminder/screen/05-profile/profile_screen.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({
    super.key,
  });

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  void initState() {
    super.initState();
  }

  final UserController userController = Get.put(UserController());

  bool state = false;
  @override
  Widget build(BuildContext context) {
    // userController.getAllData();

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Drawer(
        width: MediaQuery.sizeOf(context).width * .6,
        backgroundColor: Constants.bg3Color,
        child: ListView(
          children: [
            //* profile
            Obx(() {
              return UserAccountsDrawerHeader(
                currentAccountPicture: const CircleAvatar(
                    // backgroundImage: NetworkImage('https://i.pravatar.cc/219'),
                    // child: Text('m'),
                    ),
                accountName: InkWell(
                    child: Row(
                      children: [
                        Text(
                          userController.getUser.isEmpty
                              ? ''
                              : userController.getUser[0].name == ''
                                  ? userController.getUser[0].userName
                                  : userController.getUser[0].name!,
                          style: const TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 5),
                        const Icon(
                          Icons.edit_outlined,
                          size: 18,
                        )
                      ],
                    ),
                    onTap: () {
                      Get.to(() => const ProfileScreen());
                    }),
                accountEmail: Text(
                  userController.getUser.isEmpty
                      ? ''
                      : userController.getUser[0].nameCar!,
                  style: const TextStyle(color: Colors.black54),
                ),
                decoration: BoxDecoration(
                  color: Constants.bg2Color,
                ),
              );
            }),
            const Divider(),
            // ListTile(
            //   title: Text('تم تاریک'),
            //   trailing: CupertinoSwitch(
            //     activeColor: Constants.btnColor,
            //     value: state,
            //     onChanged: (value) {
            //       setState(() {
            //         state = value;
            //       });
            //     },
            //   ),
            // ),
            ListTile(
              title: const Text('تکمیل مشخصات'),
              onTap: () {
                Get.back();
                Get.to(() => const ProfileScreen());
              },
            ),
            ListTile(
              title: const Text('تغییر رمز یا نام کاربری'),
              onTap: () {
                Get.back();
                Get.to(() => const ChangePasswordScreen());
              },
            ),
            ListTile(
                title: const Text('تنظیمات پیشرفته'),
                onTap: () {
                  Get.back();
                  Get.to(
                    () => const PishrafteScreen(),
                  );
                }),
            ListTile(
              title: const Text('بازیابی اطلاعات'),
              onTap: () {},
            ),
            ListTile(
              title: const Text('پشتیبان گیری'),
              onTap: () {},
            ),
            ListTile(
              title: const Text('درباره ما'),
              onTap: () {},
            ),
            const ListTile(
              title: Text('نسخه 0.0.1'),
            ),
          ],
        ),
      ),
    );
  }
}
