import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

ThemeData lightTheme(BuildContext context) {
  return ThemeData.light().copyWith(
    brightness: Brightness.light,
    dividerColor: Colors.black,
    scaffoldBackgroundColor: AppColors.lightScaffoldColor,
    colorScheme: Theme.of(context).colorScheme.copyWith(primary: Colors.black),
    textTheme: ThemeData.light()
        .textTheme
        .apply(fontFamily: 'NunitoSans')
        .copyWith(
            headline5: Theme.of(context)
                .textTheme
                .headline5!
                .copyWith(color: AppColors.darkBlueColor)),
    primaryTextTheme:
        ThemeData.light().textTheme.apply(fontFamily: 'NunitoSans'),
    inputDecorationTheme: const InputDecorationTheme(
      focusColor: Colors.black,
      border: InputBorder.none,
      focusedBorder: InputBorder.none,
      errorBorder: InputBorder.none,
      enabledBorder: InputBorder.none,
    ),
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: Colors.black,
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        primary: Colors.black,
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Colors.grey,
    ),
  );
}

//===============================================================
ThemeData darkTheme(BuildContext context) {
  return ThemeData.dark().copyWith(
    brightness: Brightness.dark,
    dividerColor: Colors.white,
    scaffoldBackgroundColor: AppColors.darkScaffoldColor,
    colorScheme: Theme.of(context).colorScheme.copyWith(primary: Colors.grey),
    textTheme: ThemeData.dark()
        .textTheme
        .apply(
          fontFamily: 'NunitoSans',
        )
        .copyWith(
            headline5: Theme.of(context)
                .textTheme
                .headline5!
                .copyWith(color: Colors.white)),
    primaryTextTheme: ThemeData.dark().textTheme.apply(
          fontFamily: 'NunitoSans',
        ),
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: Colors.grey,
    ),
    inputDecorationTheme: const InputDecorationTheme(
      focusColor: Colors.black,
      border: InputBorder.none,
      focusedBorder: InputBorder.none,
      errorBorder: InputBorder.none,
      enabledBorder: InputBorder.none,
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        primary: Colors.white,
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Colors.black,
    ),
  );
}
