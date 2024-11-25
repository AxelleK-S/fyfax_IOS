import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:fyfax/features/historical/model/historical.dart';
import 'package:fyfax/features/historical/repository/historical_repository.dart';
import 'package:fyfax/features/quiz/model/quiz_details.dart';
import 'package:fyfax/features/quiz/repository/quiz_repository.dart';
import 'package:fyfax/shared/hive/model/offline_quiz.dart';
import 'package:fyfax/shared/services/hive_service.dart';
import 'package:fyfax/shared/hive/model/historical.dart' as hs;

part 'quiz_state.dart';
part 'quiz_cubit.freezed.dart';

class QuizCubit extends Cubit<QuizState> {
  QuizRepository quizRepository = QuizRepository();
  HistoricalRepository historicalRepository = HistoricalRepository();
  final HiveService hiveService = HiveService();
  late StreamSubscription<List<ConnectivityResult>> connectivitySubscription;
  QuizCubit() : super(const QuizState.initial());

  Future<void> getQuizzes() async {
    final List<ConnectivityResult> connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.none)) {
      emit(const QuizState.notConnected());

      emit(const QuizState.loading());
      try {
        List<OfflineQuiz> offlineQuiz = await hiveService.getAllQuiz();
        if (offlineQuiz == []) {
          emit(const QuizState.empty());
        } else {
          /*
              List<QuizDetails> quizDetails = [];
              for (var quiz in offlineQuiz){
                quizDetails.add(QuizDetails.fromJson(quiz.toJson()));
              }
               */
          print(offlineQuiz);
          emit(QuizState.offLineQuiz(quizzes: offlineQuiz));
        }
      } catch (e) {
        emit(const QuizState.error(error: 'Une erreur est survenue'));
      }
    } else {
      emit(const QuizState.loading());
      try {
        List<QuizDetails>? quizzes =
        await quizRepository.getQuizWithDetails();
        if (quizzes == []) {
          emit(const QuizState.empty());
        } else {
          emit(QuizState.success(quizzes: quizzes));
        }
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
        emit(const QuizState.error(error: 'Une erreur est survenue'));
      }
    }

    /*
    connectivitySubscription = Connectivity().onConnectivityChanged.listen(
      (result) async {
        if (!result.contains(ConnectivityResult.none)) {
          emit(const QuizState.loading());
          try {
            List<QuizDetails>? quizzes =
                await quizRepository.getQuizWithDetails();
            if (quizzes == []) {
              emit(const QuizState.empty());
            } else {
              emit(QuizState.success(quizzes: quizzes));
            }
          } catch (e) {
            if (kDebugMode) {
              print(e);
            }
            emit(const QuizState.error(error: 'Une erreur est survenue'));
          }
        } else {
          emit(const QuizState.notConnected());

          emit(const QuizState.loading());
          try {
            List<OfflineQuiz> offlineQuiz = await hiveService.getAllQuiz();
            if (offlineQuiz == []) {
              emit(const QuizState.empty());
            } else {
              /*
              List<QuizDetails> quizDetails = [];
              for (var quiz in offlineQuiz){
                quizDetails.add(QuizDetails.fromJson(quiz.toJson()));
              }
               */
              print(offlineQuiz);
              emit(QuizState.offLineQuiz(quizzes: offlineQuiz));
            }
          } catch (e) {
            emit(const QuizState.error(error: 'Une erreur est survenue'));
          }
          // perform local recuperation -- loading -- empty or offlineQuiz -- error
        }
      },
    );

     */
  }

  Future<void> getOffLineQuizzes() async {
    emit(const QuizState.loading());
    print('start');

    try {
      //hiveService.deleteAllQuiz();
      List<OfflineQuiz> offlineQuiz = await hiveService.getAllQuiz();
      if (offlineQuiz == []) {
        emit(const QuizState.empty());
        print('empty');
      } else {
        /*
        List<QuizDetails> quizDetails = [];
        for (var quiz in offlineQuiz){
          quizDetails.add(QuizDetails.fromJson(quiz.toJson()));
          print(quiz.toJson());
        }

         */
        print(offlineQuiz);
        emit(QuizState.offLineQuiz(quizzes: offlineQuiz));
        print('done');
      }
    } catch (e) {
      emit(const QuizState.error(error: 'Une erreur est survenue'));
      print(e);
    }
  }

  Future<void> storeQuiz(QuizDetails quiz) async {
    //emit(const QuizState.loading());
    try {
      QuizDetails quizzes =
          await quizRepository.getQuizWithDetailsById(quiz.id);
      hiveService.addQuiz(OfflineQuiz.fromJson(quizzes.toJson()));
      //emit(const QuizState.done());
      //getQuizzes();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      emit(const QuizState.error(error: 'Une erreur est survenue'));
    }
  }

  Future<void> finishQuiz(QuizDetails quiz, int score) async {
    print('start');
    final List<ConnectivityResult> connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.none)) {
      try {
        emit(const QuizState.notConnected());
        hiveService.addHistorical(hs.Historical(
            id: 0,
            createdAt: DateTime.now(),
            text: 'Vous avez terminé le quiz ${quiz.name} ${quiz.year}',
            user: 1));
      } catch (e){
        if (kDebugMode) {
          print(e);
        }
        emit(const QuizState.error(error: 'Une erreur est survenue'));
      }
    } else {
      print('load');
      emit(const QuizState.loading());
      try {
        // take user id
        await quizRepository.saveResult(1, quiz.id, 1, score);
        await historicalRepository.insertHistorical(Historical(
            id: 0,
            createdAt: DateTime.now(),
            text: 'Vous avez terminé le quiz ${quiz.name} ${quiz.year}',
            user: 1));
        emit(QuizState.finished(score: score));
        hiveService.addHistorical(hs.Historical(
            id: 0,
            createdAt: DateTime.now(),
            text: 'Vous avez terminé le quiz ${quiz.name} ${quiz.year}',
            user: 1));
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
        emit(const QuizState.error(error: 'Une erreur est survenue'));
      }
    }

    /*
    connectivitySubscription =
        Connectivity().onConnectivityChanged.listen((result) async {
      if (!result.contains(ConnectivityResult.none)) {
        print('load');
        emit(const QuizState.loading());
        try {
          // take user id
          await quizRepository.saveResult(1, quiz.id, 1, score);
          await historicalRepository.insertHistorical(Historical(
              id: 0,
              createdAt: DateTime.now(),
              text: 'Vous avez terminé le quiz ${quiz.name} ${quiz.year}',
              user: 1));
          emit(QuizState.finished(score: score));
          hiveService.addHistorical(hs.Historical(
              id: 0,
              createdAt: DateTime.now(),
              text: 'Vous avez terminé le quiz ${quiz.name} ${quiz.year}',
              user: 1));
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          emit(const QuizState.error(error: 'Une erreur est survenue'));
        }
      } else {
        try {
          emit(const QuizState.notConnected());
          hiveService.addHistorical(hs.Historical(
              id: 0,
              createdAt: DateTime.now(),
              text: 'Vous avez terminé le quiz ${quiz.name} ${quiz.year}',
              user: 1));
        } catch (e){
          if (kDebugMode) {
            print(e);
          }
          emit(const QuizState.error(error: 'Une erreur est survenue'));
        }
      }
    });

     */
  }

}
