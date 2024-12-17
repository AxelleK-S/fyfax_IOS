import 'package:flutter/material.dart';
import 'package:fyfax/features/login/login_screen.dart';
import 'package:fyfax/features/quiz/repository/quiz_repository.dart';

import 'package:fyfax/shared/widgets/validated_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

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
              'Pour accéder aux épreuves, Contactez l’administrateur pour recevoir votre code d’accès ',
              textAlign: TextAlign.center,
              style: GoogleFonts.handlee(fontSize: 16),
            )),
          ),
          ValidatedButton(
              onTap: () async {
                //const url = "https://wa.me/237691983314?text=Your Message here";
                const url = "237655487767?text=Bonjour je viens de fyfax j'aimerai obtenir mon code d'accès";
                var encoded = Uri(scheme: 'https', host: 'wa.me',path: url);
                launchUrl(encoded);
                },
                //quizRepository.getQuizWithDetails();
                text: 'Whatsapp'),
          const SizedBox(
            height: 50,
          ),
          ValidatedButton(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                ));
              },
              text: 'Fait')
        ],
      ),
    );
  }
}
