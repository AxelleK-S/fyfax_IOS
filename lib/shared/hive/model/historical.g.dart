// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'historical.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HistoricalAdapter extends TypeAdapter<Historical> {
  @override
  final int typeId = 6;

  @override
  Historical read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Historical(
      id: fields[0] as int,
      createdAt: fields[1] as DateTime,
      text: fields[2] as String,
      user: fields[3] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Historical obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.createdAt)
      ..writeByte(2)
      ..write(obj.text)
      ..writeByte(3)
      ..write(obj.user);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HistoricalAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
