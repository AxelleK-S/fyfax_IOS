import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fyfax/shared/hive/model/domain.dart';
import 'package:fyfax/shared/hive/model/offline_quiz.dart';
import 'package:fyfax/shared/hive/model/question.dart';
import 'package:fyfax/shared/hive/model/section.dart';
import 'package:fyfax/shared/hive/model/section_title.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


const supabaseUrl = "https://xtcqhaotzsxfzfygefrt.supabase.co";
const anonkey = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inh0Y3FoYW90enN4ZnpmeWdlZnJ0Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3Mjg5ODAzMTcsImV4cCI6MjA0NDU1NjMxN30.j0Sh6GTJ9i9iagshLdE8lYk4-gkN-EoLo0pZfx8-EaY";

class AppInitializer {
  /// Initialize services, plugins, etc. before the app runs.
  Future<void> preAppRun() async {
    await Supabase.initialize(
      url: supabaseUrl,
      anonKey: anonkey,
    );
    await Hive.initFlutter();
    Hive.registerAdapter(OfflineQuizAdapter());
    Hive.registerAdapter(DomainAdapter());
    Hive.registerAdapter(QuestionAdapter());
    Hive.registerAdapter(SectionAdapter());
    Hive.registerAdapter(SectionTitleAdapter());
  }

  /// Initialize services, plugins, etc. after the app runs.
  Future<void> postAppRun() async {
    // Hide RSOD in release mode.
    if (kReleaseMode) {
      ErrorWidget.builder = (FlutterErrorDetails details) => const SizedBox();
    }
  }
}