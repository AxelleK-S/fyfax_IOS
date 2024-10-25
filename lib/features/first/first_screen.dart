import 'package:flutter/material.dart';
import 'package:fyfax/features/first/second_screen.dart';
import 'package:fyfax/shared/widgets/validated_button.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> images = [
      'assets/images/image1.jpg',
      'assets/images/image2.jpg',
      'assets/images/image3.jpg',
    ];
    return Scaffold(
      body: Column(
        children: [
          CarouselSlider(
              items: List.generate(3, (index) => Image.asset(images[index], fit: BoxFit.fitHeight,),),
              options: CarouselOptions(
                height: 600,
                //aspectRatio: 16/9,
                viewportFraction: 1,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(milliseconds: 10),
                autoPlayCurve: Curves.ease,
                enlargeCenterPage: true,
                enlargeFactor: 0.3,
                scrollDirection: Axis.horizontal,
              )
          ),
          const SizedBox(height: 24,),
          Text('Bienvenu sur FyFax', style: GoogleFonts.handlee(),),
          const SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.only(
              left: 16,
              right: 16
            ),
            child: Text('Consultez toutes les anciennes épreuves de vos grands concours de médécine', style: GoogleFonts.handlee(),),
          ),
          ValidatedButton(onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => SecondScreen(),));
          }, text:  'Allons-y')
        ],
      ),
    );
  }
}
