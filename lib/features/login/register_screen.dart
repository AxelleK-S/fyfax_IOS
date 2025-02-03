import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../shared/widgets/login_field.dart';
import '../../shared/widgets/validated_button.dart';
import '../home/home_screen.dart';
import 'logic/login_cubit.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginCubit(),
      child: const RegisterPage(),
    );
  }
}

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController usernameController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        print(state);
        state.maybeWhen(
          error: (message) {
            Navigator.of(context).pop();
            var snackBar = SnackBar(
              content: Text(message,
                  style: GoogleFonts.handlee(
                      color: Theme.of(context).colorScheme.error)),
              backgroundColor: Theme.of(context).colorScheme.onError,
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          },
          notConnected: () {
            Navigator.of(context).pop();
            var snackBar = SnackBar(
              content: Text('Vous n\'êtes pas connecté à Internet',
                  style: GoogleFonts.handlee(
                      color: Theme.of(context).colorScheme.primary)),
              backgroundColor: Theme.of(context).colorScheme.onPrimary,
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          },
          success: (user) => Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          )),
          exist: () {
            Future<void> showMyDialog() async {
              return showDialog<void>(
                context: context,
                barrierDismissible: false, // user must tap button!
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Utilisateur existant'),
                    content: SingleChildScrollView(
                      child: ListBody(
                        children: <Widget>[
                          Text(
                            'L\'utilisateur existe déjà',
                            style: GoogleFonts.handlee(
                                color: Theme.of(context).colorScheme.error),
                          ),
                        ],
                      ),
                    ),
                    actions: <Widget>[
                      TextButton(
                        child: const Text('Okay'),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const RegisterScreen(),
                          ));
                        },
                      ),
                    ],
                  );
                },
              );
            }

            showMyDialog();
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
                        child: (CircularProgressIndicator()),
                      )),
                    ),
                  );
                },
              );
            }

            showMyDialog();
          },
          orElse: () {},
        );
      },
      child: BlocBuilder<LoginCubit, LoginState>(
        builder: (context, state) {
          return Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: 150,
                    width: 150,
                    margin: const EdgeInsets.only(top: 24, bottom: 24),
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: AssetImage('assets/images/logo.png'),
                            fit: BoxFit.fill)),
                  ),
                  Text(
                    'Entrer les informations du user pour l\'inscrire',
                    style: GoogleFonts.handlee(),
                  ),
                  const SizedBox(
                    height: 44,
                  ),
                  //Form(child: ),
                  LoginField(
                      title: 'Username',
                      controller: usernameController,
                      onChanged: (p0) {},
                      validator: (p0) {
                        if (p0 == '') {
                          return 'Entrez un username';
                        } else {
                          return '';
                        }
                      },
                      isObscure: false,
                      inputType: TextInputType.text),
                  LoginField(
                      title: 'Email',
                      controller: emailController,
                      onChanged: (p0) {},
                      validator: (p0) {
                        if (p0 == '') {
                          return 'Entrez une adresse mail';
                        } else {
                          return '';
                        }
                      },
                      isObscure: false,
                      inputType: TextInputType.emailAddress),
                  LoginField(
                      title: 'Téléphone',
                      controller: phoneController,
                      onChanged: (p0) {},
                      validator: (p0) {
                        if (p0 == '') {
                          return 'Entrez un numéro';
                        } else if (!RegExp(r'^[0-9]+$').hasMatch(p0!)) {
                          return 'Le numéro de téléphone doit contenir uniquement des chiffres.';
                        } else {
                          return '';
                        }
                      },
                      isObscure: false,
                      inputType: TextInputType.phone),
                  LoginField(
                      title: 'Mot de passe',
                      controller: passwordController,
                      onChanged: (p0) {},
                      validator: (p0) {
                        if (p0 == '') {
                          return 'Entrez une mot de passe';
                        } else {
                          return '';
                        }
                      },
                      isObscure: false,
                      inputType: TextInputType.text),
                  const SizedBox(
                    height: 24,
                  ),
                  ValidatedButton(
                      onTap: () {
                        if (emailController.text == '' ||
                            phoneController.text == '') {
                          var snackBar = SnackBar(
                            content: Text('Veuillez remplir les champs',
                                style: GoogleFonts.handlee(
                                    color:
                                        Theme.of(context).colorScheme.primary)),
                            backgroundColor:
                                Theme.of(context).colorScheme.onPrimary,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        } else {
                          context.read<LoginCubit>().createUser(
                              emailController.text,
                              phoneController.text.toString(),
                              passwordController.text,
                              usernameController.text,
                          );
                        }
                      },
                      text: 'Enregister')
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
