import 'package:flutter/material.dart';

class ValidatedQuizButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  const ValidatedQuizButton({super.key, required this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 54,
        margin : const EdgeInsets.only(
            left: 16,
            right: 16
        ),
        decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xFF1E672E)
        ),
        child: Center(
            child: Text(
              text,
              style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontSize: 24
              ),
            )
        ),
      ),
    );
  }
}