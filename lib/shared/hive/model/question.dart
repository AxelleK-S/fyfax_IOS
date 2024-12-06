// To parse this JSON data, do
//
//     final question = questionFromJson(jsonString);

import 'dart:convert';

import 'package:hive/hive.dart';

part 'question.g.dart';

List<Question> questionFromJson(String str) => List<Question>.from(json.decode(str).map((x) => Question.fromJson(x)));

String questionToJson(List<Question> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@HiveType(typeId: 5)
class Question {
  @HiveField(0)
  int id;

  @HiveField(1)
  DateTime createdAt;

  @HiveField(2)
  String statement;

  @HiveField(3)
  String greatAnswer;

  @HiveField(4)
  String option1;

  @HiveField(5)
  String option2;

  @HiveField(6)
  String option3;

  @HiveField(7)
  String option4;

  @HiveField(8)
  String option5;

  @HiveField(9)
  int section;

  @HiveField(10)
  String? justification;

  @HiveField(11)
  String? image;

  Question({
    required this.id,
    required this.createdAt,
    required this.statement,
    required this.greatAnswer,
    required this.option1,
    required this.option2,
    required this.option3,
    required this.option4,
    required this.option5,
    required this.section,
    required this.justification,
    required this.image,
  });

  factory Question.fromJson(Map<String, dynamic> json) => Question(
    id: json["id"],
    createdAt: DateTime.parse(json["created_at"]),
    statement: json["statement"],
    greatAnswer: json["great_answer"],
    option1: json["option_1"],
    option2: json["option_2"],
    option3: json["option_3"],
    option4: json["option_4"],
    option5: json["option_5"],
    section: json["section"],
    justification: json["justification"],
    image: json["image"]
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "created_at": createdAt.toIso8601String(),
    "statement": statement,
    "great_answer": greatAnswer,
    "option_1": option1,
    "option_2": option2,
    "option_3": option3,
    "option_4": option4,
    "option_5": option5,
    "section": section,
    "justification": justification,
    "image": image,
  };
}
