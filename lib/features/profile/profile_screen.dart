import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fyfax/features/profile/logic/profile_cubit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool disconnect = false;
  bool delete = false;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => ProfileCubit()..init(),
        child: BlocListener<ProfileCubit, ProfileState>(
          listener: (context, state) {
            state.maybeWhen(
              error: (error) {
                Navigator.of(context).pop();
                var snackBar = SnackBar(
                  content: Text(error,
                      style: GoogleFonts.inter(
                          color: Theme.of(context).colorScheme.error)),
                  backgroundColor: Theme.of(context).colorScheme.onError,
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
                                child: (CircularProgressIndicator()),
                              )),
                        ),
                      );
                    },
                  );
                }

                showMyDialog();
              },
              done: () {
                Navigator.of(context).pushNamed('/splash');
              },
              orElse: () {

              },);
          },
          child: BlocBuilder<ProfileCubit, ProfileState>(
            builder: (context, state) {
              return state.maybeWhen(
                loading: () {
                  return Skeletonizer(child: Scaffold(
                    body: SafeArea(
                      child: Column(
                        children: [
                          Container(
                            height: 150,
                            width: 150,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: AssetImage('assets/images/login.jpg'),
                                    fit: BoxFit.fill)),
                          ),
                          const SizedBox(
                            height: 44,
                          ),
                          Text('Mes informations personnelles', style: GoogleFonts.inter(fontSize: 18),),
                          const SizedBox(height: 14,),
                          Padding(
                            padding: const EdgeInsets.only(left: 16, right: 16, top: 7, bottom: 7),
                            child: Row(
                              children: [Text('Nom', style: GoogleFonts.inter(fontSize: 16))],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 16, right: 16, top: 7, bottom: 7),
                            child: Row(
                              children: [Text('Tel', style: GoogleFonts.inter(fontSize: 16))],
                            ),
                          ),
                          const SizedBox(height: 14,),
                          Padding(
                            padding: const EdgeInsets.only(left: 16, right: 16, top: 7, bottom: 7),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                    'Modifier',
                                    style: GoogleFonts.inter(color: Theme.of(context).colorScheme.primary)
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                Icon(
                                  Iconsax.edit_2,
                                  color: Theme.of(context).colorScheme.primary,
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 16, right: 16, top: 7, bottom: 7),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'Deconnexion',
                                  style: GoogleFonts.inter(color: Theme.of(context).colorScheme.error),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ));
                },
                success: (email, phoneNumber, name) {
                  return Scaffold(
                    body: SafeArea(
                      child: Column(
                        children: [
                          Container(
                            height: 150,
                            width: 150,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: AssetImage('assets/images/login.jpg'),
                                    fit: BoxFit.fill)),
                          ),
                          const SizedBox(
                            height: 44,
                          ),
                          Text('Mes informations personnelles', style: GoogleFonts.inter(fontSize: 18),),
                          const SizedBox(height: 14,),
                          Padding(
                            padding: const EdgeInsets.only(left: 16, right: 16, top: 7, bottom: 7),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text('Nom', style: GoogleFonts.inter(fontSize: 16)),
                                const SizedBox(width: 24,),
                                Text(name, style: GoogleFonts.inter(fontSize: 16)),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 16, right: 16, top: 7, bottom: 7),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text('Email', style: GoogleFonts.inter(fontSize: 16)),
                                const SizedBox(width: 24,),
                                Text(email, style: GoogleFonts.inter(fontSize: 16)),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 16, right: 16, top: 7, bottom: 7),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text('Tel', style: GoogleFonts.inter(fontSize: 16)),
                                const SizedBox(width: 24,),
                                Text(phoneNumber, style: GoogleFonts.inter(fontSize: 16)),
                              ],
                            ),
                          ),
                          const SizedBox(height: 14,),
                          /*
                        Padding(
                          padding: const EdgeInsets.only(left: 16, right: 16, top: 7, bottom: 7),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                  'Modifier',
                                  style: GoogleFonts.inter(color: Theme.of(context).colorScheme.primary)
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              Icon(
                                Iconsax.edit_2,
                                color: Theme.of(context).colorScheme.primary,
                              )
                            ],
                          ),
                        ),*/

                          Padding(
                            padding: const EdgeInsets.only(left: 16, right: 16, top: 7, bottom: 7),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  child: Text(
                                    'Deconnexion',
                                    style: GoogleFonts.inter(color: Theme.of(context).colorScheme.error),
                                  ),
                                  onTap: () {
                                    //final LocalStorageService localStorageService = LocalStorageService();
                                    Future<void> showMyDialog() async {
                                      return showDialog<void>(
                                        context: context,
                                        barrierDismissible: false, // user must tap button!
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: const Text('Se déconnecter'),
                                            content: const SingleChildScrollView(
                                              child: Center(
                                                  child: SizedBox(
                                                    height: 50,
                                                    child: Text(
                                                        'Etes-vous sur de vouloir vous déconnecter ?'),
                                                  )),
                                            ),
                                            actions: [
                                              TextButton(
                                                child: Text('Oui',style: GoogleFonts.inter(color: Theme.of(context).colorScheme.error),),
                                                onPressed: () async {
                                                  setState(() {
                                                    disconnect = true;
                                                  });
                                                  //Navigator.of(context).pop();
                                                },
                                              ),
                                              // final UserRepository userRepository = UserRepository();
                                              // await userRepository.logout() ;
                                              TextButton(
                                                child: Text('Non', style: GoogleFonts.inter(),),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    }

                                    showMyDialog();

                                    if (disconnect == true) {
                                      context.read<ProfileCubit>().logout();
                                    }
                                  },
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 16, right: 16, top: 7, bottom: 7),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  child: Text(
                                    'Supprimer le compte',
                                    style: GoogleFonts.inter(color: Theme.of(context).colorScheme.error),
                                  ),
                                  onTap: () {
                                    //final LocalStorageService localStorageService = LocalStorageService();
                                    Future<void> showMyDialog() async {
                                      return showDialog<void>(
                                        context: context,
                                        barrierDismissible: false, // user must tap button!
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: const Text('Supprimer le compte'),
                                            content: const SingleChildScrollView(
                                              child: Center(
                                                  child: SizedBox(
                                                    height: 50,
                                                    child: Text(
                                                        'Etes-vous sur de vouloir supprimer votre compte ?'),
                                                  )),
                                            ),
                                            actions: [
                                              TextButton(
                                                child: Text('Oui',style: GoogleFonts.inter(color: Theme.of(context).colorScheme.error),),
                                                onPressed: () async {
                                                  setState(() {
                                                    delete = true;
                                                  });
                                                  //Navigator.of(context).pop();
                                                  //Perform suppression of account
                                                },
                                              ),
                                              // final UserRepository userRepository = UserRepository();
                                              // await userRepository.logout() ;
                                              TextButton(
                                                child: Text('Non', style: GoogleFonts.inter(),),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    }

                                    showMyDialog();

                                    if (delete == true){
                                      context.read<ProfileCubit>().deleteUser(email);
                                    }
                                  },
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                orElse: () {
                  return Skeletonizer(child: Scaffold(
                    body: SafeArea(
                      child: Column(
                        children: [
                          Container(
                            height: 150,
                            width: 150,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: AssetImage('assets/images/login.jpg'),
                                    fit: BoxFit.fill)),
                          ),
                          const SizedBox(
                            height: 44,
                          ),
                          Text('Mes informations personnelles', style: GoogleFonts.inter(fontSize: 18),),
                          const SizedBox(height: 14,),
                          Padding(
                            padding: const EdgeInsets.only(left: 16, right: 16, top: 7, bottom: 7),
                            child: Row(
                              children: [Text('Nom', style: GoogleFonts.inter(fontSize: 16))],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 16, right: 16, top: 7, bottom: 7),
                            child: Row(
                              children: [Text('Tel', style: GoogleFonts.inter(fontSize: 16))],
                            ),
                          ),
                          const SizedBox(height: 14,),
                          Padding(
                            padding: const EdgeInsets.only(left: 16, right: 16, top: 7, bottom: 7),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                    'Modifier',
                                    style: GoogleFonts.inter(color: Theme.of(context).colorScheme.primary)
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                Icon(
                                  Iconsax.edit_2,
                                  color: Theme.of(context).colorScheme.primary,
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 16, right: 16, top: 7, bottom: 7),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'Deconnexion',
                                  style: GoogleFonts.inter(color: Theme.of(context).colorScheme.error),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ));
                },);
            },
          ),
        ),
    );
  }
}

