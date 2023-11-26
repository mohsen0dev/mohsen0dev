import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:service_reminder/0-models/user_models.dart';
import 'package:service_reminder/services/app_database.dart';
import 'package:service_reminder/services/database_adaptor.dart';

class UserController extends GetxController {
  late final DBAdabtor dbuser;
  RxList<UserModels> getUser = <UserModels>[].obs;
  @override
  void onInit() {
    super.onInit();
    dbuser = UserDb.instance();
    getAllData();
  }

  void getAllData() async {
    try {
      await dbuser.getAllSetData().then((List<dynamic>? data) {
        if (data != null) {
          List<UserModels> typedData = data.cast<UserModels>();
          getUser.assignAll(typedData);
        }
      });
    } catch (e) {
      debugPrint('debug: $e');
    }
  }

  void updateUser({String? currentTitle, String? distance}) async {
    try {
      await dbuser
          .updateSetData(currentTitle: currentTitle!, distance: distance)
          .then((data) {
        if (data != null) {}
      });
    } catch (e) {
      debugPrint('debug: $e');
    }
  }

  void addData(UserModels data) async {
    await dbuser.createTask(data: data).then((bool hasAdded) {
      if (hasAdded) {
        getUser.add(data);
        getAllData();
      }
    });
  }

  void delData() async {
    try {
      await dbuser.deleteSetData(index: 1).then((bool data) {
        if (data) {
          getUser.removeAt(0);
        }
      });
    } catch (e) {
      debugPrint('debug: $e');
    }
  }
}
