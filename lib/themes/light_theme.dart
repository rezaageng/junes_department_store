import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData lightTheme = ThemeData(
  colorScheme: const ColorScheme.light(
    primary: Colors.white,
    secondary: Colors.orange,
  ),
  appBarTheme: const AppBarTheme(
    foregroundColor: Colors.black,
    elevation: 0,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  ),
  canvasColor: Colors.white,
  cardTheme: const CardTheme(color: Color.fromRGBO(245, 245, 245, 1)),
  textTheme: const TextTheme(
    headline6: TextStyle(color: Colors.black),
    caption: TextStyle(height: 1.5),
    subtitle2: TextStyle(color: Colors.black54),
  ),
  fontFamily: 'NotoSansJP',
  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: Colors.orange,
    selectionColor: Colors.orange,
    selectionHandleColor: Colors.orange,
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    selectedIconTheme: IconThemeData(color: Colors.orange),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      padding: MaterialStateProperty.all(const EdgeInsets.all(8)),
      backgroundColor: MaterialStateProperty.all(Colors.green),
      foregroundColor: MaterialStateProperty.all(Colors.white),
    ),
  ),
);
