import 'package:flutter/material.dart';
import 'package:fyfax/features/quiz/model/quiz_details.dart';
import 'package:fyfax/features/quiz/quiz_welcome_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class QuizLargeCard extends StatelessWidget {
  final QuizDetails quiz;
  const QuizLargeCard(
      {super.key, required this.quiz});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => QuizWelcomeScreen(quiz : quiz),
        ));
      },
      child: Container(
        height: 92,
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.only(left: 16, right: 16, top: 7, bottom: 7),
        padding: const EdgeInsets.only(left: 16, right: 16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: Colors.greenAccent),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(quiz.domain.name,
                textAlign: TextAlign.left, style: GoogleFonts.handlee()),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text('${quiz.questionNumber.toString()} Questions',
                    textAlign: TextAlign.right, style: GoogleFonts.handlee()),
              ],
            )
          ],
        ),
      ),
    );
  }
}
