import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fyfax/features/profile/logic/profile_cubit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProfileCubit()..init(),
      child: const ProfileArea(),
    );
  }
}

class ProfileArea extends StatelessWidget {
  const ProfileArea({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileCubit, ProfileState>(
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
                        Text('Mes informations personnelles', style: GoogleFonts.handlee(fontSize: 18),),
                        const SizedBox(height: 14,),
                        Padding(
                          padding: const EdgeInsets.only(left: 16, right: 16, top: 7, bottom: 7),
                          child: Row(
                            children: [Text('Nom', style: GoogleFonts.handlee(fontSize: 16))],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16, right: 16, top: 7, bottom: 7),
                          child: Row(
                            children: [Text('Tel', style: GoogleFonts.handlee(fontSize: 16))],
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
                                  style: GoogleFonts.handlee(color: Theme.of(context).colorScheme.primary)
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
                                style: GoogleFonts.handlee(color: Theme.of(context).colorScheme.error),
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
                        Text('Mes informations personnelles', style: GoogleFonts.handlee(fontSize: 18),),
                        const SizedBox(height: 14,),
                        Padding(
                          padding: const EdgeInsets.only(left: 16, right: 16, top: 7, bottom: 7),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text('Nom', style: GoogleFonts.handlee(fontSize: 16)),
                              const SizedBox(width: 24,),
                              Text(name, style: GoogleFonts.handlee(fontSize: 16)),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16, right: 16, top: 7, bottom: 7),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text('Email', style: GoogleFonts.handlee(fontSize: 16)),
                              const SizedBox(width: 24,),
                              Text(email, style: GoogleFonts.handlee(fontSize: 16)),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16, right: 16, top: 7, bottom: 7),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text('Tel', style: GoogleFonts.handlee(fontSize: 16)),
                              const SizedBox(width: 24,),
                              Text(phoneNumber, style: GoogleFonts.handlee(fontSize: 16)),
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
                                  style: GoogleFonts.handlee(color: Theme.of(context).colorScheme.primary)
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
                        /*
                        Padding(
                          padding: const EdgeInsets.only(left: 16, right: 16, top: 7, bottom: 7),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Deconnexion',
                                style: GoogleFonts.handlee(color: Theme.of(context).colorScheme.error),
                              )
                            ],
                          ),
                        ),

                         */
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
                        Text('Mes informations personnelles', style: GoogleFonts.handlee(fontSize: 18),),
                        const SizedBox(height: 14,),
                        Padding(
                          padding: const EdgeInsets.only(left: 16, right: 16, top: 7, bottom: 7),
                          child: Row(
                            children: [Text('Nom', style: GoogleFonts.handlee(fontSize: 16))],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16, right: 16, top: 7, bottom: 7),
                          child: Row(
                            children: [Text('Tel', style: GoogleFonts.handlee(fontSize: 16))],
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
                                  style: GoogleFonts.handlee(color: Theme.of(context).colorScheme.primary)
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
                                style: GoogleFonts.handlee(color: Theme.of(context).colorScheme.error),
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
);
  }
}
