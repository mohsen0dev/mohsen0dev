import 'package:hive/hive.dart';

part 'save_data_model.g.dart';

@HiveType(typeId: 4)
class AddDataModel extends HiveObject {
  @HiveField(0)
  String title;

  @HiveField(1)
  String? date;

  @HiveField(2)
  String? kmetr;

  @HiveField(3)
  String? amount;

  @HiveField(4)
  String? description;

  AddDataModel(
      {required this.title,
      this.date,
      this.amount,
      this.kmetr,
      this.description});
  AddDataModel copyWith({
    required String newTitle,
    String? newDate,
    String? newAmount,
    String? newKmetr,
    String? newDescription,
  }) {
    return AddDataModel(
      title: newTitle,
      date: newDate ?? date,
      amount: newAmount ?? amount,
      kmetr: newKmetr ?? kmetr,
      description: newDescription ?? description,
    );
  }
}
