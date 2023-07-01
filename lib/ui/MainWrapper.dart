
import 'package:flutter/material.dart';
import 'package:project_provider/main.dart';
import 'package:project_provider/ui/HomePage.dart';
import 'package:project_provider/ui/MarketViewPage.dart';
import 'package:project_provider/ui/ProfilePage.dart';
import 'package:project_provider/ui/WatchList.dart';
import 'package:project_provider/ui/ui_helper/BottomNav.dart';

class MainWrapper extends StatefulWidget {
  const MainWrapper({Key? key}) : super(key: key);

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {

  final PageController _myPage = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () {}, child: Icon(Icons.compare_arrows_outlined),),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNav(controller: _myPage,),
      body: PageView(
        controller: _myPage,
        children: const [
          HomePage(),
          MarketViewPage(),
          ProfilePage(),
          WatchList()
        ],
      ),
    );
  }
}
