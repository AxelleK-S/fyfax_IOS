import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fyfax/features/home/home_screen.dart';
import 'package:fyfax/features/login/logic/login_cubit.dart';
import 'package:fyfax/shared/widgets/login_field.dart';
import 'package:fyfax/shared/widgets/validated_button.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginCubit(),
      child: const LoginArea(),
    );
  }
} 

class LoginArea extends StatelessWidget {
  const LoginArea({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    return BlocListener<LoginCubit, LoginState>(
        listener: (context, state) {
          state.maybeWhen(
            error: (error) {
              var snackBar = SnackBar(
                content: Text(error,
                    style: GoogleFonts.handlee(
                        color: Theme.of(context).colorScheme.onError)),
                backgroundColor: Theme.of(context).colorScheme.error,
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
            loading: () {
              Future<void> showMyDialog() async {
                return showDialog<void>(
                  context: context,
                  barrierDismissible: false, // user must tap button!
                  builder: (BuildContext context) {
                    return const AlertDialog(
                      title: Text('Loading'),
                      content: SingleChildScrollView(
                        child: Center(
                            child: SizedBox(
                              height: 50,
                              width: 50,
                              child: (
                                  CircularProgressIndicator()
                              ),
                            )
                        ),
                      ),
                    );
                  },
                );
              }
              showMyDialog();
            },
            success: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const HomeScreen(),)),
            orElse: () {

          },);
        },
        child: Scaffold(
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
                    LoginField(title: 'Votre adresse email', controller: emailController, onChanged: (p0) {

                    }, validator: (p0) {
                      return '' ;
                    }, isObscure: false, inputType: TextInputType.name),
                    LoginField(title: 'Entrez le code  reçu' , controller: passwordController, onChanged: (p0) {

                    }, validator: (p0) {
                      return '';
                    }, isObscure: false, inputType: TextInputType.text),
                    ValidatedButton(onTap: () {
                      context.read<LoginCubit>().login(emailController.text, passwordController.text);
                      //Navigator.of(context).push(MaterialPageRoute(builder: (context) => const HomeScreen(),));
                    }, text: 'Connexion')
                  ],
                ),
              ),
            ),
          ),
);
  }
}

