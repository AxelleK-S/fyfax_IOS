import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fyfax/features/flyer/flyer_screen.dart';
import 'package:fyfax/features/quiz/logic/quiz_cubit.dart';
import 'package:fyfax/features/quiz/model/quiz_details.dart';
import 'package:fyfax/features/quiz/model/section_group.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MiniQuizScreen extends StatefulWidget {
  const MiniQuizScreen({super.key});

  @override
  State<MiniQuizScreen> createState() => _MiniQuizScreenState();
}

class _MiniQuizScreenState extends State<MiniQuizScreen> {
  final TextEditingController researchController = TextEditingController();
  final TextEditingController dropdownController = TextEditingController();
  int activeDomainIndex = 1;
  final List<String> titles = ['Médecine Générale', 'Odontologie', 'Pharmacie'];
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => QuizCubit()..getQuizzes(),
      child: Scaffold(
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
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                            onPressed: () =>
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const FlyerScreen(),
                                )),
                            icon: const Icon(
                              Iconsax.paperclip,
                              color: Colors.white,
                            ))
                      ],
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    Text('Bienvenu sur FyFax',
                        style: GoogleFonts.handlee(fontSize: 18)),
                    const SizedBox(
                      height: 14,
                    ),
                    Text('Préparez vous efficacement pour l\' ENSCT',
                        style: GoogleFonts.handlee(fontSize: 18)),
                    const SizedBox(
                      height: 14,
                    ),
                    Container(
                      width: 250,
                      margin: const EdgeInsets.only(
                          left: 25, right: 25, top: 7, bottom: 7),
                      padding: const EdgeInsets.only(
                        left: 5,
                        right: 5,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: Theme.of(context)
                            .colorScheme
                            .onPrimary
                            .withOpacity(0.5),
                      ),
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
                          onChanged: (value) {
                            setState(() {
                              searchQuery = value;
                            });
                            researchController.text = value;
                            researchController.selection =
                                TextSelection.fromPosition(
                                    TextPosition(offset: value.length));
                          },
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Search Quiz',
                              hintStyle: GoogleFonts.handlee(
                                  fontSize: 14,
                                  color: Theme.of(context)
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
                  // Populate section groups for each quiz
                  populateSectionGroups(quizzes);
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height: 8,),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                              return const FlyerScreen();
                            },));
                          },
                          child: CarouselSlider(
                              items: List.generate(1, (index) => Image.asset('assets/images/flyer.jpg', fit: BoxFit.fitHeight,),),
                              options: CarouselOptions(
                                height: 150,
                                viewportFraction: 0.98,
                                initialPage: 0,
                                enableInfiniteScroll: true,
                                reverse: false,
                                scrollDirection: Axis.horizontal,
                              )
                          ),
                        ),
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
                                child: Center(child: Text(titles[index], style: GoogleFonts.handlee(color: activeDomainIndex==index+1? Theme.of(context).colorScheme.onPrimary : Colors.black),)),
                              ),
                            ),),
                          ),
                        ),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: List.generate(
                              quizzes.where((element) => element.domain.id==activeDomainIndex,).toList().length,
                                  (quizIndex) => Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding:
                                    const EdgeInsets.only(left: 16, top: 24),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                            '${quizzes.where((element) => element.domain.id==activeDomainIndex,).toList()[quizIndex].name} ${quizzes[quizIndex].year}',
                                            style: GoogleFonts.handlee(
                                                fontSize: 16)),
                                        Visibility(
                                          visible: quizzes.where((element) => element.domain.id==activeDomainIndex,).toList()[quizIndex].sectionGroups.isEmpty ? false : true,
                                          child: IconButton(
                                            icon: const Icon(
                                              Iconsax.document_download,
                                              color: Colors.black,
                                            ),
                                            onPressed: () {
                                              context
                                                  .read<QuizCubit>()
                                                  .storeQuiz(quizzes.where((element) => element.domain.id==activeDomainIndex,).toList()[quizIndex]);
                                            },
                                          ),
                                        )
                                      ],
                                    ),
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
                                            quizzes.where((element) => element.domain.id==activeDomainIndex,).toList()[quizIndex]
                                                .sectionGroups
                                                .where(
                                                  (element) => element.title.title.toLowerCase()
                                                  .contains(
                                                  searchQuery.toLowerCase()),
                                            )
                                                .toList()
                                                .length,
                                                (sectionIndex) => Container(
                                              height: 108,
                                              width: 143,
                                              padding: const EdgeInsets.all(10),
                                              margin: const EdgeInsets.only(
                                                  left: 7, right: 7),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius.circular(20),
                                                  color: Colors.greenAccent),
                                              child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                                children: [
                                                  Text(
                                                      quizzes.where((element) => element.domain.id==activeDomainIndex,).toList()[quizIndex]
                                                          .sectionGroups.where(
                                                            (element) => element.title.title.toLowerCase()
                                                            .contains(
                                                            searchQuery.toLowerCase()),
                                                      )
                                                          .toList()[sectionIndex]
                                                          .title
                                                          .title,
                                                      textAlign: TextAlign.left,
                                                      style: GoogleFonts.handlee(
                                                          color: Colors.black)),
                                                  Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                    children: [
                                                      Text(
                                                          '${quizzes.where((element) => element.domain.id==activeDomainIndex,).toList()[quizIndex].sectionGroups.where(
                                                                (element) => element.title.title.toLowerCase()
                                                                .contains(
                                                                searchQuery.toLowerCase()),
                                                          )
                                                              .toList()[sectionIndex].numberOfQuestions.toString()} Qst',
                                                          textAlign: TextAlign.right,
                                                          style: GoogleFonts.handlee(
                                                              color: Colors.black)),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          )),
                                    ),
                                  ),
                                  const SizedBox(
                                      height:
                                      16), // Space between each year group
                                ],
                              ),
                            )),
                      ],
                    ),
                  );
                  /*
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

                 */
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
class MiniQuizScreen extends StatelessWidget {
  const MiniQuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => QuizCubit()..getQuizzes(),
      child: MiniQuizArea(),
    );
  }
}

class MiniQuizArea extends StatelessWidget {
  final TextEditingController researchController = TextEditingController();
  final TextEditingController dropdownController = TextEditingController();
  final List<String> titles = ['Médecine Générale', 'Odontologie', 'Pharmacie'];
  MiniQuizArea({super.key});

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
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                          onPressed: () =>
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const FlyerScreen(),
                              )),
                          icon: const Icon(
                            Iconsax.paperclip,
                            color: Colors.white,
                          ))
                    ],
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  Text('Bienvenu sur FyFax',
                      style: GoogleFonts.handlee(fontSize: 18)),
                  const SizedBox(
                    height: 14,
                  ),
                  Text('Préparez vous efficacement pour l\' ENSCT',
                      style: GoogleFonts.handlee(fontSize: 18)),
                  const SizedBox(
                    height: 14,
                  ),
                  Container(
                    width: 250,
                    margin: const EdgeInsets.only(
                        left: 25, right: 25, top: 7, bottom: 7),
                    padding: const EdgeInsets.only(
                      left: 5,
                      right: 5,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: Theme.of(context)
                          .colorScheme
                          .onPrimary
                          .withOpacity(0.5),
                    ),
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
                        onChanged: (value) {
                          researchController.text = value;
                          researchController.selection =
                              TextSelection.fromPosition(
                                  TextPosition(offset: value.length));
                        },
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Search Quiz',
                            hintStyle: GoogleFonts.handlee(
                                fontSize: 14,
                                color: Theme.of(context)
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
                // Populate section groups for each quiz
                populateSectionGroups(quizzes);
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 8,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          DropdownMenu(
                            onSelected: (value) {
                              print(dropdownController.text);
                              print(titles.indexOf(dropdownController.text));
                              print(quizzes[0].domain.id);
                              print(quizzes[0].domain.name);
                            },
                            initialSelection: 0,
                              controller: dropdownController,
                              dropdownMenuEntries: List.generate(
                            3,
                            (index) => DropdownMenuEntry(
                                value: index, label: titles[index]),
                          ))
                          //DomainTab(),
                          //Put dropdown
                        ],
                      ),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: List.generate(
                            quizzes.where((element) => element.domain.id==1,).toList().length,
                            (quizIndex) => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 16, top: 24),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                          '${quizzes.where((element) => element.domain.id==1,).toList()[quizIndex].name} ${quizzes[quizIndex].year}',
                                          style: GoogleFonts.handlee(
                                              fontSize: 16)),
                                      IconButton(
                                        icon: const Icon(
                                          Iconsax.document_download,
                                          color: Colors.black,
                                        ),
                                        onPressed: () {
                                          context
                                              .read<QuizCubit>()
                                              .storeQuiz(quizzes.where((element) => element.domain.id==1,).toList()[quizIndex]);
                                        },
                                      )
                                    ],
                                  ),
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
                                      quizzes.where((element) => element.domain.id==1,).toList()[quizIndex]
                                          .sectionGroups
                                          .where(
                                            (element) => element.title.title
                                                .contains(
                                                    researchController.text),
                                          )
                                          .toList()
                                          .length,
                                      (sectionIndex) => Container(
                                        height: 108,
                                        width: 143,
                                        padding: const EdgeInsets.all(10),
                                        margin: const EdgeInsets.only(
                                            left: 7, right: 7),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: Colors.greenAccent),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Text(
                                                quizzes.where((element) => element.domain.id==1,).toList()[quizIndex]
                                                    .sectionGroups[sectionIndex]
                                                    .title
                                                    .title,
                                                textAlign: TextAlign.left,
                                                style: GoogleFonts.handlee(
                                                    color: Colors.black)),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                    '${quizzes.where((element) => element.domain.id==1,).toList()[quizIndex].sectionGroups[sectionIndex].numberOfQuestions.toString()} Qst',
                                                    textAlign: TextAlign.right,
                                                    style: GoogleFonts.handlee(
                                                        color: Colors.black)),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    )),
                                  ),
                                ),
                                const SizedBox(
                                    height:
                                        16), // Space between each year group
                              ],
                            ),
                          )),
                    ],
                  ),
                );
                /*
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

                 */
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
