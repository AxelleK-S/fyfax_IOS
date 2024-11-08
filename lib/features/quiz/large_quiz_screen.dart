import 'package:flutter/material.dart';
import 'package:fyfax/features/quiz/logic/quiz_cubit.dart';
import 'package:fyfax/features/quiz/model/quiz_details.dart';
import 'package:fyfax/shared/widgets/offline_quiz_large_card.dart';
import 'package:fyfax/shared/widgets/quiz_large_card.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LargeQuizScreen extends StatelessWidget {
  const LargeQuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => QuizCubit()..getOffLineQuizzes(),
      child: const LargeQuizArea(),
    );
  }
}

class LargeQuizArea extends StatelessWidget {
  const LargeQuizArea({super.key});

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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Mes Epreuves',
                      style: GoogleFonts.handlee(fontSize: 16)),
                ],
              ),
            ),
          )),
      body: BlocListener<QuizCubit, QuizState>(
        listener: (context, state) {
          state.maybeWhen(
            error: (message) {
              var snackBar = SnackBar(
                content: Text(message,
                    style: GoogleFonts.handlee(
                        color: Theme.of(context).colorScheme.onError)),
                backgroundColor: Theme.of(context).colorScheme.error,
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
            notConnected: () {
              var snackBar = SnackBar(
                content: Text('Vous n\'êtes pas connecté à Internet',
                    style: GoogleFonts.handlee(
                        color: Theme.of(context).colorScheme.onError)),
                backgroundColor: Theme.of(context).colorScheme.error,
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
            orElse: () {},
          );
        },
        child: BlocBuilder<QuizCubit, QuizState>(
          builder: (context, state) {
            return state.maybeWhen(
              loading: () => Skeletonizer(
                  enabled: true,
                  child: SingleChildScrollView(
                    child: Column(
                      children: List.generate(
                        4,
                        (index) => Container(
                          height: 92,
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.only(
                              left: 16, right: 16, top: 7, bottom: 7),
                          padding: const EdgeInsets.only(left: 16, right: 16),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20)),
                        ),
                      ),
                    ),
                  )),
              /*success: (quizzes) => SingleChildScrollView(
                child: Column(
                    children: List.generate(
                  quizzes.length,
                  (index) => QuizLargeCard(quiz : quizzes[index]),
                )),
              ),*/
              offLineQuiz: (quizzes) => SingleChildScrollView(
                child: Column(
                    children: List.generate(
                  quizzes.length,
                  (index) => QuizLargeCard(
                    quiz: QuizDetails.fromJson(quizzes[index].toJson()),
                  ),
                )),
              ),
              empty: () => Center(
                child: Text('Aucun Quiz téléchargé',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface)),
              ),
              orElse: () => Center(
                child: Text(
                  'Aucun Quiz téléchargé',
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.onSurface),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
