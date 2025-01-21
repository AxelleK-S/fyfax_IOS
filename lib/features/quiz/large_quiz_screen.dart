import 'package:flutter/material.dart';
import 'package:fyfax/features/quiz/logic/quiz_cubit.dart';
import 'package:fyfax/features/quiz/model/quiz_details.dart';
import 'package:fyfax/features/quiz/model/section_group.dart';
import 'package:fyfax/shared/widgets/quiz_large_card.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LargeQuizScreen extends StatefulWidget {
  const LargeQuizScreen({super.key});

  @override
  State<LargeQuizScreen> createState() => _LargeQuizScreenState();
}

class _LargeQuizScreenState extends State<LargeQuizScreen> {
  int activeDomainIndex = 1;
  final List<String> titles = ['Médecine Générale', 'Odontologie', 'Pharmacie'];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => QuizCubit()..getOffLineQuizzes(),
      child: Scaffold(
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
                        style: GoogleFonts.inter(fontSize: 16)),
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
                      style: GoogleFonts.inter(
                          color: Theme.of(context).colorScheme.onError)),
                  backgroundColor: Theme.of(context).colorScheme.error,
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
              notConnected: () {
                var snackBar = SnackBar(
                  content: Text('Vous n\'êtes pas connecté à Internet',
                      style: GoogleFonts.inter(
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
                success: (quizzes) {
                  populateSectionGroups(quizzes);
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height: 8,),
                        Container(
                          height: 40,
                          padding: const EdgeInsets.only(
                              left: 6,
                              right: 6,
                              top: 4,
                              bottom: 4
                          ),
                          margin: const EdgeInsets.only(
                              left: 16,
                              right: 16,
                              top: 14,
                              bottom: 14
                          ),
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: List.generate(3, (index) => GestureDetector(
                              onTap: () {
                                setState(() {
                                  activeDomainIndex = index+1;
                                });
                              },
                              child: Container(
                                margin: const EdgeInsets.only(
                                  left: 4,
                                  right: 4,
                                ),
                                padding: const EdgeInsets.only(
                                  left: 4,
                                  right: 4,
                                ),
                                decoration: BoxDecoration(
                                    color: activeDomainIndex==index+1? Theme.of(context).colorScheme.primary : Colors.grey.shade100,
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child: Center(child: Text(titles[index], style: GoogleFonts.inter(color: activeDomainIndex==index+1? Theme.of(context).colorScheme.onPrimary : Colors.black),)),
                              ),
                            ),),
                          ),
                        ),

                        //Quizzes
                        Column(
                            children: List.generate(
                              quizzes.where((element) => element.domain.id==activeDomainIndex,).toList().length,
                                  (quizIndex) => Column(
                                children: [
                                  Text(
                                      '${quizzes.where((element) => element.domain.id==activeDomainIndex,).toList()[quizIndex].name} ${quizzes.where((element) => element.domain.id==activeDomainIndex,).toList()[quizIndex].year}',
                                      style: GoogleFonts.inter(fontSize: 16)),
                                  Column(
                                    children: List.generate(
                                      quizzes.where((element) => element.domain.id==activeDomainIndex,).toList()[quizIndex].sectionGroups.length,
                                          (sectionIndex) => QuizLargeCard(
                                        quiz: quizzes.where((element) => element.domain.id==activeDomainIndex,).toList()[quizIndex],
                                        sectionGroup: quizzes.where((element) => element.domain.id==activeDomainIndex,).toList()[quizIndex]
                                            .sectionGroups[sectionIndex],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )),
                      ],
                    ),
                  );
                },
                offLineQuiz: (quizzes) {
                  List<QuizDetails> quizzesD = [];
                  for (var quiz in quizzes) {
                    quizzesD.add(QuizDetails.fromJson(quiz.toJson()));
                  }
                  populateSectionGroups(quizzesD);
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height: 8,),
                        Container(
                          height: 40,
                          padding: const EdgeInsets.only(
                              left: 6,
                              right: 6,
                              top: 4,
                              bottom: 4
                          ),
                          margin: const EdgeInsets.only(
                              left: 16,
                              right: 16,
                              top: 14,
                              bottom: 14
                          ),
                          decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: List.generate(3, (index) => GestureDetector(
                              onTap: () {
                                setState(() {
                                  activeDomainIndex = index+1;
                                });
                              },
                              child: Container(
                                margin: const EdgeInsets.only(
                                  left: 4,
                                  right: 4,
                                ),
                                padding: const EdgeInsets.only(
                                  left: 4,
                                  right: 4,
                                ),
                                decoration: BoxDecoration(
                                    color: activeDomainIndex==index+1? Theme.of(context).colorScheme.primary : Colors.grey.shade100,
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child: Center(child: Text(titles[index], style: GoogleFonts.inter(color: activeDomainIndex==index+1? Theme.of(context).colorScheme.onPrimary : Colors.black),)),
                              ),
                            ),),
                          ),
                        ),

                        //Quizzes
                        Column(
                            children: List.generate(
                              quizzesD.where((element) => element.domain.id==activeDomainIndex,).toList().length,
                                  (quizIndex) => Column(
                                children: [
                                  Text(
                                      '${quizzesD.where((element) => element.domain.id==activeDomainIndex,).toList()[quizIndex].name} ${quizzesD.where((element) => element.domain.id==activeDomainIndex,).toList()[quizIndex].year}',
                                      style: GoogleFonts.inter(fontSize: 16)),
                                  Column(
                                    children: List.generate(
                                      quizzesD.where((element) => element.domain.id==activeDomainIndex,).toList()[quizIndex].sectionGroups.length,
                                          (sectionIndex) => QuizLargeCard(
                                        quiz: quizzesD.where((element) => element.domain.id==activeDomainIndex,).toList()[quizIndex],
                                        sectionGroup: quizzesD.where((element) => element.domain.id==activeDomainIndex,).toList()[quizIndex]
                                            .sectionGroups[sectionIndex],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )),
                      ],
                    ),
                  );
                },
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
      ),
    );
  }

  void populateSectionGroups(List<QuizDetails> quizzes) {
    for (var quiz in quizzes) {
      final Map<String, SectionGroup> groupedSections = {};

      for (var section in quiz.section) {
        final titleKey =
            section.title.title; // Assuming title has a 'name' property

        if (!groupedSections.containsKey(titleKey)) {
          groupedSections[titleKey] = SectionGroup(
            title: section.title,
            sections: [],
          );
        }
        groupedSections[titleKey]!.sections.add(section);
      }

      // Assign grouped sections to the quiz
      quiz.sectionGroups = groupedSections.values.toList();

      // Optionally recalculate number of questions for each group (already calculated in constructor)
      for (var group in quiz.sectionGroups) {
        group.calculateNumberOfQuestions();
      }
    }
  }
}


/*
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
                      style: GoogleFonts.inter(fontSize: 16)),
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
                    style: GoogleFonts.inter(
                        color: Theme.of(context).colorScheme.onError)),
                backgroundColor: Theme.of(context).colorScheme.error,
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
            notConnected: () {
              var snackBar = SnackBar(
                content: Text('Vous n\'êtes pas connecté à Internet',
                    style: GoogleFonts.inter(
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
              success: (quizzes) {
                populateSectionGroups(quizzes);
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 8,),
                      Container(
                        height: 40,
                        padding: const EdgeInsets.only(
                            left: 6,
                            right: 6,
                            top: 4,
                            bottom: 4
                        ),
                        margin: const EdgeInsets.only(
                            left: 16,
                            right: 16,
                            top: 14,
                            bottom: 14
                        ),
                        decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Row(
                          children: List.generate(3, (index) => GestureDetector(
                            onTap: () {
                              setState(() {
                                activeDomainIndex = index+1;
                              });
                            },
                            child: Container(
                              margin: const EdgeInsets.only(
                                left: 4,
                                right: 4,
                              ),
                              padding: const EdgeInsets.only(
                                left: 4,
                                right: 4,
                              ),
                              decoration: BoxDecoration(
                                  color: activeDomainIndex==index+1? Theme.of(context).colorScheme.primary : Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              child: Center(child: Text(titles[index], style: GoogleFonts.inter(color: activeDomainIndex==index+1? Theme.of(context).colorScheme.onPrimary : Colors.black),)),
                            ),
                          ),),
                        ),
                      ),

                      //Quizzes
                      Column(
                          children: List.generate(
                        quizzes.length,
                        (quizIndex) => Column(
                          children: [
                            Text(
                                '${quizzes[quizIndex].name} ${quizzes[quizIndex].year}',
                                style: GoogleFonts.inter(fontSize: 16)),
                            Column(
                              children: List.generate(
                                quizzes[quizIndex].sectionGroups.length,
                                (sectionIndex) => QuizLargeCard(
                                  quiz: quizzes[quizIndex],
                                  sectionGroup: quizzes[quizIndex]
                                      .sectionGroups[sectionIndex],
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),
                    ],
                  ),
                );
              },
              offLineQuiz: (quizzes) {
                List<QuizDetails> quizzesD = [];
                for (var quiz in quizzes) {
                  quizzesD.add(QuizDetails.fromJson(quiz.toJson()));
                }
                populateSectionGroups(quizzesD);
                return SingleChildScrollView(
                  child: Column(
                      children: List.generate(
                    quizzes.length,
                    (quizIndex) => Column(
                      children: [
                        Text(
                            '${quizzesD[quizIndex].name} ${quizzesD[quizIndex].year}',
                            style: GoogleFonts.inter(fontSize: 16)),
                        Column(
                          children: List.generate(
                            quizzesD[quizIndex].sectionGroups.length,
                            (sectionIndex) => QuizLargeCard(
                              quiz: quizzesD[quizIndex],
                              sectionGroup: quizzesD[quizIndex]
                                  .sectionGroups[sectionIndex],
                            ),
                          ),
                        )
                      ],
                    ),
                  )),
                );
              },
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

  void populateSectionGroups(List<QuizDetails> quizzes) {
    for (var quiz in quizzes) {
      final Map<String, SectionGroup> groupedSections = {};

      for (var section in quiz.section) {
        final titleKey =
            section.title.title; // Assuming title has a 'name' property

        if (!groupedSections.containsKey(titleKey)) {
          groupedSections[titleKey] = SectionGroup(
            title: section.title,
            sections: [],
          );
        }
        groupedSections[titleKey]!.sections.add(section);
      }

      // Assign grouped sections to the quiz
      quiz.sectionGroups = groupedSections.values.toList();

      // Optionally recalculate number of questions for each group (already calculated in constructor)
      for (var group in quiz.sectionGroups) {
        group.calculateNumberOfQuestions();
      }
    }
  }
}

 */
