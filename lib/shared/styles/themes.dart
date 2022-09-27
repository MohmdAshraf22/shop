import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop/shared/styles/colors.dart';

ThemeData darkTheme = ThemeData(
  scaffoldBackgroundColor: HexColor('333739'),
  appBarTheme: AppBarTheme(
    backwardsCompatibility: false,
    systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: HexColor('333739'),
        statusBarIconBrightness: Brightness.light
    ),
    elevation: 0,
    backgroundColor: HexColor('333739'),
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 22,
    ),
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
  ),
  //primarySwatch: defaultColor,
  textTheme: TextTheme(
    bodyText1: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
  ),
  // fontFamily: 'Jannah',
);
ThemeData lightTheme = ThemeData(
  //    inputDecorationTheme: InputDecorationTheme(
  //     focusedBorder: OutlineInputBorder(
  //         borderRadius: BorderRadius.circular(30),
  //         borderSide: BorderSide(
  //         width: 3,
  //         color: defaultColor
  //       ),
  //     )
  // ) ,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: AppBarTheme(
    backwardsCompatibility: false,
    systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark
    ),
    elevation: 0,
    backgroundColor: Colors.white,
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 22,
    ),
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
  ),
  textTheme: TextTheme(
    bodyText1: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
  ),
  // fontFamily: 'Jannah',
);