import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
class SliderScreen extends StatefulWidget {
  const SliderScreen({super.key});

  @override
  State<SliderScreen> createState() => _SliderScreenState();
}

class _SliderScreenState extends State<SliderScreen> {
  List imagelist=[
    {"id": 1, "image_path": 'assets/images/image_1.jpg'},
    {"id": 2, "image_path": 'assets/images/image_2.jpg'},
    {"id": 3, "image_path": 'assets/images/image_3.jpg'},
    {"id": 4, "image_path": 'assets/images/image_4.jpg'},
    {"id": 5, "image_path": 'assets/images/image_5.jpg'},
    {"id": 6, "image_path": 'assets/images/image_6.jpg'},
  ];
  final CarouselController carouselController= CarouselController();
  int CurrentIndex=0;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InkWell(
          onTap: (){
            print(CurrentIndex);
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: CarouselSlider(
              items: imagelist
                  .map((item) => Image.asset(
                item['image_path'],
                fit: BoxFit.cover,
                width: double.infinity,
                alignment: Alignment.center,
              )
              )
                  .toList(),
              carouselController: carouselController,
              options: CarouselOptions(
                  scrollPhysics: const BouncingScrollPhysics(),
                  autoPlay: true,
                  aspectRatio: 2,
                  viewportFraction: 1,
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enableInfiniteScroll: true,
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  onPageChanged: (index, reason){
                    setState(() {
                      CurrentIndex= index;
                    });
                  }
              )
              ,
            ),
          ),
        )
      ],
    );
  }
}
