
import 'package:flutter/material.dart';

class MenuIconItem extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final bool active;
  const MenuIconItem({super.key, required this.icon, required this.onTap, required this.active});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 30,
        width: 75,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: active ? const Color(0xFF1E672E) : Colors.transparent
        ),
        child: Center(child: Icon(icon, color: active ? Colors.white : Colors.black,),),
      ),
    );
  }
}
