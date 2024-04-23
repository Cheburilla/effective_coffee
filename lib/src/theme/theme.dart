import 'package:effective_coffee/src/theme/app_colors.dart';
import 'package:flutter/material.dart';

final theme = ThemeData(
  cardTheme: const CardTheme(
    color: AppColors.white,
    margin: EdgeInsets.all(0),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(16)),
    ),
  ),
  textTheme: const TextTheme(
    displayMedium: TextStyle(
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w700,
      fontSize: 24,
      height: 1.33,
      letterSpacing: 0.25,
    ),
    displaySmall: TextStyle(
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w700,
      fontSize: 16,
      height: 1.5,
      letterSpacing: 0.4,
    ),
    titleLarge: TextStyle(
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w600,
      fontSize: 32,
      height: 1.2,
    ),
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
    bodySmall: TextStyle(
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w400,
      fontSize: 12,
      height: 1.33,
      letterSpacing: 0.4,
      color: AppColors.white,
    ),
    labelLarge: TextStyle(
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w400,
      fontSize: 20,
      height: 1.2,
      letterSpacing: 0.25,
      color: AppColors.white,
    ),
    labelMedium: TextStyle(
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w400,
      fontSize: 14,
      height: 1.42,
      letterSpacing: 0.4,
      color: AppColors.white,
    ),
    labelSmall: TextStyle(
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w400,
      fontSize: 10,
      height: 1,
      letterSpacing: 0.4,
      color: AppColors.white,
    ),
  ),
  filledButtonTheme: const FilledButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStatePropertyAll(AppColors.lightblue),
    ),
  ),
  bottomSheetTheme: const BottomSheetThemeData(
    dragHandleColor: AppColors.grey,
    dragHandleSize: Size(48, 4),
    surfaceTintColor: AppColors.white,
    backgroundColor: AppColors.white,
  ),
  snackBarTheme: const SnackBarThemeData(
    backgroundColor: AppColors.snackbar,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      padding: EdgeInsets.zero,
      elevation: 0,
      backgroundColor: AppColors.lightblue,
    ),
  ),
);
