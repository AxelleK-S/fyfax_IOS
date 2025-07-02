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
        //height: 72,
        constraints: const BoxConstraints(
          minHeight: 72, // Maximum height
        ),
        padding: const EdgeInsets.all(6),
        margin: const EdgeInsets.only(left: 16, right: 16, top: 7, bottom: 7),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: color,
            border: Border.all(
                color: clicked
                    ? Colors.transparent
                    : Theme.of(context).colorScheme.onSurface)),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 6, right: 6),
            child: Text(
              statement,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.inter(),
              maxLines: 4,
            ),
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
      var decode = latin1.decode(text.codeUnits);
      print(decode);
      return decodedText;
    } catch (e) {
      // Si une exception se produit, retourner le texte original
      return text;
    }
  }
}
