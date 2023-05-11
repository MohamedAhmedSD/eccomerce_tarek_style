//? SM G970N
//* My current device height 640.0 and width is 360.0

//? ========================================================
//? [1] I convert hard code (numbers) by comparing with result from MQ
//* to determain => x factor
//* our device H => 640
//* our device W => 360
//* x = 360/10 = 36

//   //! ===== dynamic height padding and margin ====
//   //? I use python on terminal then copy math process into it easy way
//   //* x = 640/5 = 128.0
//   //* x = 640/10 = 64.0
//   //* x = 640/15 = 42.66
//   //* x = 640/20 = 32.0
//   //* x = 640/30 = 21.33
//   //* x = 640/40 = 16.0
//   //* x = 640/45 = 14.22
//   //* x = 640/60 = 10.66
//   //* x = 640/70 = 9.14

//! ===== dynamic width padding and margin ====
//? I use python on terminal then copy math process into it easy way
//* x = 360/5 = 72.0
//* x = 360/10 = 36.0
//* x = 360/15 = 24.0
//* x = 360/20 = 18.0
//* x = 360/30 = 12.0
//* x = 360/40 = 9.0
//* x = 360/45 = 8.0
//* x = 360/60 = 6.0
//* x = 360/70 = 5.14

import 'package:flutter/material.dart';

class AppMediaQuery {
  //* [1] height
  static double height(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return height;
  }

  //* [2] width
  static double width(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return width;
  }

  //* Make method take your height as input to divide screen height by it

  static double widgetHeight(BuildContext context, double widgetHeight) {
    double height = MediaQuery.of(context).size.height / widgetHeight;
    return height;
  }

  //* Make method take your width as input to divide screen width by it

  static double widgetWidth(BuildContext context, double widgetWidth) {
    double width = MediaQuery.of(context).size.width / widgetWidth;
    return width;
  }

  //* I need equation when I write in pixel calc automatically what I need
  //* f = mq/h => mq = f * h => h = mq/f

  static getHeight(BuildContext context, double height) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);

    final double screenHeight = mediaQuery.size.height;

    //* [1] it work
    // return (height / 640.0) * screenHeight;
    //* [1] it work
    return (height / screenHeight) * screenHeight;
  }

  static getWidth(BuildContext context, double width) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);

    final double screenWidth = mediaQuery.size.width;
    //* [1] it work
    // return (width / 360.0) * screenWidth;
    //* [2] it work
    return (width / screenWidth) * screenWidth;
  }
}
