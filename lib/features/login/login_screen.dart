import 'package:flutter/material.dart';
import 'package:fyfax/features/home/home_screen.dart';
import 'package:fyfax/shared/widgets/login_field.dart';
import 'package:fyfax/shared/widgets/validated_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 150,
                width: 150,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(image: AssetImage('assets/images/login.jpg'), fit: BoxFit.fill)
                ),
              ),
              const SizedBox(height: 24,),
              LoginField(title: 'Votre username', controller: TextEditingController(), onChanged: (p0) {

              }, validator: (p0) {
                return '' ;
              }, isObscure: false, inputType: TextInputType.name),
              LoginField(title: 'Entrez le code  reçu' , controller: TextEditingController(), onChanged: (p0) {

              }, validator: (p0) {
                return '';
              }, isObscure: false, inputType: TextInputType.number),
              ValidatedButton(onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => const HomeScreen(),));
              }, text: 'Connexion')
            ],
          ),
        ),
      ),
    );
  }
}
