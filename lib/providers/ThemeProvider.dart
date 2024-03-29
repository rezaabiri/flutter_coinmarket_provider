
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeProvider extends ChangeNotifier {

  ThemeMode themeMode = ThemeMode.light;
  bool get isDarkMode => themeMode == ThemeMode.dark;

  void toggleTheme() {
    themeMode = themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

class MyThemes {
  static final darkTheme = ThemeData(
    textTheme: TextTheme(
      titleLarge: GoogleFonts.ubuntu(color: Colors.white, fontSize: 22,fontWeight: FontWeight.bold),
      bodySmall: GoogleFonts.ubuntu(color: Colors.white, fontSize: 15),
      titleMedium: GoogleFonts.ubuntu(color: Colors.white, fontSize: 15),
      labelSmall: GoogleFonts.ubuntu(color: Colors.white, fontSize: 13),
      titleSmall: GoogleFonts.ubuntu(color: Colors.white, fontSize: 12),
      displayMedium: GoogleFonts.ubuntu(color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold),
      displaySmall: GoogleFonts.ubuntu(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold),

    ),

    unselectedWidgetColor: Colors.white70,
    primaryColorLight: Colors.white,
    scaffoldBackgroundColor: Colors.black,
    primaryColor: Colors.blueAccent[700],
    secondaryHeaderColor: Colors.black,
    iconTheme: const IconThemeData(color: Colors.black,opacity: 0.8),
  );
  static final liteTheme = ThemeData(
    textTheme: TextTheme(
      titleLarge: GoogleFonts.ubuntu(color: Colors.black, fontSize: 22,fontWeight: FontWeight.bold),
      titleMedium: GoogleFonts.ubuntu(color: Colors.black, fontSize: 15),
      bodySmall: GoogleFonts.ubuntu(color: Colors.black, fontSize: 15),
      labelSmall: GoogleFonts.ubuntu(color: Colors.black38, fontSize: 13),
      titleSmall: GoogleFonts.ubuntu(color: Colors.black, fontSize: 12),
      displayMedium: GoogleFonts.ubuntu(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
      displaySmall: GoogleFonts.ubuntu(color: Colors.black, fontSize: 13, fontWeight: FontWeight.bold),



    ),
    unselectedWidgetColor: Colors.white,
    primaryColorLight: Colors.white,
    scaffoldBackgroundColor: Colors.white,
    primaryColor: Colors.blueAccent,
    secondaryHeaderColor: Colors.white,
    iconTheme: const IconThemeData(color: Colors.white , opacity: 0.8),
  );

}