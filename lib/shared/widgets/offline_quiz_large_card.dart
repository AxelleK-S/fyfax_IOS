import 'package:flutter/material.dart';
import 'package:fyfax/shared/hive/model/offline_quiz.dart';
import 'package:google_fonts/google_fonts.dart';

class OfflineQuizLargeCard extends StatelessWidget {
  final OfflineQuiz quiz;
  const OfflineQuizLargeCard(
      {super.key, required this.quiz});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
       /*
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => QuizWelcomeScreen(quiz : quiz),
        ));*/
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
                textAlign: TextAlign.left, style: GoogleFonts.inter()),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text('${quiz.questionNumber.toString()} Questions',
                    textAlign: TextAlign.right, style: GoogleFonts.inter()),
              ],
            )
          ],
        ),
      ),
    );
  }
}
