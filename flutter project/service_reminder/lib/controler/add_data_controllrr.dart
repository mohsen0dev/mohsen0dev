import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_reminder/0-models/save_data_model.dart';
import 'package:service_reminder/services/add_crud.dart';
import 'package:service_reminder/services/database_adaptor.dart';

class AddDataController extends GetxController {
  late final DBAdabtor db;
  RxList<AddDataModel> getAddData = <AddDataModel>[].obs;
  @override
  void onInit() {
    super.onInit();
    db = AddCRUDdb.instance();
    getData();
  }

  void getData() async {
    await db.getAllSetData().then((List<dynamic>? data) {
      if (data != null) {
        List<AddDataModel> typedData = data.cast<AddDataModel>();
        getAddData.assignAll(typedData);
      }
    });
  }

  void addData(AddDataModel data) async {
    await db.createTask(data: data).then((bool hasAdded) {
      if (hasAdded) {
        getAddData.add(data);
        getData();
      }
    });
  }

  void updateUser({String? currentTitle, String? distance}) async {
    try {
      await db
          .updateSetData(currentTitle: currentTitle!, distance: distance)
          .then((data) {
        if (data != null) {}
      });
    } catch (e) {
      debugPrint('debug: $e');
    }
  }
}
