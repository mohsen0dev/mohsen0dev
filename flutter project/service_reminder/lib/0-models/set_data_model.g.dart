// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'set_data_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SetDataModelAdapter extends TypeAdapter<SetDataModel> {
  @override
  final int typeId = 0;

  @override
  SetDataModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SetDataModel(
      title: fields[0] as String,
      active: fields[3] as bool,
      value: fields[1] as String,
      type: fields[2] as String,
      srcName: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, SetDataModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.value)
      ..writeByte(2)
      ..write(obj.type)
      ..writeByte(3)
      ..write(obj.active)
      ..writeByte(4)
      ..write(obj.srcName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SetDataModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
