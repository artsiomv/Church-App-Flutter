import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

Widget _CarouselSlider () {
  CarouselSlider(
    height: 280.0,
    aspectRatio: 16/9,
    viewportFraction: 1.0,
    initialPage: 0,
    enableInfiniteScroll: true,
    reverse: false,
    autoPlay: true,
    autoPlayInterval: Duration(seconds: 5),
    autoPlayAnimationDuration: Duration(milliseconds: 800),
    // autoPlayCurve: Curve.fastOutSlowIn ,
    pauseAutoPlayOnTouch: Duration(seconds: 10),
    scrollDirection: Axis.horizontal,
    enlargeCenterPage: true,
    items: [1,2,3,4,5].map((i) {
      return Builder(
        builder: (BuildContext context) {
          return Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.symmetric(horizontal: 5.0),
            decoration: BoxDecoration(
              color: Colors.amber
            ),
            child: Text('text $i', style: TextStyle(fontSize: 16.0),)
          );
        },
      );
    }).toList(),
  ); 


}