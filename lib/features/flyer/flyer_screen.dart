import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

class FlyerScreen extends StatelessWidget {
  const FlyerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> images = ['assets/images/flyer.jpg', 'assets/images/flyer1.jpeg', 'assets/images/flyer2.jpeg'];
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
                      style: GoogleFonts.inter(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          )),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            images.length,
            (index) {
              return Container(
                height: 300,
                margin: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: 7,
                  bottom: 7,
                ),
                decoration: BoxDecoration(
                  //color: Colors.green,
                    image: DecorationImage(
                        image: AssetImage(images[index],),)),
                //child: Image.asset('assets/images/flyer.jpg', fit: BoxFit.fill, ),
              );
            },
          ),
        ),
      ),
    );
  }
}
