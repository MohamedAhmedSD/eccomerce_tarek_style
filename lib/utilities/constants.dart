//! unique data
//* A sequence of UTF-16 code units.
//* Returns an ISO-8601 full-precision extended format representation.
//* to give us a code => where use it and why?
//!!!!!!!!!!!!!!!!!!! [back here] !!!!!!!!!!!!!!!!!!!!!

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//* change time to encrypt code
String documentIdFromLocalData() => DateTime.now().toIso8601String();

class AppColors {
  //? ======= themes =========================
  static const Color scaffoldBG = Color(0xFFE5E5E5);
  static const Color primeryColor = Colors.red;
  static const Color appBarTheme = Colors.white;
  static const Color icontheme = Colors.black;
  static const Color borderTheme = Colors.grey;
  //? ========= PersistentBottomNavBarItem =============
  // static const Color activeColorPrimary = CupertinoColors.activeBlue;
  static const Color activeColorPrimary = Colors.red;
  static const Color inactiveColorPrimary = CupertinoColors.systemGrey;
}
