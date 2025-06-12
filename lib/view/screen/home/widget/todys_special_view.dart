import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/home/widget/todays_special_widget.dart';
import 'package:provider/provider.dart';

import '../../../../provider/top_restaurants_provider.dart';
class TodaysSpecialView extends StatelessWidget {
  const TodaysSpecialView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<TopRestaurantsProvider>(builder: (context, topRestaurantsProvider,child,){
      return topRestaurantsProvider.todaysSpecialList.isNotEmpty ?
      SizedBox(
        height: 300,

        child:CarouselSlider.builder(

          // scrollDirection: Axis.horizontal
          // ,
          itemCount: topRestaurantsProvider.todaysSpecialList.length,
          itemBuilder: (BuildContext context, int index, int realIndex) {
            return TodaysSpecicalWidget(product: topRestaurantsProvider.todaysSpecialList[index]);
          },
          options: CarouselOptions(
            // Configure your carousel options here
            // For example:
            height: 300, // Adjust this value according to your UI requirements
            //enableInfiniteScroll: true,
            autoPlay: true,
            aspectRatio: .1,
            autoPlayInterval: Duration(seconds: 4),
            autoPlayAnimationDuration: Duration(milliseconds: 800),
            viewportFraction: 1.0,

            //autoPlayCurve: Curves.fastOutSlowIn,
            //enlargeCenterPage: true,
            onPageChanged: (int index, CarouselPageChangedReason reason) {
              // Handle page change here if needed
            },
          ),
        ),

      ) :Container();

    });
  }
}
