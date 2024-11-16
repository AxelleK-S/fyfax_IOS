import 'package:flutter/foundation.dart';
import 'package:fyfax/features/historical/model/historical.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HistoricalRepository {
  Future<List<Historical>> getHistorical (int userId) async {
    final data = await  Supabase.instance.client.from('notifications').select('*').eq('user', userId);
    if (kDebugMode) {
      print(data);
    }
    List<Historical> historical = [];
    for (var element in data) {
      historical.add(Historical.fromJson(element));
    }
    return historical;
  }

  Future<void> insertHistorical (Historical hist) async {
    final data = await  Supabase.instance.client.from('notifications').insert(
      {
        "user" : hist.user,
        "text" : hist.text,
      }
    );
    if (kDebugMode) {
      print(data);
    }
  }
}