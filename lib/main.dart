import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fyfax/core/app_initializer.dart';
import 'package:fyfax/core/application.dart';

void main() {
  final AppInitializer appInitializer = AppInitializer();

  runZonedGuarded(
        () async {
      WidgetsFlutterBinding.ensureInitialized();

      await appInitializer.preAppRun();

      runApp(const Application());

      appInitializer.postAppRun();
    },
        (error, stack) {},
  );
}
