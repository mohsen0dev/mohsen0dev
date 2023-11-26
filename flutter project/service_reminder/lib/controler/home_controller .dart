import 'package:get/get.dart';
import 'package:service_reminder/0-models/set_data_model.dart';
import 'package:service_reminder/services/app_database.dart';
import 'package:service_reminder/services/database_adaptor.dart';

class HomeController extends GetxController {
  late final DBAdabtor db;
  RxList<SetDataModel> getData = <SetDataModel>[].obs;
  @override
  void onInit() {
    super.onInit();
    db = AppDatabase.instance();
    getAllData();
  }

  void getAllData() async {
    await db.getAllSetData().then((List<dynamic>? data) {
      if (data != null) {
        List<SetDataModel> typedData = data.cast<SetDataModel>();
        getData.assignAll(typedData);
      }
    });
  }

  void addData(SetDataModel data) async {
    await db.createTask(data: data).then((bool hasAdded) {
      if (hasAdded) {
        getData.add(data);
        getAllData();
      }
    });
  }
}
