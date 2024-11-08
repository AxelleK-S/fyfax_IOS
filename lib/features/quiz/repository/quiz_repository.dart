import 'package:flutter/foundation.dart';
import 'package:fyfax/features/quiz/model/quiz_details.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class QuizRepository {

  getQuiz () async {
    final data = await  Supabase.instance.client.from('quiz').select('*');
    if (kDebugMode) {
      print(data);
    }
  }

  getDomain () async {
    final data = await  Supabase.instance.client.from('domain').select('*');
    if (kDebugMode) {
      print(data);
    }
  }

  getSectionTitle () async {
    final data = await  Supabase.instance.client.from('section_title').select('*');
    if (kDebugMode) {
      print(data);
    }
  }

  getSection () async {
    final data = await  Supabase.instance.client.from('section').select('*');
    if (kDebugMode) {
      print(data);
    }
  }

  getQuestion () async {
    final data = await  Supabase.instance.client.from('question').select('*');
    if (kDebugMode) {
      print(data);
    }
  }

  Future<List<QuizDetails>> getQuizWithDetails () async {
    final data = await  Supabase.instance.client.from('quiz').select(
        '*, domain(*) ,section(*, title(*),question(*))');
    if (kDebugMode) {
      print(data);
    }
    List<QuizDetails> quizDetails = [];
    for (var element in data) {
      quizDetails.add(QuizDetails.fromJson(element));
    }

    return quizDetails;
  }

  Future<QuizDetails> getQuizWithDetailsById(int quizId) async {
    final data = await  Supabase.instance.client.from('quiz').select(
        '*, domain(*) ,section(*, title(*),question(*))').eq('id', quizId);
    if (kDebugMode) {
      print(data);
    }
    return QuizDetails.fromJson(data.first);
  }


}