import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

class FlyerScreen extends StatelessWidget {
  const FlyerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(80),
          child: Container(
            decoration:
                BoxDecoration(color: Theme.of(context).colorScheme.primary),
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(Iconsax.arrow_left)),
                  Center(
                    child: Text(
                      'Flyers',
                      style: GoogleFonts.handlee(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          )),
      body: SingleChildScrollView(
        child: Column(
          children: List.generate(
            1,
            (index) {
              return Container(
                height: 300,
                margin: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: 7,
                  bottom: 7,
                ),
                decoration: const BoxDecoration(
                  //color: Colors.green,
                    image: DecorationImage(
                        image: AssetImage('assets/images/flyer.jpg',),)),
                //child: Image.asset('assets/images/flyer.jpg', fit: BoxFit.fill, ),
              );
            },
          ),
        ),
      ),
    );
  }
}
