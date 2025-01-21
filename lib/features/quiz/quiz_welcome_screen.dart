import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fyfax/features/quiz/model/quiz_details.dart';
import 'package:fyfax/features/quiz/model/section_group.dart';
import 'package:fyfax/features/quiz/quiz_question_screen.dart';
import 'package:fyfax/shared/widgets/quiz_validated_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

class QuizWelcomeScreen extends StatelessWidget {
  final QuizDetails quiz;
  final SectionGroup sectionGroup;
  const QuizWelcomeScreen({super.key, required this.quiz, required this.sectionGroup});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(80),
          child: Container(
            margin: const EdgeInsets.only(
              left: 16,
              right: 16
            ),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap : () => Navigator.of(context).pop(),
                      child: const Icon(Iconsax.arrow_left)
                  )
                ],
              ),
            ),
          )),
      body: Column(
        children: [
          Text(quiz.name, style: GoogleFonts.inter(),),
          const SizedBox(height: 10,),
          Text('Partie ${sectionGroup.title.title}', style: GoogleFonts.inter(),),
          const SizedBox(height: 10,),
          Text('Session ${quiz.year.toString()}', style: GoogleFonts.inter(),),
          const SizedBox(height: 24,),
          Text('Nombre de questions : ${sectionGroup.numberOfQuestions.toString()}', style: GoogleFonts.inter(),),
          const SizedBox(height: 34,),
          QuizValidatedButton(onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => QuizQuestionScreen(quiz: quiz, sectionGroup: sectionGroup,),));
          }, text: 'Commencer')
        ],
      ),
    );
  }
}
