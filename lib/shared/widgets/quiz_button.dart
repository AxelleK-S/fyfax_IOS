import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class QuizButton extends StatelessWidget {
  final bool clicked;
  final String statement;
  final VoidCallback onTap;
  final Color color;
  const QuizButton(
      {super.key,
      required this.clicked,
      required this.statement,
      required this.onTap,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 61,
        margin: const EdgeInsets.only(left: 16, right: 16, top: 7, bottom: 7),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: color,
            border: Border.all(
                color: clicked
                    ? Colors.transparent
                    : Theme.of(context).colorScheme.onSurface)),
        child: Center(
          child: Text(
            _decodeIfNeeded(statement),
            style: GoogleFonts.handlee(),
            maxLines: 2,
          ),
        ),
      ),
    );
  }

  String _decodeIfNeeded(String text) {
    // Vérifiez si le texte est en UTF-8
    try {
      // Tentative de décodage
      var decodedText = utf8.decode(text.codeUnits, allowMalformed: false);
      return decodedText;
    } catch (e) {
      // Si une exception se produit, retourner le texte original
      return text;
    }
  }
}
