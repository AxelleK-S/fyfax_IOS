import 'package:flutter/material.dart';
import 'package:fyfax/shared/widgets/quiz_large_card.dart';
import 'package:google_fonts/google_fonts.dart';

class LargeQuizScreen extends StatelessWidget {
  const LargeQuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(80),
          child: Container(
            decoration:
            BoxDecoration(color: Theme.of(context).colorScheme.primary),
            child: SafeArea(
              child: Column(
                children: [
                  Text('Mes Epreuves',style: GoogleFonts.handlee()),
                ],
              ),
            ),
          )),
      body: const Column(
        children: [
          QuizLargeCard(title: 'Médécine Générale', numberQuestions: 30),
          QuizLargeCard(title: 'Médécine Générale', numberQuestions: 30),
          QuizLargeCard(title: 'Médécine Générale', numberQuestions: 30),
          QuizLargeCard(title: 'Médécine Générale', numberQuestions: 30),
        ],
      ),
    );
  }
}
