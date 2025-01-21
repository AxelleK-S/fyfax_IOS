import 'package:flutter/material.dart';
import 'package:fyfax/features/quiz/model/quiz_details.dart';
import 'package:fyfax/features/quiz/model/section_group.dart';
import 'package:fyfax/features/quiz/quiz_welcome_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class QuizLargeCard extends StatelessWidget {
  final QuizDetails quiz;
  final SectionGroup sectionGroup;
  const QuizLargeCard(
      {super.key, required this.quiz, required this.sectionGroup});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => QuizWelcomeScreen(
            quiz: quiz,
            sectionGroup: sectionGroup,
          ),
        ));
      },
      child: Container(
        height: 92,
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.only(left: 16, right: 16, top: 7, bottom: 7),
        padding: const EdgeInsets.only(left: 16, right: 16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: quiz.domain.name == "Odontostomatologie"
                ? Colors.greenAccent
                : quiz.domain.name == "Médecine"
                    ? Colors.lightBlueAccent
                    : Colors.deepPurpleAccent),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(sectionGroup.title.title,
                textAlign: TextAlign.left,
                style: GoogleFonts.inter(color: Colors.black)),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text('${sectionGroup.numberOfQuestions.toString()} Questions',
                    textAlign: TextAlign.right,
                    style: GoogleFonts.inter(color: Colors.black)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
