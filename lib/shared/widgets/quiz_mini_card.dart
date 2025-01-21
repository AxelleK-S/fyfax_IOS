import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

class QuizMiniCard extends StatelessWidget {
  final String title;
  final int numberQuestions;
  final String category;
  const QuizMiniCard(
      {super.key,
      required this.title,
      required this.numberQuestions,
      required this.category});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 108,
      width: 143,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(left: 7, right: 7),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: category == "Odontostomatologie"
              ? Colors.greenAccent
              : category == "Médecine"
                  ? Colors.lightBlueAccent
                  : Colors.deepPurpleAccent),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(title, textAlign: TextAlign.left, style: GoogleFonts.inter()),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('${numberQuestions.toString()} Qst',
                  textAlign: TextAlign.right, style: GoogleFonts.inter()),
              const Icon(Iconsax.document_download)
            ],
          )
        ],
      ),
    );
  }
}
