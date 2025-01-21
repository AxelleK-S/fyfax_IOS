import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DomainTab extends StatefulWidget {
  const DomainTab({super.key});

  @override
  State<DomainTab> createState() => _DomainTabState();
}

class _DomainTabState extends State<DomainTab> {
  List<String> titles = ['Médecine Générale', 'Odontologie', 'Pharmacie'];
  List<bool> selected = [];

  @override
  void initState() {
    selected = [true, false, false];
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      padding: const EdgeInsets.only(
        left: 6,
        right: 6,
        top: 4,
        bottom: 4
      ),
      margin: const EdgeInsets.only(
          left: 16,
          right: 16,
          top: 14,
          bottom: 14
      ),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(10)
      ),
      child: Row(
        children: List.generate(3, (index) => GestureDetector(
          onTap: () {
            setState(() {
              selected = [false, false, false];
              selected[index] = true;
            });
          },
          child: Container(
            margin: const EdgeInsets.only(
                left: 4,
                right: 4,
            ),
            padding: const EdgeInsets.only(
              left: 4,
              right: 4,
            ),
            decoration: BoxDecoration(
                color: selected[index]? Theme.of(context).colorScheme.primary : Colors.grey.shade100,
                borderRadius: BorderRadius.circular(10)
            ),
            child: Center(child: Text(titles[index], style: GoogleFonts.inter(color: selected[index]? Theme.of(context).colorScheme.onPrimary : Colors.black),)),
          ),
        ),),
      ),
    );
  }
}
