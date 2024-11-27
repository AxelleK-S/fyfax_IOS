import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fyfax/features/quiz/logic/quiz_cubit.dart';
import 'package:fyfax/features/quiz/model/quiz_details.dart';
import 'package:fyfax/features/quiz/quiz_done_screen.dart';
import 'package:fyfax/shared/widgets/quiz_button.dart';
import 'package:fyfax/shared/widgets/quiz_validated_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

class QuizQuestionScreen extends StatefulWidget {
  final QuizDetails quiz;
  const QuizQuestionScreen({super.key, required this.quiz});

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
                    style: GoogleFonts.handlee(
                        color: Theme.of(context).colorScheme.onError)),
                backgroundColor: Theme.of(context).colorScheme.error,
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
            finished: (score) {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => QuizDoneScreen(score: score, quiz: widget.quiz, totalPoint: widget.quiz.questionNumber,),
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
                              child: (
                                  CircularProgressIndicator()
                              ),
                            )
                        ),
                      ),
                    );
                  },
                );
              }
              showMyDialog();
            },
            orElse: () {

          },);
        },
        child: BlocBuilder<QuizCubit, QuizState>(
            builder: (context, state) {
              return Scaffold(
                          appBar: PreferredSize(
                              preferredSize: const Size.fromHeight(250),
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
                                        widget.quiz.section[activeSectionIndex].statement,
                                        style: GoogleFonts.handlee(),
                                        maxLines: 5,
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        widget.quiz.section[activeSectionIndex]
                                            .question[activeQuestionIndex].statement,
                                        style: GoogleFonts.handlee(),
                                        maxLines: 5,
                                      ),
                                    ],
                                  ),
                                ),
                              )),
                          body: SingleChildScrollView(
                            child: Column(children: [
                              QuizButton(
                                  clicked: isClickedOption[0],
                                  statement: widget.quiz.section[activeSectionIndex]
                                      .question[activeQuestionIndex].option1,
                                  onTap: () {
                                    showGreat(activeSectionIndex, activeQuestionIndex, widget.quiz);
                                    setState(() {
                                      isClickedOption[0] = true;
                                      questionClicked = 0;
                                    });
                                  },
                                  color: isClickedOption.contains(true)
                                      ? widget.quiz.section[activeSectionIndex]
                                      .question[activeQuestionIndex].greatAnswer ==
                                      'A'
                                      ? Colors.green
                                      : questionClicked == 0
                                      ? Colors.red
                                      : Colors.transparent
                                      : Colors.transparent),
                              QuizButton(
                                  clicked: isClickedOption[1],
                                  statement: widget.quiz.section[activeSectionIndex]
                                      .question[activeQuestionIndex].option2,
                                  onTap: () {
                                    showGreat(activeSectionIndex, activeQuestionIndex, widget.quiz);
                                    setState(() {
                                      isClickedOption[1] = true;
                                      questionClicked = 1;
                                    });
                                  },
                                  color: isClickedOption.contains(true)
                                      ? widget.quiz.section[activeSectionIndex]
                                      .question[activeQuestionIndex].greatAnswer ==
                                      'B'
                                      ? Colors.green
                                      : questionClicked == 1
                                      ? Colors.red
                                      : Colors.transparent
                                      : Colors.transparent),
                              QuizButton(
                                  clicked: isClickedOption[2],
                                  statement: widget.quiz.section[activeSectionIndex]
                                      .question[activeQuestionIndex].option3,
                                  onTap: () {
                                    showGreat(activeSectionIndex, activeQuestionIndex, widget.quiz);
                                    setState(() {
                                      isClickedOption[2] = true;
                                      questionClicked = 2;
                                    });
                                  },
                                  color: isClickedOption.contains(true)
                                      ? widget.quiz.section[activeSectionIndex]
                                      .question[activeQuestionIndex].greatAnswer ==
                                      'C'
                                      ? Colors.green
                                      : questionClicked == 2
                                      ? Colors.red
                                      : Colors.transparent
                                      : Colors.transparent),
                              QuizButton(
                                  clicked: isClickedOption[3],
                                  statement: widget.quiz.section[activeSectionIndex]
                                      .question[activeQuestionIndex].option4,
                                  onTap: () {
                                    showGreat(activeSectionIndex, activeQuestionIndex, widget.quiz);
                                    setState(() {
                                      isClickedOption[3] = true;
                                      questionClicked = 3;
                                    });
                                  },
                                  color: isClickedOption.contains(true)
                                      ? widget.quiz.section[activeSectionIndex]
                                      .question[activeQuestionIndex].greatAnswer ==
                                      'D'
                                      ? Colors.green
                                      : questionClicked == 3
                                      ? Colors.red
                                      : Colors.transparent
                                      : Colors.transparent),
                              QuizButton(
                                  clicked: isClickedOption[4],
                                  statement: widget.quiz.section[activeSectionIndex]
                                      .question[activeQuestionIndex].option5,
                                  onTap: () {
                                    showGreat(activeSectionIndex, activeQuestionIndex, widget.quiz);
                                    setState(() {
                                      isClickedOption[4] = true;
                                      questionClicked = 4;
                                    });
                                  },
                                  color: isClickedOption.contains(true)
                                      ? widget.quiz.section[activeSectionIndex]
                                                  .question[activeQuestionIndex].greatAnswer ==
                                              'E'
                                          ? Colors.green
                                          : questionClicked == 4
                                              ? Colors.red
                                              : Colors.transparent
                                      : Colors.transparent),

                              const SizedBox(height: 20,),

                              GestureDetector(
                                onTap: () => Navigator.of(context).pushNamed('/home'),
                                child: Container(
                                  height: 54,
                                  //width: 275,
                                  margin : const EdgeInsets.only(
                                      top: 24,
                                      bottom: 24,
                                      left: 16,
                                      right: 16
                                  ),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: Theme.of(context).colorScheme.error,),
                                  child: Center(
                                      child: Text(
                                        'Annuler',
                                        style: GoogleFonts.handlee(
                                            color: Theme.of(context).colorScheme.onError,
                                            fontSize: 24),
                                      )
                                  ),
                                ),
                              )
                            ]),
                          ),
                          bottomNavigationBar: QuizValidatedButton(
                              onTap: () {
                                if (kDebugMode) {
                                  print('Section number ${widget.quiz.section.length}');
                                  print(
                                      'Question number ${widget.quiz.section[activeSectionIndex].question.length}');
                                  print(widget.quiz.section.length<(activeSectionIndex+1));
                                }

                                List<String> answers = ['A','B', 'C', 'D', 'E'];

                                if(widget.quiz.section[activeSectionIndex]
                                    .question[activeQuestionIndex].greatAnswer == answers[isClickedOption.indexOf(true)]){
                                  score ++;
                                }

                                if ((activeSectionIndex+1)<widget.quiz.section.length) {
                                  if ((activeQuestionIndex+1)<widget.quiz.section[activeSectionIndex].question.length
                                      ) {
                                    activeQuestionIndex++;
                                    setState(() {
                                      isClickedOption = [false, false,false,false,false];
                                    });
                                  } else {
                                    activeSectionIndex++;
                                    activeQuestionIndex = 0;
                                    setState(() {
                                      isClickedOption = [false, false,false,false,false];
                                    });
                                  }
                                } else {
                                  print('finish');
                                  context.read<QuizCubit>().finishQuiz(widget.quiz, score);
                                }
                              },
                              text: (activeSectionIndex+1)<widget.quiz.section.length
                                  ? 'Suivant'
                                  : 'Terminer'),
                        );
            },
),
),
);
  }

  void showGreat(int sectionIndex, int questionIndex, QuizDetails quiz){
    if (quiz.section[sectionIndex].question[questionIndex].justification!=null){
      var snackBar = SnackBar(
        duration: const Duration(seconds: 3),
        content: Text('Justification ${quiz.section[sectionIndex].question[questionIndex].justification}',
            style: GoogleFonts.handlee(
                color: Theme.of(context).colorScheme.primary)),
        backgroundColor: Theme.of(context).colorScheme.surface,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  void countPoint(){

  }
}
