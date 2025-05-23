import 'package:fyfax/shared/hive/model/historical.dart';
import 'package:fyfax/shared/hive/model/offline_quiz.dart';
import 'package:hive/hive.dart';

class HiveService {
  final String  _boxName = "offlineQuizBox";
  final String  _boxName2 = "historicalBox";

  Future<Box<OfflineQuiz>> get _box async =>
      await Hive.openBox<OfflineQuiz>(_boxName);

  Future<Box<Historical>> get _box2 async =>
      await Hive.openBox<Historical>(_boxName2);

  //create
  Future<void> addHistorical(Historical historical) async {
    var box = await _box2;
    await box.add(historical);
  }

  //read
  Future<List<Historical>> getAllHistorical() async {
    var box = await _box2;
    return box.values.toList();
  }


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
    try {
      var box = await _box;
      var map = box.toMap();
      var key = findKeyById(map, index);
      await box.deleteAt(key);
    } catch (e) {
      print(e);
    }
  }

  dynamic findKeyById(Map<dynamic, OfflineQuiz> map, int id) {
    for (var entry in map.entries) {
      if (entry.value.id == id) {
        return entry.key; // Return the key if the id matches
      }
    }
    return null; // Return null if no match is found
  }

  //delete all
  Future<void> deleteAllQuiz() async {
    var box = await _box;
    await box.deleteFromDisk();
  }

}