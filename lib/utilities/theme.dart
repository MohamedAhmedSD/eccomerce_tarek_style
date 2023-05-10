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
    //! I use text theme here instead that inside labelStyle [*]
    textTheme: const TextTheme(labelSmall: TextStyle()),

    inputDecorationTheme: InputDecorationTheme(
      fillColor: Colors.white,
      filled: true,
      //! ======[ how fix label text inside TFF ]============
      floatingLabelBehavior: FloatingLabelBehavior.never,
      //![*]
      // labelStyle: Theme.of(_).textTheme.labelSmall,
      //? border themes:::::::::::::::::::::::::::::::::::::
      //* group [A] ==== [grey] ==============================
      //* to deal with all borders
      //* all same prpberties and errors different on only them color
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4.0),
        borderSide: const BorderSide(
          color: Colors.transparent,
        ),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4.0),
        borderSide: const BorderSide(
          color: Colors.transparent,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4.0),
        borderSide: const BorderSide(
          color: Colors.transparent,
        ),
      ),
      //* group [B] =======[red]==============================
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4.0),
        borderSide: const BorderSide(
          color: Colors.red,
          // strokeAlign: -1,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4.0),
        borderSide: const BorderSide(
          color: Colors.red,
          // strokeAlign: -1,
        ),
      ),
    ),
  );
}
