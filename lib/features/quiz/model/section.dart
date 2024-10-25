// To parse this JSON data, do
//
//     final section = sectionFromJson(jsonString);

import 'dart:convert';

List<Section> sectionFromJson(String str) => List<Section>.from(json.decode(str).map((x) => Section.fromJson(x)));

String sectionToJson(List<Section> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Section {
  int id;
  DateTime createdAt;
  String statement;
  dynamic questionNumber;
  int quiz;
  int title;
  int quizPart;

  Section({
    required this.id,
    required this.createdAt,
    required this.statement,
    required this.questionNumber,
    required this.quiz,
    required this.title,
    required this.quizPart,
  });

  factory Section.fromJson(Map<String, dynamic> json) => Section(
    id: json["id"],
    createdAt: DateTime.parse(json["created_at"]),
    statement: json["statement"],
    questionNumber: json["question_number"],
    quiz: json["quiz"],
    title: json["title"],
    quizPart: json["quiz_part"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "created_at": createdAt.toIso8601String(),
    "statement": statement,
    "question_number": questionNumber,
    "quiz": quiz,
    "title": title,
    "quiz_part": quizPart,
  };
}
