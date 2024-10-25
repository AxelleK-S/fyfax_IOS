// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offline_quiz.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OfflineQuizAdapter extends TypeAdapter<OfflineQuiz> {
  @override
  final int typeId = 1;

  @override
  OfflineQuiz read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return OfflineQuiz(
      id: fields[0] as int,
      createdAt: fields[1] as DateTime,
      name: fields[2] as String,
      year: fields[3] as int,
      domain: fields[4] as Domain,
      questionNumber: fields[5] as int,
      section: (fields[6] as List).cast<Section>(),
    );
  }

  @override
  void write(BinaryWriter writer, OfflineQuiz obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.createdAt)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.year)
      ..writeByte(4)
      ..write(obj.domain)
      ..writeByte(5)
      ..write(obj.questionNumber)
      ..writeByte(6)
      ..write(obj.section);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OfflineQuizAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
