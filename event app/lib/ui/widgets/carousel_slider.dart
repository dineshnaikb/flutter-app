import 'package:carousel_slider/carousel_slider.dart';
import 'package:events/logic/cubit/indicator_cubit.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

List<String> listPaths = [
  "assets/rect.png",
  "assets/rect.png",
  "assets/rect.png",
  "assets/rect.png",
  "assets/rect.png",
  "assets/rect.png",
];

class CustomIndicator extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CustomIndicatorState();
  }
}

class CustomIndicatorState extends State<CustomIndicator> {
  int currentPos = 0;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      CarouselSlider.builder(
          itemCount: listPaths.length,
          options: CarouselOptions(
              viewportFraction: 1,
              height: 46.0.h,
              autoPlay: true,
              disableCenter: true,
              enlargeCenterPage: true,
              onPageChanged: (index, reason) {
                context.read<IndicatorCubit>().change(index);
              }),
          itemBuilder:
              (BuildContext context, int itemIndex, int pageViewIndex) =>
                  MyImageView(listPaths[itemIndex])),
    ]);
  }
}

class MyImageView extends StatelessWidget {
  String imgPath;

  MyImageView(this.imgPath);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            imgPath,
          ),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
