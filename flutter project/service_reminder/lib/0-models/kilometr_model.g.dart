// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kilometr_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class KilometrModelAdapter extends TypeAdapter<KilometrModel> {
  @override
  final int typeId = 1;

  @override
  KilometrModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return KilometrModel(
      kmetr: fields[0] as int,
      change: fields[1] as int,
      date: fields[2] as String?,
      active: fields[3] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, KilometrModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.kmetr)
      ..writeByte(1)
      ..write(obj.change)
      ..writeByte(2)
      ..write(obj.date)
      ..writeByte(3)
      ..write(obj.active);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is KilometrModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
