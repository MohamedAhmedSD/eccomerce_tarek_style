import 'package:flutter/material.dart';

import 'constants.dart';

class AppTheme {
  static ThemeData appTheme = ThemeData(
    //* color of most app
    scaffoldBackgroundColor: AppColors.scaffoldBG,
    //* COLOR OF BUTTONS
    primaryColor: AppColors.primeryColor,
    // primarySwatch: Colors.blue,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.appBarTheme,
      elevation: 2,
      iconTheme: IconThemeData(color: AppColors.icontheme),
    ),
    //? border themes:::::::::::::::::::::::::::::::::::::
    //* group [A] ==== [grey] ==============================
    inputDecorationTheme: InputDecorationTheme(
      // labelStyle: Theme.of(_).textTheme.labelSmall,
      //* to deal with all borders
      //* all same prpberties and errors different on only them color
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(2.0),
        borderSide: const BorderSide(
          color: Colors.grey,
        ),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(2.0),
        borderSide: const BorderSide(
          color: Colors.grey,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(2.0),
        borderSide: const BorderSide(
          color: Colors.grey,
        ),
      ),
      //* group [B] =======[red]==============================
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(2.0),
        borderSide: const BorderSide(
          color: Colors.red,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(2.0),
        borderSide: const BorderSide(
          color: Colors.red,
        ),
      ),
    ),
  );
}
