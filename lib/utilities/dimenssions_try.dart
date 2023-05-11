// import 'package:flutter/material.dart';

// //? SM G970N
// //* My current device height 640.0 and width is 360.0

// class AppDimensions extends ChangeNotifier {
//   //* to make responsive UI we need use MQ rather hard code
//   //* but there are problem with widget context so by
//   //? by using Get.context we can solve it
// //! but how we deal with it by Provider

//   //! steps
//   //? [1] what is my current device Dimensions by MQ
//   //? ========================================================
//   //! how we use MQ to know our current device size
//   //? by using print under stf widget build
//   // var h = MediaQuery.of(context).size.height;
//   // var w = MediaQuery.of(context).size.width;
//   // if (kDebugMode) {
//   //   print(
//   //       "My current device height ${h.toString()} and width is ${w.toString()}");
//   // }
//   //? ========================================================
//   //? [2] I convert hard code (numbers) by compering with result from MQ
//   //* to determain => x factor
//   //* our device H => 640
//   //* our device W => 360
//   //* x = 640/10 = 64

//   //? [3] now use Provider
//   //! access to context == total screen size
//   //* a.
//   // static double? screenHeight;
//   // static double? screenwidth;
//   // late double screenHeight;
//   // late double screenwidth;
//   double? height60;
//   double? height40;
//   //* b. we need make method pass buildcontext as its parameter
//   updateDimensions(BuildContext context) {
//     double screenwidth = MediaQuery.of(context).size.width;
//     double screenHeight = MediaQuery.of(context).size.height;
//     double height40 = screenHeight / 200.0;
//     double height60 = screenHeight / 200.66;

//     notifyListeners();
//   }

//   //! ===== pageView ==== [if not use to all we get overflow errors]
//   // //* x = 640/320 = 2.64
//   // //* x = 640/220 = 3.84
//   // //* x = 640/120 = 7.03
//   // static double pageView = screenHeight! / 2.64;
//   // static double pageViewContainer = screenHeight! / 3.48;
//   // static double pageViewTextContainer = screenHeight! / 7.03;

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
//   // static double height5 = screenHeight! / 186.8;
//   // static double height10 = screenHeight! / 84.4;
//   // static double height15 = screenHeight! / 56.27;
//   // static double height20 = screenHeight! / 42.2;
//   // static double height30 = screenHeight! / 28.13;
//   // static double height40 = screenHeight! / 18.76;
//   // static double height45 = screenHeight! / 18.76;
//   // static double height60 = screenHeight! / 10.66;
//   // // static double height60 = 640 / 10.66;
//   // static double height70 = screenHeight! / 18.76;

//   // //! ===== dynamic width padding and margin ====
//   // static double width10 = screenHeight! / 84.4;
//   // static double width15 = screenHeight! / 56.27;
//   // static double width20 = screenHeight! / 42.2;
//   // static double width30 = screenHeight! / 28.13;
//   // static double width45 = screenHeight! / 18.76;

//   // //! ===== fonts ====
//   // static double font12 = screenHeight! / 70.33;
//   // static double font20 = screenHeight! / 42.2;

//   // //* I adjust them size
//   // // static double font12 = screenHeight / 52.75; // 16
//   // // static double font20 = screenHeight / 35.16; //24

//   // //! ===== radius ====
//   // static double radius15 = screenHeight! / 56.27;
//   // static double radius20 = screenHeight! / 42.2;
//   // static double radius30 = screenHeight! / 28.13;

//   // //! ===== icon size ====
//   // static double iconSize15 = screenHeight! / 42.66;
//   // static double iconSize24 = screenHeight! / 26.66;
//   // static double iconSize40 = screenHeight! / 16.0;
//   // static double iconSize60 = screenHeight! / 14.22;

//   // //! ===== List view size ====
//   // // static double listViewImgSize = screenwidth / 3.25;
//   // // static double listViewTextContSize = screenwidth / 3.9;

//   // //* or by height
//   // static double listViewImgSize = screenHeight! / 7.03;
//   // static double listViewTextContSize = screenHeight! / 8.44;
// }

// import 'package:flutter/material.dart';

// class AppMediaQuery {
//   static double height(BuildContext context) {
//     double height = MediaQuery.of(context).size.height;

//     return height;
//   }

//   static double width(BuildContext context) {
//     double width = MediaQuery.of(context).size.width;
//     return width;
//   }
// }
