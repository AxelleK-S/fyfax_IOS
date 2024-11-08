import 'package:flutter/material.dart';
import 'package:fyfax/shared/widgets/separator.dart';
import 'package:google_fonts/google_fonts.dart';

class HistoricalCard extends StatelessWidget {
  final String text;
  final String time;
  const HistoricalCard({super.key, required this.text, required this.time});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 16, right: 16, top: 7, bottom: 7),
      padding: const EdgeInsets.only(left: 7, right: 7, top: 5, bottom: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text,
            maxLines: 3,
            textAlign: TextAlign.left,
            style: GoogleFonts.handlee(),
          ),
          const SizedBox(height: 10,),
          Text(
            time,
            maxLines: 3,
            textAlign: TextAlign.left,
            style: GoogleFonts.handlee(fontSize: 12, color: Theme.of(context).colorScheme.onSurface.withOpacity(0.4),),
          ),
          const SizedBox(height: 20,),
          MySeparator(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.4),)
        ],
      ),
    );
  }
}
