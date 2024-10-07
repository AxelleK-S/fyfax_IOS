import 'package:flutter/material.dart';
import 'package:fyfax/shared/widgets/historical_card.dart';
import 'package:google_fonts/google_fonts.dart';

class HistoricalScreen extends StatelessWidget {
  const HistoricalScreen({super.key});

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
                children: [
                  Text('Historique', style: GoogleFonts.handlee(),),
                ],
              ),
            ),
          )),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 16,
              top: 24,
              bottom: 24
            ),
            child: Text('Hier', style: GoogleFonts.handlee(),),
          ),
          const HistoricalCard(text: 'Inscription réussi , Bienvenue sur Mederine',),
          const HistoricalCard(text: 'Inscription réussi , Bienvenue sur Mederine',),
          const HistoricalCard(text: 'Inscription réussi , Bienvenue sur Mederine',),
        ],
      ),
    );
  }
}
