import 'package:fyfax/shared/hive/model/question.dart';
import 'package:fyfax/shared/hive/model/section_title.dart';
import 'package:hive/hive.dart';

part 'section.g.dart';

@HiveType(typeId: 2)
class Section
{
  @HiveField(0)
  int id;

  @HiveField(1)
  int quiz;

  @HiveField(2)
  SectionTitle title;

  @HiveField(3)
  List<Question> question;

  @HiveField(4)
  String statement;

  @HiveField(5)
  dynamic questionNumber;

  @HiveField(6)
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