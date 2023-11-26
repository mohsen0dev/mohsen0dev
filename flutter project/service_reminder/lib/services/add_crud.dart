import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:service_reminder/0-models/save_data_model.dart';
import 'package:service_reminder/services/database_adaptor.dart';

class AddCRUDdb implements DBAdabtor {
  AddCRUDdb._();
  static final AddCRUDdb _shared = AddCRUDdb._();
  factory AddCRUDdb.instance() => _shared;
  static const String boxAddName = 'addData';

  @override
  Future<bool> createTask({required data}) async {
    try {
      await Hive.box<AddDataModel>(boxAddName).add(data);
      return true;
    } catch (e) {
      debugPrint('debug: $e');
      return false;
    }
  }

  @override
  Future<bool> deleteSetData({required int index}) async {
    try {
      await Hive.box<AddDataModel>(boxAddName).deleteAt(index);
      return true;
    } catch (e) {
      debugPrint('debug: $e');
      return false;
    }
  }

  @override
  Future<List<AddDataModel>?> getAllSetData() async {
    try {
      return Hive.box<AddDataModel>(boxAddName).values.toList();
    } catch (e) {
      debugPrint('debug: $e');
      return null;
    }
  }

  @override
  Future<AddDataModel>? readSingleSetData({required int index}) {
    try {
      final data = Hive.box(boxAddName).getAt(index);
      return data;
    } catch (e) {
      debugPrint('debug: $e');
      return null;
    }
  }

  @override
  Future<dynamic> updateSetData(
      {String? title, String? distance, required String currentTitle}) async {
    // try {
    //   final currentData = Hive.box<AddDataController>(boxNameUser)
    //       .values
    //       .firstWhere((AddDataController element) => element.title == currentTitle);

    //   final updateData = currentData.copyWith(
    //       newName: title, newRemember: bool.tryParse(distance ?? 'false'));
    //   await Hive.box<AddDataController>(boxNameUser).putAt(0, updateData);
    //   return updateData;
    // } catch (e) {
    //   print(e);
    //   return null;
    // }
  }
}
