import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'consts.dart';

ThemeData lightTheme = ThemeData(
  scaffoldBackgroundColor: AppColors.surfaceLight,
  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.surfaceLight,
    surfaceTintColor: Colors.transparent
  ),
  textTheme: GoogleFonts.sairaStencilOneTextTheme().copyWith(
    displayLarge: GoogleFonts.sairaStencilOne().copyWith(fontWeight: FontWeight.bold, fontSize: 35),
    titleLarge: GoogleFonts.sairaStencilOne().copyWith(fontWeight: FontWeight.bold, fontSize: 28),
    titleMedium: GoogleFonts.sairaStencilOne().copyWith(fontSize: 20, fontWeight: FontWeight.bold),
    bodyLarge: GoogleFonts.sairaStencilOne().copyWith(fontSize: 18, fontWeight: FontWeight.bold),
    labelMedium: GoogleFonts.sairaStencilOne().copyWith(color: Colors.black54, fontWeight: FontWeight.normal)
  ),
  iconTheme: IconThemeData(
    color: AppColors.onSurfaceLight,
  ),
  colorScheme: ColorScheme.light(
    surface: AppColors.surfaceVariantLight,
    onSecondary: AppColors.onSurfaceLight,
    primary: AppColors.primary,
    onPrimary: Colors.white
  ),
);

ThemeData darkTheme = ThemeData(
  scaffoldBackgroundColor: AppColors.surfaceDark,
  appBarTheme: AppBarTheme(
      backgroundColor: AppColors.surfaceDark,
      surfaceTintColor: Colors.transparent
  ),
  textTheme: GoogleFonts.sairaStencilOneTextTheme(ThemeData.dark().textTheme).copyWith(
    displayLarge: GoogleFonts.sairaStencilOne().copyWith(fontWeight: FontWeight.bold, fontSize: 35),
    titleLarge: GoogleFonts.sairaStencilOne().copyWith(fontWeight: FontWeight.bold, fontSize: 28),
    titleMedium: GoogleFonts.sairaStencilOne().copyWith(fontSize: 20, fontWeight: FontWeight.bold),
    bodyLarge: GoogleFonts.sairaStencilOne().copyWith(fontSize: 18, fontWeight: FontWeight.bold),
    labelMedium: GoogleFonts.sairaStencilOne().copyWith(color: Colors.black54, fontWeight: FontWeight.normal)
  ),
  iconTheme: IconThemeData(
      color: AppColors.onSurfaceDark
  ),
  colorScheme: ColorScheme.dark(
    surface: AppColors.surfaceVariantDark,
    onSecondary: AppColors.onSurfaceDark,
    primary: AppColors.primary,
    onPrimary: Colors.white
  ),
);