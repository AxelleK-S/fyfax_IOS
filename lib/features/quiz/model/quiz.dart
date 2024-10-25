// To parse this JSON data, do
//
//     final quiz = quizFromJson(jsonString);

import 'dart:convert';

List<Quiz> quizFromJson(String str) => List<Quiz>.from(json.decode(str).map((x) => Quiz.fromJson(x)));

String quizToJson(List<Quiz> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Quiz {
  int id;
  DateTime createdAt;
  String name;
  int year;
  int domain;
  int questionNumber;

  Quiz({
    required this.id,
    required this.createdAt,
    required this.name,
    required this.year,
    required this.domain,
    required this.questionNumber,
  });

  factory Quiz.fromJson(Map<String, dynamic> json) => Quiz(
    id: json["id"],
    createdAt: DateTime.parse(json["created_at"]),
    name: json["name"],
    year: json["year"],
    domain: json["domain"],
    questionNumber: json["question_number"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "created_at": createdAt.toIso8601String(),
    "name": name,
    "year": year,
    "domain": domain,
    "question_number": questionNumber,
  };
}
