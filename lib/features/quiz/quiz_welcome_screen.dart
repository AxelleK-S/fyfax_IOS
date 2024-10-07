import 'package:flutter/material.dart';
import 'package:fyfax/features/quiz/quiz_question_screen.dart';
import 'package:fyfax/shared/widgets/quiz_validated_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

class QuizWelcomeScreen extends StatelessWidget {
  const QuizWelcomeScreen({super.key});

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
            child: const SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Iconsax.arrow_left)
                ],
              ),
            ),
          )),
      body: Column(
        children: [
          Text('Epreuve Médécine générale', style: GoogleFonts.handlee(),),
          const SizedBox(height: 10,),
          Text('Session 2023', style: GoogleFonts.handlee(),),
          const SizedBox(height: 24,),
          Text('Nombre de questions : 20', style: GoogleFonts.handlee(),),
          const SizedBox(height: 34,),
          QuizValidatedButton(onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => const QuizQuestionScreen(),));
          }, text: 'Commencer')
        ],
      ),
    );
  }
}
