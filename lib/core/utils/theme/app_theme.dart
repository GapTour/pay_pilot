import 'package:flutter/material.dart';

const Color kPrimaryColor = Color(0xFF00192a);
const Color kPrimaryContainerColor = Color(0xFFdeeaf2);
const Color kOnPrimaryColor = Color(0xFFf1edbe);
const Color kSecondaryColor = Color(0xFFf7941d);
const Color kOnSecondaryColor = Color(0xFFFFFFFF);
const Color kErrorColor = Color(0xFF760d17);

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
      fontSize: 15,
    ),
    headlineSmall: TextStyle(
      color: kOnPrimaryColor,
      fontSize: 11,
      fontWeight: FontWeight.bold,
    ),
    bodyMedium: TextStyle(
      color: kSecondaryColor,
      fontSize: 18,
      fontWeight: FontWeight.bold,
    ),
    bodySmall: TextStyle(color: kSecondaryColor, fontSize: 11),
    displayLarge: TextStyle(color: kPrimaryContainerColor, fontSize: 16),
    displayMedium: TextStyle(color: kPrimaryContainerColor, fontSize: 12.5),
    labelMedium: TextStyle(color: kPrimaryContainerColor, fontSize: 11),
    labelSmall: TextStyle(color: kPrimaryColor, fontSize: 10),
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
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(foregroundColor: kOnPrimaryColor),
  ),
);
