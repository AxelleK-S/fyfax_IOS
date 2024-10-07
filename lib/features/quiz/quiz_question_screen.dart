import 'package:flutter/material.dart';
import 'package:fyfax/features/quiz/quiz_done_screen.dart';
import 'package:fyfax/shared/widgets/quiz_button.dart';
import 'package:fyfax/shared/widgets/quiz_validated_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

class QuizQuestionScreen extends StatefulWidget {
  const QuizQuestionScreen({super.key});

  @override
  State<QuizQuestionScreen> createState() => _QuizQuestionScreenState();
}

class _QuizQuestionScreenState extends State<QuizQuestionScreen> {
  int correctAnswers = 0;
  List<String> answers = [
    'Dilatation de bronches',
    'Empyème',
    'Mésotheliome',
    'Carcinome bronchique',
    'Abcès du poumon',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(110),
          child: Container(
            margin: const EdgeInsets.only(left: 16, right: 16),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Iconsax.arrow_left),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Un homme de 67 ans se présente avec des pertes de poid, toux, engourdissement et picotement dans ses mains et pieds associés à la faiblesse musculaire',
                    style: GoogleFonts.handlee(),
                    maxLines: 5,
                  ),
                ],
              ),
            ),
          )),
      body: SingleChildScrollView(
        child: Column(
          children: List.generate(
            5,
            (index) => QuizButton(
                clicked: false,
                statement: answers[index],
                onTap: () {
                  if (correctAnswers == 0) {
                    setState(() {
                      correctAnswers = 3;
                    });
                  }
                },
                color: correctAnswers == index + 1
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.error),
          ),
        ),
      ),
      bottomNavigationBar: QuizValidatedButton(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const QuizDoneScreen(),
            ));
          },
          text: 'Suivant'),
    );
  }
}
