import 'package:day1/utilities/routes.dart';
import 'package:day1/views/pages/landing_page.dart';
import 'package:flutter/cupertino.dart';

import '../views/pages/auth.dart';

/// we make function back Route by pass its settings as parameter
/// and inside it we use switch with settings.name to access
/// every variable from it for every case

Route<dynamic> onGenerate(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutes.loginPageRoute:
      return CupertinoPageRoute(
        builder: (_) => const AuthPage(),
        settings: settings,
      );
    case AppRoutes.landingPageRoute:
    default: // if there any problem
      return CupertinoPageRoute(
        builder: (_) => const LandingPage(),
      ); // not take any parameters so but it const
    // builder is function take return as _
  }
}
