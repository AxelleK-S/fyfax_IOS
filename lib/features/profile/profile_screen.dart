import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
              height: 24,
            ),
            Text('Mes informations personnelles', style: GoogleFonts.handlee(),),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 7, bottom: 7),
              child: Row(
                children: [Text('Nom', style: GoogleFonts.handlee())],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 7, bottom: 7),
              child: Row(
                children: [Text('Tel', style: GoogleFonts.handlee())],
              ),
            ),
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
    );
  }
}
