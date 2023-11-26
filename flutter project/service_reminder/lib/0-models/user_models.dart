import 'package:hive/hive.dart';

part 'user_models.g.dart';

@HiveType(typeId: 2)
class UserModels extends HiveObject {
  @HiveField(0)
  String userName;

  @HiveField(1)
  String? password;

  @HiveField(2)
  String? tel;

  @HiveField(3)
  String? helpPassword;

  @HiveField(4)
  bool? remember;

  @HiveField(5)
  String? name;

  @HiveField(6)
  String? nameCar;

  @HiveField(7)
  String? colorCar;

  @HiveField(8)
  String? year;

  @HiveField(9)
  String? carNumber;

  @HiveField(10)
  String? shasi;

  @HiveField(11)
  String? govahinameNumber;

  UserModels({
    required this.userName,
    this.password = '',
    this.tel = '',
    this.helpPassword = '',
    this.remember = false,
    this.name = '',
    this.nameCar = '',
    this.colorCar = '',
    this.year = '',
    this.carNumber = '',
    this.shasi = '',
    this.govahinameNumber = '',
  });
  UserModels copyWith({
    String? newUserName,
    String? newPassword,
    String? newTel,
    String? newHelpPassword,
    String? newName,
    String? newNameCar,
    String? newColorCar,
    String? newCarNumber,
    String? newShasi,
    String? newGovahiname,
    String? newYear,
    bool? newRemember,
  }) {
    return UserModels(
        userName: newUserName ?? userName,
        carNumber: newCarNumber ?? carNumber,
        colorCar: newColorCar ?? colorCar,
        govahinameNumber: newGovahiname ?? govahinameNumber,
        helpPassword: newHelpPassword ?? helpPassword,
        name: newName ?? name,
        nameCar: newNameCar ?? nameCar,
        password: newPassword ?? password,
        remember: newRemember ?? remember,
        shasi: newShasi ?? shasi,
        tel: newTel ?? tel,
        year: newYear ?? year);
  }
}
