import 'package:flutter/material.dart';
import 'package:fyfax/features/login/login_screen.dart';
import 'package:fyfax/features/login/register_screen.dart';
import 'package:fyfax/features/quiz/repository/quiz_repository.dart';

import 'package:fyfax/shared/widgets/validated_button.dart';
import 'package:google_fonts/google_fonts.dart';

class SecondScreen extends StatelessWidget {
  final QuizRepository quizRepository = QuizRepository();
  SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Center(
                child: Text(
              'Veuillez choisir une option',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(fontSize: 16),
            )),
          ),
          ValidatedButton(
              onTap: () async {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const RegisterScreen(),
                ));
                },
                text: 'S\'inscrire'),
          const SizedBox(
            height: 50,
          ),
          ValidatedButton(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                ));
              },
              text: 'Se Connecter')
        ],
      ),
    );
  }
}
