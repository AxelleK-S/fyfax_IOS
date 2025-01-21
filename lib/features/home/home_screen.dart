import 'package:flutter/material.dart';
import 'package:fyfax/features/historical/historical_screen.dart';
import 'package:fyfax/features/profile/profile_screen.dart';
import 'package:fyfax/features/quiz/large_quiz_screen.dart';
import 'package:fyfax/features/quiz/mini_quiz_screen.dart';
import 'package:fyfax/shared/widgets/menu_icon_item.dart';
import 'package:iconsax/iconsax.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Widget> pages = [
    const MiniQuizScreen(),
    const LargeQuizScreen(),
    const HistoricalScreen(),
    const ProfileScreen(),
  ];
  List<IconData> icons = [
    Iconsax.home,
    Iconsax.book_square,
    Iconsax.clock,
    Iconsax.user
  ];
  List<String> texts = [
    'Accueil',
    'Mes Epreuves',
    'Historique',
    'Mon Compte'
  ];
  int activeIndex = 0;
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        extendBody: false,
        body: pages[activeIndex],
        bottomNavigationBar: Container(
          height: 66,
          margin: const EdgeInsets.only(
            left: 16,
            right: 16,
            bottom: 24
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(30)
          ),
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: List.generate(
            4,
            (index) => MenuIconItem(
                icon: icons[index],
                onTap: () {
                  setState(() {
                    activeIndex = index;
                  });
                },
                active: activeIndex == index ? true : false, text: texts[index],),
          )),
        ),
      ),
    );
  }
}
