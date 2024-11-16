import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/material.dart';
import 'package:fyfax/core/i18n/l10n.dart';
import 'package:fyfax/core/theme/app_theme.dart';
import 'package:fyfax/features/home/home_screen.dart';
import 'package:fyfax/features/first/first_screen.dart';
import 'package:fyfax/features/splash/splash_screen.dart';



class Application extends StatelessWidget {
  const Application({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FyFax',
      initialRoute: '/splash',
      routes: {
        '/splash': (ctx) => const SplashScreen(),
        '/': (ctx) => const FirstScreen(),
        '/home': (ctx) => const HomeScreen(),
      },
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        I18n.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: I18n.delegate.supportedLocales,
    );
  }
}
