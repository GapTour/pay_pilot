import 'package:flutter/material.dart';

const Color kPrimaryColor = Color(0xFF0D1B2A);
const Color kOnPrimaryColor = Color(0xFFF5F0E1);
const Color kSecondaryColor = Color(0xFFE76F51);
const Color kOnSecondaryColor = Color(0xFFFFFFFF);
const Color kErrorColor = Color(0xFFD62828);

final ThemeData appTheme = ThemeData(
  colorScheme: ColorScheme(
    brightness: Brightness.dark,
    primary: kPrimaryColor,
    onPrimary: kOnPrimaryColor,
    secondary: kSecondaryColor,
    onSecondary: kOnSecondaryColor,
    error: kErrorColor,
    onError: Colors.white,

    surface: kPrimaryColor,
    onSurface: kOnPrimaryColor,
  ),
  textTheme: const TextTheme(
    headlineLarge: TextStyle(
      fontWeight: FontWeight.bold,
      color: kOnPrimaryColor,
    ),
    bodyMedium: TextStyle(color: kOnPrimaryColor),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: kPrimaryColor,
    foregroundColor: kOnPrimaryColor,
    elevation: 0,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: kSecondaryColor,
      foregroundColor: kOnSecondaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
    ),
  ),
);
