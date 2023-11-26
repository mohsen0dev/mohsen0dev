// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_models.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserModelsAdapter extends TypeAdapter<UserModels> {
  @override
  final int typeId = 2;

  @override
  UserModels read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserModels(
      userName: fields[0] as String,
      password: fields[1] as String?,
      tel: fields[2] as String?,
      helpPassword: fields[3] as String?,
      remember: fields[4] as bool?,
      name: fields[5] as String?,
      nameCar: fields[6] as String?,
      colorCar: fields[7] as String?,
      year: fields[8] as String?,
      carNumber: fields[9] as String?,
      shasi: fields[10] as String?,
      govahinameNumber: fields[11] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, UserModels obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.userName)
      ..writeByte(1)
      ..write(obj.password)
      ..writeByte(2)
      ..write(obj.tel)
      ..writeByte(3)
      ..write(obj.helpPassword)
      ..writeByte(4)
      ..write(obj.remember)
      ..writeByte(5)
      ..write(obj.name)
      ..writeByte(6)
      ..write(obj.nameCar)
      ..writeByte(7)
      ..write(obj.colorCar)
      ..writeByte(8)
      ..write(obj.year)
      ..writeByte(9)
      ..write(obj.carNumber)
      ..writeByte(10)
      ..write(obj.shasi)
      ..writeByte(11)
      ..write(obj.govahinameNumber);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserModelsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
