import 'package:hive/hive.dart';
part 'set_data_model.g.dart';

@HiveType(typeId: 0)
class SetDataModel {
  @HiveField(0)
  final String title;

  @HiveField(1)
  final String value;

  @HiveField(2)
  final String type;

  @HiveField(3)
  final bool active;
  @HiveField(4)
  final String srcName;

  const SetDataModel(
      {required this.title,
      required this.active,
      required this.value,
      required this.type,
      required this.srcName});
  SetDataModel copyWith(
      {String? newTitle,
      String? newSrcName,
      String? newType,
      String? newDate,
      String? newValue,
      bool? newActive}) {
    return SetDataModel(
        title: title,
        active: newActive ?? active,
        value: newValue ?? value,
        srcName: newSrcName ?? srcName,
        type: newType ?? type);
  }
}
