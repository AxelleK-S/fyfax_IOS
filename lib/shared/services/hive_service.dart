import 'package:fyfax/shared/hive/model/offline_quiz.dart';
import 'package:hive/hive.dart';

class HiveService {
  final String  _boxName = "offlineQuizBox";

  Future<Box<OfflineQuiz>> get _box async =>
      await Hive.openBox<OfflineQuiz>(_boxName);

  //create
  Future<void> addQuiz(OfflineQuiz offlineQuiz) async {
    var box = await _box;
    await box.add(offlineQuiz);
  }

  //read
  Future<List<OfflineQuiz>> getAllQuiz() async {
    var box = await _box;
    return box.values.toList();
  }

  //update
  Future<void> updateDeck(int index, OfflineQuiz offlineQuiz) async {
    var box = await _box;
    await box.putAt(index, offlineQuiz);
  }

  //delete
  Future<void> deleteQuiz(int index) async {
    var box = await _box;
    await box.deleteAt(index);
  }

  //delete all
  Future<void> deleteAllQuiz() async {
    var box = await _box;
    await box.deleteFromDisk();
  }

}