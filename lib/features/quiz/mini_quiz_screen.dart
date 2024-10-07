import 'package:flutter/material.dart';
import 'package:fyfax/shared/widgets/quiz_mini_card.dart';
import 'package:google_fonts/google_fonts.dart';

class MiniQuizScreen extends StatelessWidget {
  const MiniQuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(223),
          child: Container(
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(60),
                    bottomRight: Radius.circular(60))),
            child: SafeArea(
              child: Column(
                children: [
                  Text('Bienvenu sur FyFax', style: GoogleFonts.handlee()),
                  const SizedBox(
                    height: 24,
                  ),
                  Text('Préparez vou efficacement pour l\' ENSCT', style: GoogleFonts.handlee()),
                  const SizedBox(
                    height: 24,
                  ),
                ],
              ),
            ),
          )),
      body: SingleChildScrollView(
        child: Column(
          children: List.generate(
            3,
            (index) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 16,
                    top: 24
                  ),
                  child: Text('Session 2024', style: GoogleFonts.handlee()),
                ),
                const SizedBox(
                  height: 24,
                ),
                Container(
                  margin: const EdgeInsets.only(
                    left: 16,
                    right: 16,
                  ),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                        child: Row(
                  children: List.generate(
                    4,
                    (index) =>
                        const QuizMiniCard(title: 'Med Gen', numberQuestions: 30),
                  ),
                )))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
