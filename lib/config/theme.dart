import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  AppTheme._();

  static const Color primaryColor = Color.fromARGB(255, 39, 165, 45);
  static const Color backgroundColor = Colors.white;
  static const Color iconColor = Color(0xFF888C95);
  static const Color errorColor = Color(0xFFE96767);

  static ThemeData lightTheme = ThemeData(
    colorScheme: ThemeData.light().colorScheme.copyWith(primary: primaryColor),
    scaffoldBackgroundColor: backgroundColor,
    textTheme: GoogleFonts.robotoTextTheme(),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: const BorderSide(color: primaryColor))),
            iconColor: MaterialStateProperty.all(primaryColor),
            elevation: MaterialStateProperty.all(0.0),
            textStyle: MaterialStateProperty.all(
                const TextStyle(color: primaryColor)))),
    textSelectionTheme: const TextSelectionThemeData(cursorColor: primaryColor),
    inputDecorationTheme: InputDecorationTheme(
        hintStyle: const TextStyle(color: iconColor),
        prefixIconColor: iconColor,
        suffixIconColor: iconColor,
        focusColor: iconColor,
        contentPadding: const EdgeInsets.all(4.0),
        enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: iconColor,
            ),
            borderRadius: BorderRadius.circular(20.0)),
        focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: primaryColor),
            borderRadius: BorderRadius.circular(20.0)),
        errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: errorColor),
            borderRadius: BorderRadius.circular(20.0)),
        focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: errorColor),
            borderRadius: BorderRadius.circular(20.0)),
        errorStyle: const TextStyle(color: errorColor)),
  );
}
