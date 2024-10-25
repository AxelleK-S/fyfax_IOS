// To parse this JSON data, do
//
//     final quizDetails = quizDetailsFromJson(jsonString);

import 'dart:convert';

import 'package:fyfax/features/quiz/model/domain.dart';
import 'package:fyfax/features/quiz/model/question.dart';
import 'package:fyfax/features/quiz/model/section_title.dart';

List<QuizDetails> quizDetailsFromJson(String str) => List<QuizDetails>.from(json.decode(str).map((x) => QuizDetails.fromJson(x)));

String quizDetailsToJson(List<QuizDetails> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class QuizDetails {
  int id;
  DateTime createdAt;
  String name;
  int year;
  Domain domain;
  int questionNumber;
  List<Section> section;

  QuizDetails({
    required this.id,
    required this.createdAt,
    required this.name,
    required this.year,
    required this.domain,
    required this.questionNumber,
    required this.section,
  });

  factory QuizDetails.fromJson(Map<String, dynamic> json) => QuizDetails(
    id: json["id"],
    createdAt: DateTime.parse(json["created_at"]),
    name: json["name"],
    year: json["year"],
    domain: Domain.fromJson(json["domain"]),
    questionNumber: json["question_number"],
    section: List<Section>.from(json["section"].map((x) => Section.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "created_at": createdAt.toIso8601String(),
    "name": name,
    "year": year,
    "domain": domain.toJson(),
    "question_number": questionNumber,
    "section": List<dynamic>.from(section.map((x) => x.toJson())),
  };
}



class Section {
  int id;
  int quiz;
  SectionTitle title;
  List<Question> question;
  String statement;
  dynamic questionNumber;
  int quizPart;

  Section({
    required this.id,
    required this.quiz,
    required this.title,
    required this.question,
    required this.statement,
    required this.questionNumber,
    required this.quizPart,
  });

  factory Section.fromJson(Map<String, dynamic> json) => Section(
    id: json["id"],
    quiz: json["quiz"],
    title: SectionTitle.fromJson(json["title"]),
    question: List<Question>.from(json["question"].map((x) => Question.fromJson(x))),
    statement: json["statement"],
    questionNumber: json["question_number"],
    quizPart: json["quiz_part"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "quiz": quiz,
    "title": title.toJson(),
    "question": List<dynamic>.from(question.map((x) => x.toJson())),
    "statement": statement,
    "question_number": questionNumber,
    "quiz_part": quizPart,
  };
}




