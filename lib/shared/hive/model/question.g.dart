// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class QuestionAdapter extends TypeAdapter<Question> {
  @override
  final int typeId = 5;

  @override
  Question read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Question(
      id: fields[0] as int,
      createdAt: fields[1] as DateTime,
      statement: fields[2] as String,
      greatAnswer: fields[3] as String,
      option1: fields[4] as String,
      option2: fields[5] as String,
      option3: fields[6] as String,
      option4: fields[7] as String,
      option5: fields[8] as String,
      section: fields[9] as int,
      justification: fields[10] as String?,
      image: fields[11] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Question obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.createdAt)
      ..writeByte(2)
      ..write(obj.statement)
      ..writeByte(3)
      ..write(obj.greatAnswer)
      ..writeByte(4)
      ..write(obj.option1)
      ..writeByte(5)
      ..write(obj.option2)
      ..writeByte(6)
      ..write(obj.option3)
      ..writeByte(7)
      ..write(obj.option4)
      ..writeByte(8)
      ..write(obj.option5)
      ..writeByte(9)
      ..write(obj.section)
      ..writeByte(10)
      ..write(obj.justification)
      ..writeByte(11)
      ..write(obj.image);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuestionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
