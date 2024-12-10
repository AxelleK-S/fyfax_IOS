// To parse this JSON data, do
//
//     final question = questionFromJson(jsonString);

import 'dart:convert';

List<Question> questionFromJson(String str) => List<Question>.from(json.decode(str).map((x) => Question.fromJson(x)));

String questionToJson(List<Question> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Question {
  int id;
  DateTime createdAt;
  String statement;
  String greatAnswer;
  String option1;
  String option2;
  String option3;
  String option4;
  String option5;
  int section;
  String? justification;
  String image;

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
    "image" : image
  };
}
