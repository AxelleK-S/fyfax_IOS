import 'package:fyfax/features/quiz/model/quiz_details.dart';
import 'package:fyfax/features/quiz/model/section_title.dart';

class SectionGroup {
  final SectionTitle title;
  final List<Section> sections;
  int numberOfQuestions;

  SectionGroup({
    required this.title,
    required this.sections,
  }): numberOfQuestions = sections.fold(0, (sum, section) => sum + section.question.length);

  // Optional: You can add a method to recalculate if sections change
  void calculateNumberOfQuestions() {
    numberOfQuestions = sections.fold(0, (sum, section) => sum + section.question.length);
  }
}