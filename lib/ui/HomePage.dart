

import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:project_provider/ui/ui_helper/HomePageView.dart';
import 'package:project_provider/ui/ui_helper/ThemeSwither.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageViewController = PageController(initialPage: 0);
  final List<String> _choiceList = ['Top MarketCap','Top Gainers', 'Top Losers'];
  var _defaultChoice = 0;
  @override
  Widget build(BuildContext context) {


    var primaryColor = Theme.of(context).primaryColor;
    TextTheme textTheme = Theme.of(context).textTheme;



    return Scaffold(
      drawer: Drawer(),
      appBar: AppBar(
        backgroundColor: primaryColor,
        actions: const [
          ThemeSwitcher()
        ],
        title: Text("Flutter course A"),
        titleTextStyle: textTheme.titleLarge,
        centerTitle: true,
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: double.infinity,
                  height: 160,
                  child: Stack(
                    children: [
                      HomePageView(controller: _pageViewController),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: SmoothPageIndicator(
                            controller: _pageViewController,
                            count: 4,
                            effect: const ExpandingDotsEffect(
                              dotWidth: 10,
                              dotHeight: 10,
                            ),
                            onDotClicked: (index) => _pageViewController.animateToPage(index, duration: Duration(microseconds: 300), curve: Curves.easeInOut),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),

              SizedBox(
                height: 30,
                width: double.infinity,
                child: Marquee(
                  text: 'Some sample text that takes some space.',
                  style: TextStyle(fontWeight: FontWeight.bold),
                  scrollAxis: Axis.horizontal,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  blankSpace: 20.0,
                  velocity: 100.0,
                  pauseAfterRound: Duration(seconds: 1),
                  startPadding: 10.0,
                  accelerationDuration: Duration(seconds: 1),
                  accelerationCurve: Curves.linear,
                  decelerationDuration: Duration(milliseconds: 300),
                  decelerationCurve: Curves.easeOut,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  children: [
                    Expanded(child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.all(20),
                        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10)))
                      ),
                      child: const Text("buy"),
                    )),
                    SizedBox(width: 10,),
                    Expanded(child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          padding: const EdgeInsets.all(20),
                          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                      ),
                      child: const Text("sell"),
                    )),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Wrap(
                      spacing: 8,
                      children: List.generate(_choiceList.length, (index) {
                        return ChoiceChip(
                          label: Text(_choiceList[index]),
                          selected: _defaultChoice == index,
                          selectedColor: Colors.blue,
                          onSelected: (value) {
                            setState(() {
                              _defaultChoice = value ? index : _defaultChoice;
                            });
                          },
                        );
                      })
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}
