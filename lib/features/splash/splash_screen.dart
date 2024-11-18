import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fyfax/features/splash/logic/splash_cubit.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SplashCubit()..init(),
      child: const SplashArea(),
    );
  }
}

class SplashArea extends StatelessWidget {
  const SplashArea({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashCubit, SplashState>(
      listener: (context, state) {
        state.maybeWhen(
          initialized: (isLoggedIn) {
            if (kDebugMode) {
              print(isLoggedIn);
            }
            if (isLoggedIn) {
              Navigator.pushNamed(context, '/home');
            } else {
              Navigator.pushNamed(context, '/');
            }
          },
          orElse: () {},
        );
      },
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 150,
              width: 150,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: AssetImage('assets/images/splash.png'))
              ),
            ),
            const SizedBox(height: 24,),
            Text('FyFax', style: GoogleFonts.handlee()),
          ],
        ),
      ),
    );
  }
}

