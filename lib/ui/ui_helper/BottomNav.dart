
import 'package:flutter/material.dart';

class BottomNav extends StatelessWidget {
  PageController controller;
  BottomNav({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var primaryColor = Theme.of(context).primaryColor;

    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      notchMargin: 5,
      color: primaryColor,
      child: SizedBox(
        height: 63,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 50,
              width: MediaQuery.of(context).size.width / 2 - 20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(onPressed: (){
                    controller.animateToPage(0, duration: const Duration(microseconds: 300), curve: Curves.easeInOut);
                  }, icon: const Icon(Icons.home)),
                  IconButton(onPressed: (){
                    controller.animateToPage(1, duration: const Duration(microseconds: 300), curve: Curves.easeInOut);

                  }, icon: const Icon(Icons.bar_chart)),
                ],
              ),
            ),
            SizedBox(
              height: 50,
              width: MediaQuery.of(context).size.width / 2 - 20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(onPressed: (){
                    controller.animateToPage(2, duration: const Duration(microseconds: 300), curve: Curves.easeInOut);

                  }, icon: const Icon(Icons.person)),
                  IconButton(onPressed: (){
                    controller.animateToPage(3, duration: const Duration(microseconds: 300), curve: Curves.easeInOut);

                  }, icon: const Icon(Icons.bookmark)),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}
