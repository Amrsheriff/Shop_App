import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:untitled/shared/styles/colors.dart';

ThemeData lightTheme = ThemeData(
    primarySwatch: defaultColor,
    scaffoldBackgroundColor: Colors.white,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: defaultColor,
    ),
    appBarTheme: AppBarTheme(
      titleSpacing: 20.0,
      backwardsCompatibility: false,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
      ),
      backgroundColor: Colors.white,
      elevation: 0.0,
      titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 20.0,
          fontWeight: FontWeight.bold
      ),
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: defaultColor,
      elevation: 20.0,
      backgroundColor: Colors.white,
    ),
    textTheme: TextTheme(
      bodyText1: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
      bodyText2: TextStyle(
        fontSize: 16.0,
        color: Colors.black,
      ),
    ),
    fontFamily: 'ntailu',
    primaryColorLight: Colors.white,
    primaryColorDark: defaultColor,
);

ThemeData darkTheme = ThemeData(
  primarySwatch: defaultColor,
  scaffoldBackgroundColor: Color(0xFF333739),
  //scaffoldBackgroundColor: HexColor('333739'),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: defaultColor,
  ),
  appBarTheme: AppBarTheme(
    titleSpacing: 20.0,
    backwardsCompatibility: false,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Color(0xFF333739),
      statusBarIconBrightness: Brightness.light,
    ),
    backgroundColor: Color(0xFF333739),
    elevation: 0.0,
    titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20.0,
        fontWeight: FontWeight.bold
    ),
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: defaultColor,
    unselectedItemColor: Colors.grey,
    elevation: 20.0,
    backgroundColor: Color(0xFF333739),
  ),
  textTheme: TextTheme(
    bodyText1: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
    bodyText2: TextStyle(
      fontSize: 16.0,
      color: Colors.white,
    ),
  ),
  fontFamily: 'ntailu',
  primaryColorLight: Colors.black26,
  primaryColorDark: defaultColor,
);