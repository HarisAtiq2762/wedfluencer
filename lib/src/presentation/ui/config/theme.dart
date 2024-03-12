import 'package:flutter/material.dart';

import '../../../app.dart';

const headlineColor = Colors.black;
final wedfluencerTheme = ThemeData(
  useMaterial3: true,
  scaffoldBackgroundColor: Colors.transparent,
  primaryColor: themeColor,
  hintColor: const Color(0xFF9E9E9E),
  colorScheme: const ColorScheme(
    primary: themeColor,
    primaryContainer: themeColor,
    secondary: Color(0xffF7CB46),
    secondaryContainer: Color(0xffF7CB46),
    surface: Colors.white54,
    background: Colors.white,
    error: Color(0xffEE1E1D),
    onPrimary: Colors.white,
    onSecondary: Colors.black,
    onSurface: Colors.black,
    onBackground: Colors.black,
    onError: Color(0xffEE1E1D),
    brightness: Brightness.light,
  ),
  appBarTheme: const AppBarTheme(
    elevation: 0,
    color: Colors.transparent,
    iconTheme: IconThemeData(color: Colors.black),
  ),
  fontFamily: 'LatoBlack',
  textTheme: const TextTheme(
    displayLarge: TextStyle(
        fontSize: 92.0, fontWeight: FontWeight.w900, color: headlineColor),
    displayMedium: TextStyle(
        fontSize: 60.0, color: headlineColor, fontWeight: FontWeight.w900),
    displaySmall: TextStyle(
        fontSize: 40.0, fontWeight: FontWeight.bold, color: headlineColor),
    headlineMedium: TextStyle(
        fontSize: 34.0, color: headlineColor, fontWeight: FontWeight.bold),
    headlineSmall: TextStyle(
        fontWeight: FontWeight.bold, fontSize: 24, color: headlineColor),
    titleLarge: TextStyle(
        fontSize: 20, fontWeight: FontWeight.w700, color: headlineColor),
    bodyLarge: TextStyle(
        fontSize: 20, fontWeight: FontWeight.normal, color: headlineColor),
    bodyMedium: TextStyle(
        fontSize: 18.0, fontWeight: FontWeight.normal, color: headlineColor),
    bodySmall: TextStyle(
        fontSize: 15.0, fontWeight: FontWeight.normal, color: headlineColor),
    labelLarge: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
    labelSmall: TextStyle(fontSize: 16, letterSpacing: 0),
  ),
  inputDecorationTheme: const InputDecorationTheme(
    hintStyle: TextStyle(fontSize: 14, color: Color(0xFF9E9E9E)),
    labelStyle: TextStyle(color: themeColor),
    // border: InputBorder.none,
    // focusedBorder: InputBorder.none,
    // enabledBorder: InputBorder.none,
    // errorBorder: InputBorder.none,
    // disabledBorder: InputBorder.none,
  ),
  // pageTransitionsTheme: const PageTransitionsTheme(builders: {
  //   TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
  //   TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
  // }),
  dialogTheme: const DialogTheme(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)))),
);
