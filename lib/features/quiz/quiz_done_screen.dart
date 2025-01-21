import 'package:flutter/material.dart';
import 'package:fyfax/features/home/home_screen.dart';
import 'package:fyfax/features/quiz/model/quiz_details.dart';
import 'package:fyfax/features/quiz/model/section_group.dart';
import 'package:fyfax/features/quiz/quiz_welcome_screen.dart';
import 'package:fyfax/shared/widgets/validated_button.dart';
import 'package:google_fonts/google_fonts.dart';

class QuizDoneScreen extends StatelessWidget {
  final int score;
  final int totalPoint;
  final QuizDetails quiz;
  final SectionGroup sectionGroup;
  const QuizDoneScreen({super.key, required this.score, required this.quiz, required this.totalPoint, required this.sectionGroup});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 150,
              width: 150,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(image: AssetImage('assets/images/result.png'),)
              ),
            ),
            const SizedBox(height: 44,),
            Text('Félicitation tu as terminé', style: GoogleFonts.inter(fontSize: 18),),
            const SizedBox(height: 24,),
            Text('Score', style: GoogleFonts.inter(fontSize: 18),),
            const SizedBox(height: 14,),
            Text('${score.toString()}/${totalPoint.toString()}', style: GoogleFonts.inter(fontSize: 18),),
          ],
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 210,
        child: Column(
          children: [
            ValidatedButton(onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return QuizWelcomeScreen(quiz: quiz, sectionGroup: sectionGroup,);
              },));
            }, text: 'Relancer'),
            ValidatedButton(onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return const HomeScreen();
              },));
            }, text: 'Retour à l\'accueil'),
          ],
        ),
      ),
    );
  }
}
