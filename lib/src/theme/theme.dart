import 'package:effective_coffee/src/theme/app_colors.dart';
import 'package:flutter/material.dart';

final theme = ThemeData(
  cardTheme: const CardTheme(
    color: AppColors.white,
    margin: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
    shape: BeveledRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(16)),
    ),
  ),
  textTheme: const TextTheme(
    titleMedium: TextStyle(
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w500,
      fontSize: 16,
      height: 1.5,
      letterSpacing: 0.15,
    ),
    bodyMedium: TextStyle(
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w400,
      fontSize: 14,
      height: 1.43,
      letterSpacing: 0.25,
    ),
  ),
  filledButtonTheme: const FilledButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStatePropertyAll(AppColors.lightblue),
    ),
  ),
);
