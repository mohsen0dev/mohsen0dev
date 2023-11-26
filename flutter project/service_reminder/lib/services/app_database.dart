import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:service_reminder/0-models/set_data_model.dart';
import 'package:service_reminder/0-models/user_models.dart';
import 'package:service_reminder/services/database_adaptor.dart';

class UserDb implements DBAdabtor {
  UserDb._();
  static final UserDb _shared = UserDb._();
  factory UserDb.instance() => _shared;
  static const String boxNameUser = 'users';

  @override
  Future<bool> createTask({required data}) async {
    try {
      await Hive.box<UserModels>(boxNameUser).add(data);
      return true;
    } catch (e) {
      debugPrint('debug: $e');
      return false;
    }
  }

  @override
  Future<bool> deleteSetData({required int index}) async {
    try {
      await Hive.box<UserModels>(boxNameUser).deleteAt(index);
      return true;
    } catch (e) {
      debugPrint('debug: $e');
      return false;
    }
  }

  @override
  Future<List<dynamic>?> getAllSetData() async {
    try {
      return Hive.box<UserModels>(boxNameUser).values.toList();
    } catch (e) {
      debugPrint('debug: $e');
      return null;
    }
  }

  @override
  Future<dynamic>? readSingleSetData({required int index}) {
    try {
      final data = Hive.box(boxNameUser).getAt(index);
      return data;
    } catch (e) {
      debugPrint('debug: $e');
      return null;
    }
  }

  @override
  Future<dynamic> updateSetData(
      {String? title, String? distance, required String currentTitle}) async {
    try {
      final currentData = Hive.box<UserModels>(boxNameUser)
          .values
          .firstWhere((UserModels element) => element.userName == currentTitle);

      final updateData = currentData.copyWith(
          newName: title, newRemember: bool.tryParse(distance ?? 'false'));
      await Hive.box<UserModels>(boxNameUser).putAt(0, updateData);
      return updateData;
    } catch (e) {
      debugPrint('debug: $e');
      return null;
    }
  }
}

class AppDatabase implements DBAdabtor {
  AppDatabase._();
  static final AppDatabase _shared = AppDatabase._();
  factory AppDatabase.instance() => _shared;
  static const String boxNameData = 'setData';

  @override
  Future<bool> createTask({required data}) async {
    try {
      await Hive.box<SetDataModel>(boxNameData).add(data);
      return true;
    } catch (e) {
      debugPrint('debug: $e');
      return false;
    }
  }

  @override
  Future<bool> deleteSetData({required int index}) async {
    try {
      await Hive.box<SetDataModel>(boxNameData).deleteAt(index);
      return true;
    } catch (e) {
      debugPrint('debug: $e');
      return false;
    }
  }

  @override
  Future<List<dynamic>?> getAllSetData() async {
    try {
      return Hive.box<SetDataModel>(boxNameData).values.toList();
    } catch (e) {
      debugPrint('debug: $e');
      return null;
    }
  }

  @override
  Future<dynamic>? readSingleSetData({required int index}) {
    try {
      final data = Hive.box(boxNameData).getAt(index);
      return data;
    } catch (e) {
      debugPrint('debug: $e');
      return null;
    }
  }

  @override
  Future<dynamic> updateSetData(
      {String? title, String? distance, required String currentTitle}) async {
    try {
      final currentData = Hive.box<SetDataModel>(boxNameData)
          .values
          .firstWhere((SetDataModel element) => element.title == currentTitle);
      final index = Hive.box<SetDataModel>(boxNameData)
          .values
          .toList()
          .indexOf(currentData);
      final updateData =
          currentData.copyWith(newTitle: title, newValue: distance);
      await Hive.box<SetDataModel>(boxNameData).putAt(index, updateData);
      return updateData;
    } catch (e) {
      debugPrint('debug: $e');
      return null;
    }
  }
}
