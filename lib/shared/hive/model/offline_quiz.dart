import 'dart:convert';


import 'package:fyfax/shared/hive/model/domain.dart';
import 'package:fyfax/shared/hive/model/section.dart';
import 'package:hive/hive.dart';

part 'offline_quiz.g.dart';

List<OfflineQuiz> quizDetailsFromJson(String str) => List<OfflineQuiz>.from(json.decode(str).map((x) => OfflineQuiz.fromJson(x)));

String quizDetailsToJson(List<OfflineQuiz> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@HiveType(typeId: 1)
class OfflineQuiz extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  DateTime createdAt;

  @HiveField(2)
  String name;

  @HiveField(3)
  int year;

  @HiveField(4)
  Domain domain;

  @HiveField(5)
  int questionNumber;

  @HiveField(6)
  List<Section> section;

  OfflineQuiz({
    required this.id,
    required this.createdAt,
    required this.name,
    required this.year,
    required this.domain,
    required this.questionNumber,
    required this.section,
  });

  factory OfflineQuiz.fromJson(Map<String, dynamic> json) => OfflineQuiz(
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



