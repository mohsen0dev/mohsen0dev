// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'save_data_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AddDataModelAdapter extends TypeAdapter<AddDataModel> {
  @override
  final int typeId = 4;

  @override
  AddDataModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AddDataModel(
      title: fields[0] as String,
      date: fields[1] as String?,
      amount: fields[3] as String?,
      kmetr: fields[2] as String?,
      description: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, AddDataModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.date)
      ..writeByte(2)
      ..write(obj.kmetr)
      ..writeByte(3)
      ..write(obj.amount)
      ..writeByte(4)
      ..write(obj.description);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AddDataModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
