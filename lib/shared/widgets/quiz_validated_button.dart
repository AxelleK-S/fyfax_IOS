import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class QuizValidatedButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  const QuizValidatedButton({super.key, required this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 54,
        //width: 275,
        margin : const EdgeInsets.only(
            top: 24,
            bottom: 24,
            left: 16,
            right: 16
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: const Color(0xFF1E672E)),
        child: Center(
            child: Text(
              text,
              style: GoogleFonts.handlee(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontSize: 24),
            )
        ),
      ),
    );
  }
}
