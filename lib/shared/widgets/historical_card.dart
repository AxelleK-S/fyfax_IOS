import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HistoricalCard extends StatelessWidget {
  final String text;
  const HistoricalCard({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 16, right: 16, top: 7, bottom: 7),
      padding: const EdgeInsets.only(left: 7, right: 7, top: 5, bottom: 5),
      child: Text(
        text,
        maxLines: 3,
        textAlign: TextAlign.left,
        style: GoogleFonts.handlee(),
      ),
    );
  }
}
