import 'package:flutter/material.dart';
import 'package:fyfax/features/first/second_screen.dart';
import 'package:fyfax/shared/widgets/validated_button.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  int activeIndex = 0;
  @override
  Widget build(BuildContext context) {
    List<String> images = [
      'assets/images/image1.jpg',
      'assets/images/image2.jpg',
      'assets/images/image3.jpg',
    ];
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            CarouselSlider(
                items: List.generate(3, (index) => Image.asset(images[index], fit: BoxFit.fitHeight,),),
                options: CarouselOptions(
                  height: 600,
                  viewportFraction: 0.98,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  scrollDirection: Axis.horizontal,
                  onPageChanged: (index, reason) {
                    setState(() {
                      activeIndex = index;
                    });
                  },
                )
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                  3, (index) => Container(
                width: 10,
                height: 10,
                margin: const EdgeInsets.only(
                    top: 14,
                    left: 6,
                    right: 6,
                    bottom: 14
                ),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: activeIndex==index ?
                    Theme.of(context).colorScheme.primary :
                    Theme.of(context).colorScheme.onSurface
                ),
              )
              ),
            ),
            const SizedBox(height: 24,),
            Text('Bienvenu sur FyFax', style: GoogleFonts.inter(fontSize: 18),),
            const SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.only(
                  left: 16,
                  right: 16
              ),
              child: Text('Consultez toutes les anciennes épreuves de vos grands concours de médécine', style: GoogleFonts.inter(fontSize: 16),),
            ),
            ValidatedButton(onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => SecondScreen(),));
            }, text:  'Allons-y')
          ],
        ),
      ),
    );
  }
}

