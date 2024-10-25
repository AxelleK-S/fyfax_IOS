part of 'quiz_cubit.dart';

@freezed
class QuizState with _$QuizState {
  const factory QuizState.initial() = _Initial;
  const factory QuizState.loading() = _Loading;
  const factory QuizState.success({required List<QuizDetails> quizzes}) = _Success;
  const factory QuizState.error({required String error}) = _Error;
  const factory QuizState.notConnected() = _NotConnected;
  const factory QuizState.offLineQuiz({required List<QuizDetails> quizzes}) = _OffLineQuiz;
  const factory QuizState.empty() = _Empty;
  const factory QuizState.done() = _Done;
}
