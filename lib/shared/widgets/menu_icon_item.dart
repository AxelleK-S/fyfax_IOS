import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MenuIconItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;
  final bool active;
  const MenuIconItem(
      {super.key,
      required this.icon,
      required this.onTap,
      required this.active, required this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 30,
            width: 75,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: active ? Colors.white.withOpacity(0.4): Colors.transparent),
            child: Center(
              child: Icon(
                icon,
                color: active ? Colors.black : Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 4,),
          Text(text, style: GoogleFonts.inter(color: active ? Colors.black : Colors.white, fontSize: 8),),
        ],
      ),
    );
  }
}
