// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'firest.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FirestModelAdapter extends TypeAdapter<FirestModel> {
  @override
  final int typeId = 3;

  @override
  FirestModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FirestModel(
      active: fields[0] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, FirestModel obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.active);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FirestModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
