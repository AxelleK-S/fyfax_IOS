import 'package:flutter/material.dart';
import 'package:fyfax/features/login/login_screen.dart';

import 'package:fyfax/shared/widgets/validated_button.dart';

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 16,
              right: 16
            ),
            child: Text('Pour accéder aux épreuves, Contactez l’administrateur pour recevoir votre code d’accès '),
          ),
          ValidatedButton(onTap:  () {

          }, text: 'Whatsapp'),

          SizedBox(height: 50,),

          ValidatedButton(onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => const LoginScreen(),));
          }, text: 'Fait')
        ],
      ),
    );
  }
}
