import 'package:hive/hive.dart';
part 'kilometr_model.g.dart';

@HiveType(typeId: 1)
class KilometrModel {
  @HiveField(0)
  late int kmetr;

  @HiveField(1)
  final int change;

  @HiveField(2)
  final String? date;

  @HiveField(3)
  late bool? active;

  KilometrModel(
      {required this.kmetr, required this.change, this.date, this.active});
  KilometrModel copyWith({
    int? newKmetr,
    int? newChange,
    String? newDate,
    bool? newActive,
  }) {
    return KilometrModel(
      kmetr: newKmetr ?? kmetr,
      change: newChange ?? change,
      date: newDate ?? date,
      active: newActive ?? active,
    );
  }
}
