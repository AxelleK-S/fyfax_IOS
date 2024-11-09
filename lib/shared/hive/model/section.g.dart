// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'section.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SectionAdapter extends TypeAdapter<Section> {
  @override
  final int typeId = 2;

  @override
  Section read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Section(
      id: fields[0] as int,
      quiz: fields[1] as int,
      title: fields[2] as SectionTitle,
      question: (fields[3] as List).cast<Question>(),
      statement: fields[4] as String,
      questionNumber: fields[5] as dynamic,
      quizPart: fields[6] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Section obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.quiz)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.question)
      ..writeByte(4)
      ..write(obj.statement)
      ..writeByte(5)
      ..write(obj.questionNumber)
      ..writeByte(6)
      ..write(obj.quizPart);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SectionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
