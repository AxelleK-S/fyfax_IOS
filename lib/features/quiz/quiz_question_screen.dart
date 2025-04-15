import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fyfax/features/quiz/logic/quiz_cubit.dart';
import 'package:fyfax/features/quiz/model/quiz_details.dart';
import 'package:fyfax/features/quiz/model/section_group.dart';
import 'package:fyfax/features/quiz/quiz_done_screen.dart';
import 'package:fyfax/shared/widgets/quiz_button.dart';
import 'package:fyfax/shared/widgets/quiz_validated_button.dart';
import 'package:google_fonts/google_fonts.dart';

class QuizQuestionScreen extends StatefulWidget {
  final QuizDetails quiz;
  final SectionGroup sectionGroup;
  const QuizQuestionScreen(
      {super.key, required this.quiz, required this.sectionGroup});

  @override
  State<QuizQuestionScreen> createState() => _QuizQuestionScreenState();
}

class _QuizQuestionScreenState extends State<QuizQuestionScreen> {
  String correctAnswers = '';
  List<bool> isClickedOption = [false, false, false, false, false];
  int questionClicked = 0;
  int activeQuestionIndex = 0;
  int activeSectionIndex = 0;
  int score = 0;
  int actualQuestion = 1;
  String baseUrl =
      'https://xtcqhaotzsxfzfygefrt.supabase.co/storage/v1/object/public/fyfax';
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => QuizCubit(),
      child: BlocListener<QuizCubit, QuizState>(
        listener: (context, state) {
          state.maybeWhen(
            error: (message) {
              var snackBar = SnackBar(
                content: Text(message,
                    style: GoogleFonts.inter(
                        color: Theme.of(context).colorScheme.error)),
                backgroundColor: Theme.of(context).colorScheme.onError,
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
            finished: (score) {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => QuizDoneScreen(
                  score: score,
                  quiz: widget.quiz,
                  totalPoint: widget.sectionGroup.numberOfQuestions,
                  sectionGroup: widget.sectionGroup,
                ),
              ));
            },
            loading: () {
              Future<void> showMyDialog() async {
                return showDialog<void>(
                  context: context,
                  barrierDismissible: false, // user must tap button!
                  builder: (BuildContext context) {
                    return const AlertDialog(
                      title: Text('Loading'),
                      content: SingleChildScrollView(
                        child: Center(
                            child: SizedBox(
                          height: 50,
                          width: 50,
                          child: (CircularProgressIndicator()),
                        )),
                      ),
                    );
                  },
                );
              }

              showMyDialog();
            },
            orElse: () {},
          );
        },
        child: BlocBuilder<QuizCubit, QuizState>(
          builder: (context, state) {
            return Scaffold(
              appBar: PreferredSize(
                  preferredSize: Size.fromHeight(widget
                              .sectionGroup
                              .sections[activeSectionIndex]
                              .question[activeQuestionIndex]
                              .image ==
                          ' '
                      ? 250
                      : 420),
                  child: Container(
                    margin: const EdgeInsets.only(left: 16, right: 16),
                    child: SafeArea(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            widget.sectionGroup
                                .sections[activeSectionIndex].statement,
                            style: GoogleFonts.inter(),
                            maxLines: 5,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height : 100,
                            child: SingleChildScrollView(
                              scrollDirection : Axis.horizontal,
                              child: Row(
                                children: [
                                  Text(
                                    widget
                                        .sectionGroup
                                        .sections[activeSectionIndex]
                                        .question[activeQuestionIndex]
                                        .statement,
                                    style: GoogleFonts.inter(),
                                    maxLines: 3,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Visibility(
                              visible: widget
                                          .sectionGroup
                                          .sections[activeSectionIndex]
                                          .question[activeQuestionIndex]
                                          .image ==
                                      ' '
                                  ? false
                                  : widget
                                              .sectionGroup
                                              .sections[activeSectionIndex]
                                              .question[activeQuestionIndex]
                                              .image ==
                                          null
                                      ? false
                                      : true,
                              child: Container(
                                height: 200,
                                margin: const EdgeInsets.only(
                                    //left: 16, right: 16,
                                    top: 14,
                                    bottom: 14),
                                /*decoration: BoxDecoration(
                                    image: widget
                                                .sectionGroup
                                                .sections[activeSectionIndex]
                                                .question[activeQuestionIndex]
                                                .image
                                                .split(',')
                                                .length >
                                            1
                                        ? null
                                        : DecorationImage(
                                            image: NetworkImage(
                                                '$baseUrl/${widget.sectionGroup.sections[activeSectionIndex].question[activeQuestionIndex].image.trimLeft()}'),
                                            fit: BoxFit.fill)),

                                 */
                                child: widget
                                            .sectionGroup
                                            .sections[activeSectionIndex]
                                            .question[activeQuestionIndex]
                                            .image!
                                            .split(',')
                                            .length >
                                        1
                                    ? Row(
                                        children: List.generate(
                                        widget
                                            .sectionGroup
                                            .sections[activeSectionIndex]
                                            .question[activeQuestionIndex]
                                            .image!
                                            .split(',')
                                            .length,
                                        (index) => SizedBox(
                                          height: 200,
                                          /*
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                '$baseUrl/${widget.sectionGroup.sections[activeSectionIndex].question[activeQuestionIndex].image.split(',')[index].trimLeft()}'),
                                            fit: BoxFit.fill)),

                                     */
                                          child: Image.network(
                                            '$baseUrl/${widget.sectionGroup.sections[activeSectionIndex].question[activeQuestionIndex].image?.split(',')[index].trimLeft()}',
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ))
                                    : Center(
                                        child: Image.network(
                                            '$baseUrl/${widget.sectionGroup.sections[activeSectionIndex].question[activeQuestionIndex].image?.trimLeft()}')),
                              )),
                          const SizedBox(
                            height: 6,
                          ),
                          Text(
                            'Question $actualQuestion/${widget.sectionGroup.numberOfQuestions}',
                            style: GoogleFonts.inter(fontWeight:  FontWeight.w600, color: Theme.of(context).colorScheme.primary),
                          )
                        ],
                      ),
                    ),
                  )),
              body: SingleChildScrollView(
                child: Column(children: [
                  QuizButton(
                      clicked: isClickedOption[0],
                      statement: widget
                          .sectionGroup
                          .sections[activeSectionIndex]
                          .question[activeQuestionIndex]
                          .option1,
                      onTap: () {
                        if (isClickedOption.contains(true)) {
                        } else {
                          showGreat(activeSectionIndex, activeQuestionIndex,
                              widget.sectionGroup);
                          setState(() {
                            isClickedOption[0] = true;
                            questionClicked = 0;
                          });
                        }
                      },
                      color: isClickedOption.contains(true)
                          ? widget
                                      .sectionGroup
                                      .sections[activeSectionIndex]
                                      .question[activeQuestionIndex]
                                      .greatAnswer ==
                                  'A'
                              ? Colors.green
                              : questionClicked == 0
                                  ? Colors.red
                                  : Colors.transparent
                          : Colors.transparent),
                  QuizButton(
                      clicked: isClickedOption[1],
                      statement: widget
                          .sectionGroup
                          .sections[activeSectionIndex]
                          .question[activeQuestionIndex]
                          .option2,
                      onTap: () {
                        if (isClickedOption.contains(true)) {
                        } else {
                          showGreat(activeSectionIndex, activeQuestionIndex,
                              widget.sectionGroup);
                          setState(() {
                            isClickedOption[1] = true;
                            questionClicked = 1;
                          });
                        }
                      },
                      color: isClickedOption.contains(true)
                          ? widget
                                      .sectionGroup
                                      .sections[activeSectionIndex]
                                      .question[activeQuestionIndex]
                                      .greatAnswer ==
                                  'B'
                              ? Colors.green
                              : questionClicked == 1
                                  ? Colors.red
                                  : Colors.transparent
                          : Colors.transparent),
                  QuizButton(
                      clicked: isClickedOption[2],
                      statement: widget
                          .sectionGroup
                          .sections[activeSectionIndex]
                          .question[activeQuestionIndex]
                          .option3,
                      onTap: () {
                        if (isClickedOption.contains(true)) {
                        } else {
                          showGreat(activeSectionIndex, activeQuestionIndex,
                              widget.sectionGroup);
                          setState(() {
                            isClickedOption[2] = true;
                            questionClicked = 2;
                          });
                        }
                      },
                      color: isClickedOption.contains(true)
                          ? widget
                                      .sectionGroup
                                      .sections[activeSectionIndex]
                                      .question[activeQuestionIndex]
                                      .greatAnswer ==
                                  'C'
                              ? Colors.green
                              : questionClicked == 2
                                  ? Colors.red
                                  : Colors.transparent
                          : Colors.transparent),
                  QuizButton(
                      clicked: isClickedOption[3],
                      statement: widget
                          .sectionGroup
                          .sections[activeSectionIndex]
                          .question[activeQuestionIndex]
                          .option4,
                      onTap: () {
                        if (isClickedOption.contains(true)) {
                        } else {
                          showGreat(activeSectionIndex, activeQuestionIndex,
                              widget.sectionGroup);
                          setState(() {
                            isClickedOption[3] = true;
                            questionClicked = 3;
                          });
                        }
                      },
                      color: isClickedOption.contains(true)
                          ? widget
                                      .sectionGroup
                                      .sections[activeSectionIndex]
                                      .question[activeQuestionIndex]
                                      .greatAnswer ==
                                  'D'
                              ? Colors.green
                              : questionClicked == 3
                                  ? Colors.red
                                  : Colors.transparent
                          : Colors.transparent),
                  QuizButton(
                      clicked: isClickedOption[4],
                      statement: widget
                          .sectionGroup
                          .sections[activeSectionIndex]
                          .question[activeQuestionIndex]
                          .option5,
                      onTap: () {
                        if (isClickedOption.contains(true)) {
                        } else {
                          showGreat(activeSectionIndex, activeQuestionIndex,
                              widget.sectionGroup);
                          setState(() {
                            isClickedOption[4] = true;
                            questionClicked = 4;
                          });
                        }
                      },
                      color: isClickedOption.contains(true)
                          ? widget
                                      .sectionGroup
                                      .sections[activeSectionIndex]
                                      .question[activeQuestionIndex]
                                      .greatAnswer ==
                                  'E'
                              ? Colors.green
                              : questionClicked == 4
                                  ? Colors.red
                                  : Colors.transparent
                          : Colors.transparent),

                  /*
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () => Navigator.of(context).pushNamed('/home'),
                    child: Container(
                      height: 54,
                      //width: 275,
                      margin: const EdgeInsets.only(
                          top: 24, bottom: 24, left: 16, right: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Theme.of(context).colorScheme.error,
                      ),
                      child: Center(
                          child: Text(
                        'Annuler',
                        style: GoogleFonts.inter(
                            color: Theme.of(context).colorScheme.onError,
                            fontSize: 24),
                      )),
                    ),
                  )

                   */
                ]),
              ),
              bottomNavigationBar: SizedBox(
                height: 160,
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Future<void> showMyDialog() async {
                          return showDialog<void>(
                            context: context,
                            barrierDismissible: false, // user must tap button!
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Annuler le quiz'),
                                content: const SingleChildScrollView(
                                  child: Center(
                                      child: SizedBox(
                                    height: 50,
                                    child: Text(
                                        'Etes-vous sur de vouloir annuler le quiz ?'),
                                  )),
                                ),
                                actions: [
                                  TextButton(
                                    child: Text('Oui',style: GoogleFonts.inter(color: Theme.of(context).colorScheme.error),),
                                    onPressed: () {
                                      Navigator.of(context).pushNamed('/home');
                                    },
                                  ),
                                  TextButton(
                                    child: Text('Non', style: GoogleFonts.inter(),),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        }

                        showMyDialog();
                      },
                      child: Container(
                        height: 54,
                        //width: 275,
                        margin: const EdgeInsets.only(
                            top: 20,
                            //bottom: 24,
                            left: 16,
                            right: 16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Theme.of(context).colorScheme.error,
                        ),
                        child: Center(
                            child: Text(
                          'Annuler',
                          style: GoogleFonts.inter(
                              color: Theme.of(context).colorScheme.onError,
                              fontSize: 24),
                        )),
                      ),
                    ),
                    QuizValidatedButton(
                        onTap: () {
                          if (kDebugMode) {
                            print(
                                'Section number ${widget.sectionGroup.sections.length}');
                            print(
                                'Question number ${widget.sectionGroup.sections[activeSectionIndex].question.length}');
                            print(widget.sectionGroup.sections.length <
                                (activeSectionIndex + 1));
                          }

                          List<String> answers = ['A', 'B', 'C', 'D', 'E'];

                          if (widget.sectionGroup.sections[activeSectionIndex]
                                  .question[activeQuestionIndex].greatAnswer ==
                              answers[isClickedOption.indexOf(true)]) {
                            score++;
                          }

                          if ((activeSectionIndex + 1) <
                              widget.sectionGroup.sections.length) {
                            if ((activeQuestionIndex + 1) <
                                widget.sectionGroup.sections[activeSectionIndex]
                                    .question.length) {
                              activeQuestionIndex++;
                              setState(() {
                                isClickedOption = [
                                  false,
                                  false,
                                  false,
                                  false,
                                  false
                                ];
                              });
                            } else {
                              activeSectionIndex++;
                              activeQuestionIndex = 0;
                              setState(() {
                                isClickedOption = [
                                  false,
                                  false,
                                  false,
                                  false,
                                  false
                                ];
                              });
                            }
                          } else {
                            if ((activeQuestionIndex + 1) <
                                widget.sectionGroup.sections[activeSectionIndex]
                                    .question.length) {
                              activeQuestionIndex++;
                              setState(() {
                                isClickedOption = [
                                  false,
                                  false,
                                  false,
                                  false,
                                  false
                                ];
                              });
                            } else {
                              print('finish');
                              context.read<QuizCubit>().finishQuiz(
                                  widget.quiz, widget.sectionGroup, score);
                            }
                          }
                          setState(() {
                            actualQuestion++;
                          });
                        },
                        text: (activeSectionIndex + 1) <
                                widget.sectionGroup.sections.length
                            ? 'Suivant'
                            : (activeQuestionIndex + 1) <
                                    widget
                                        .sectionGroup
                                        .sections[activeSectionIndex]
                                        .question
                                        .length
                                ? 'Suivant'
                                : 'Terminer'),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void showGreat(int sectionIndex, int questionIndex, SectionGroup quiz) {
    if (quiz.sections[sectionIndex].question[questionIndex].justification !=
        null) {
      var snackBar = SnackBar(
        duration: const Duration(seconds: 3),
        content: Text(
            'Justification ${quiz.sections[sectionIndex].question[questionIndex].justification}',
            style: GoogleFonts.inter(
                color: Theme.of(context).colorScheme.primary)),
        backgroundColor: Theme.of(context).colorScheme.surface,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  void countPoint() {}
}
