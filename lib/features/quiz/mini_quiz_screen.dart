import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fyfax/features/quiz/logic/quiz_cubit.dart';
import 'package:fyfax/features/quiz/model/quiz_details.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MiniQuizScreen extends StatelessWidget {
  const MiniQuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => QuizCubit()..getQuizzes(),
      child: const MiniQuizArea(),
    );
  }
}

class MiniQuizArea extends StatelessWidget {
  const MiniQuizArea({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController researchController = TextEditingController();
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
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 24,
                  ),
                  Text('Bienvenu sur FyFax', style: GoogleFonts.handlee(fontSize: 18)),
                  const SizedBox(
                    height: 24,
                  ),
                  Text('Préparez vou efficacement pour l\' ENSCT',
                      style: GoogleFonts.handlee(fontSize: 18)),
                  const SizedBox(
                    height: 24,
                  ),
                  Container(
                    width: 250,
                    margin:
                    const EdgeInsets.only(left: 25, right: 25, top: 7, bottom: 7),
                    padding: const EdgeInsets.only(
                      left: 5,
                      right: 5,
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: Theme.of(context)
                            .colorScheme
                            .onPrimary.withOpacity(0.5),),
                    child: Center(
                      child: TextFormField(
                        controller: researchController,
                        style: GoogleFonts.handlee(
                          fontSize: 14,
                        ),
                        onTapOutside: (event) {
                          FocusScope.of(context).unfocus();
                          if (kDebugMode) {
                            print(researchController.text);
                          }
                        },
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Search Quiz',
                            hintStyle: GoogleFonts.handlee(fontSize: 14, color: Theme.of(context)
                                .colorScheme
                                .surface
                                .withOpacity(0.7)),
                            icon: Icon(
                              Iconsax.search_normal,
                              color: Theme.of(context)
                                  .colorScheme
                                  .surface
                                  .withOpacity(0.7),
                            )),
                      ),
                    ),
                  )
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
            done: () {
              var snackBar = SnackBar(
                content: Text('Téléchargement reussi',
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
                  child: SingleChildScrollView(
                child: Column(
                  children: List.generate(
                    3,
                    (index) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 16, top: 24),
                          child: Text('Session 2024',
                              style: GoogleFonts.handlee(fontSize: 16)),
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
                                    (index) => Container(
                                      height: 108,
                                      width: 143,
                                      padding: const EdgeInsets.all(10),
                                      margin: const EdgeInsets.only(
                                          left: 7, right: 7),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                    ),
                                  ),
                                )))
                      ],
                    ),
                  ),
                ),
              )),
              success: (quizzes) {
                Map<int, List<QuizDetails>> groupedQuizzes =
                    groupQuizzesByYear(quizzes);
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: groupedQuizzes.entries.map((entry) {
                      int year = entry.key;
                      List<QuizDetails> quizzesList = entry.value;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 16, top: 24),
                            child: Text('Session $year',
                                style: GoogleFonts.handlee(fontSize: 16)),
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
                                children: quizzesList.where((element) => element.name.contains(researchController.text),).toList().map((quiz) {
                                  return Container(
                                    height: 108,
                                    width: 143,
                                    padding: const EdgeInsets.all(10),
                                    margin: const EdgeInsets.only(left: 7, right: 7),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20), color: Colors.greenAccent),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(quiz.name, textAlign: TextAlign.left, style: GoogleFonts.handlee(color: Colors.black)),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('${quiz.questionNumber.toString()} Qst',
                                                textAlign: TextAlign.right, style: GoogleFonts.handlee(color: Colors.black)),
                                            IconButton(
                                              icon: const Icon(Iconsax.document_download, color: Colors.black,),
                                              onPressed: () {
                                                context.read<QuizCubit>().storeQuiz(quiz);
                                              },
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                          SizedBox(height: 16), // Space between each year group
                        ],
                      );
                    }).toList(),
                  ),
                );
              },
             /* offLineQuiz: (quizzes) {
                Map<int, List<QuizDetails>> groupedQuizzes =
                    groupQuizzesByYear(quizzes);
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: groupedQuizzes.entries.map((entry) {
                      int year = entry.key;
                      List<QuizDetails> quizzesList = entry.value;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 16, top: 24),
                            child: Text('Session $year',
                                style: GoogleFonts.handlee()),
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
                                children: quizzesList.map((quiz) {
                                  return GestureDetector(
                                      onTap: () => Navigator.of(context)
                                              .push(MaterialPageRoute(
                                            builder: (context) =>
                                                QuizWelcomeScreen(quiz: quiz),
                                          )),
                                      child: QuizMiniCard(
                                          title: quiz.domain.name,
                                          numberQuestions: 30));
                                }).toList(),
                              ),
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                );
              },*/
              orElse: () => Skeletonizer(
                  child: SingleChildScrollView(
                    child: Column(
                      children: List.generate(
                        3,
                            (index) => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 16, top: 24),
                              child: Text('Session 2024',
                                  style: GoogleFonts.handlee(fontSize: 16)),
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
                                            (index) => Container(
                                          height: 108,
                                          width: 143,
                                          padding: const EdgeInsets.all(10),
                                          margin: const EdgeInsets.only(
                                              left: 7, right: 7),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(20)),
                                        ),
                                      ),
                                    )))
                          ],
                        ),
                      ),
                    ),
                  )),
            );
          },
        ),
      ),
    );
  }

  Map<int, List<QuizDetails>> groupQuizzesByYear(List<QuizDetails> quizzes) {
    Map<int, List<QuizDetails>> groupedQuizzes = {};

    for (var quiz in quizzes) {
      if (!groupedQuizzes.containsKey(quiz.year)) {
        groupedQuizzes[quiz.year] = [];
      }
      groupedQuizzes[quiz.year]!.add(quiz);
    }

    return groupedQuizzes;
  }
}
