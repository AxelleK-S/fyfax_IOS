// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'section_title.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SectionTitleAdapter extends TypeAdapter<SectionTitle> {
  @override
  final int typeId = 4;

  @override
  SectionTitle read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SectionTitle(
      id: fields[0] as int,
      createdAt: fields[1] as DateTime,
      title: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, SectionTitle obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.createdAt)
      ..writeByte(2)
      ..write(obj.title);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SectionTitleAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
