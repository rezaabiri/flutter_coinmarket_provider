import 'package:flutter/material.dart';

class HomePageView extends StatefulWidget {
  var controller;
  HomePageView({Key? key, required this.controller}) : super(key: key);

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {

  var images = [
    'assets/images/image1.png',
    'assets/images/image2.png',
    'assets/images/image3.png',
    'assets/images/image4.png',
  ];

  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return PageView(
      allowImplicitScrolling: true,
      controller: widget.controller,
      children: [
        myPages(images[0]),
        myPages(images[1]),
        myPages(images[2]),
        myPages(images[3]),
      ],
    );
  }

  Widget myPages(String image){
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      child: Image(image: AssetImage(image), fit: BoxFit.fill,),
    );
  }
}
