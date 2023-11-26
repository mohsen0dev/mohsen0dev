import 'package:hive/hive.dart';
part 'firest.g.dart';

@HiveType(typeId: 3)
class FirestModel {
  @HiveField(0)
  late bool active = false;

  FirestModel({required this.active});
  FirestModel copyWith({
    bool? newActive,
  }) {
    return FirestModel(
      active: newActive ?? active,
    );
  }
}
