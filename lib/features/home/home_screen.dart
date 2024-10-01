import 'package:flutter/material.dart';
import 'package:fyfax/shared/widgets/menu_icon_item.dart';
import 'package:iconsax/iconsax.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Widget> pages = [
    Container(),
    Container(),
    Container(),
    Container(),
  ];
  List<IconData> icons = [
    Iconsax.home,
    Iconsax.book_square,
    Iconsax.clock,
    Iconsax.user
  ];
  int activeIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[activeIndex],
      bottomNavigationBar: Container(
        height: 66,
        margin: const EdgeInsets.only(
          left: 16,
          right: 16,
          bottom: 24
        ),
        decoration: BoxDecoration(
          color: Colors.grey,
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
              active: activeIndex == index ? true : false),
        )),
      ),
    );
  }
}
