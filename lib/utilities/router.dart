import '../utilities/routes.dart';
import '../views/pages/landing_page.dart';
import '../views/pages/login_page.dart';
import '../views/pages/bottom_navbar.dart';
import '../views/pages/home_page.dart';

import 'package:flutter/cupertino.dart';

import '../views/pages/auth.dart';

/// we make function back Route <is abstract class> by pass its settings as parameter
/// and inside it we use switch with settings.name to access
/// every variable from it for every case

Route<dynamic> onGenerate(RouteSettings settings) {
  // it used switch sentence
  // according to settings.name we choose our route cases
  switch (settings.name) {
    //:::::::: we make login and register on one as Auth
    case AppRoutes.loginPageRoute: // in this case
      return CupertinoPageRoute(
        // we back CupertinoPageRoute, need both
        builder: (_) => const LoginPage(), // builder without context_
        settings: settings, // and sette]ings
      );

    // if path not take parameters make it const
    // don't forget send settings
    // case AppRoutes.loginPageRoute: // in this case
    //   return CupertinoPageRoute(
    //     // we back CupertinoPageRoute, need both
    //     builder: (_) => const LoginPage(), // builder without context_
    //     settings: settings, // and sette]ings
    //   );
    case AppRoutes.landingPageRoute:
      return CupertinoPageRoute(
          builder: (_) => const LandingPage(), settings: settings);
    // case AppRoutes.registerPageRoute: // in this case
    //   return CupertinoPageRoute(
    //     // we back CupertinoPageRoute, need both
    //     builder: (_) => const AuthPage(), // builder without context_
    //     settings: settings, // and sette]ings
    //   );

    //::::::::::::::::
    case AppRoutes.homePageRoute:
      return CupertinoPageRoute(
          builder: (_) => const HomePage(), settings: settings);
    case AppRoutes.bottomNavBarRoute:
      return CupertinoPageRoute(
        builder: (_) => const BottomNavbar(),
        settings: settings,
      );

    // handle it with default route to catch any errors
    default: // if there any problem
      // not pass any settings
      return CupertinoPageRoute(
        builder: (_) => const LandingPage(),
      ); // not take any parameters so but it const
    // builder is function take return as _
  }
}
