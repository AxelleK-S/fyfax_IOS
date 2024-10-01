import 'package:flutter/material.dart';

class ValidatedButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  const ValidatedButton({super.key, required this.onTap, required this.text});

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
          left: 50,
          right: 50
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Theme.of(context).colorScheme.primary),
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