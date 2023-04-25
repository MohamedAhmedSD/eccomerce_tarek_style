import 'package:provider/provider.dart';

import '../controllers/database_controller.dart';
import '../utilities/routes.dart';
import '../views/pages/landing_page.dart';
import '../views/pages/bottom_navbar.dart';

import 'package:flutter/cupertino.dart';

import '../views/pages/auth.dart';
import '../views/pages/product_details.dart';

///! we make function back Route <is abstract class> by pass its settings as parameter
///? and inside it we use switch with settings.name to access
///* every variable from it for every case

Route<dynamic> onGenerate(RouteSettings settings) {
  //* it used switch sentence
  //* according to settings.name we choose our route cases
  switch (settings.name) {
    //?:::::::: we make login and register on one as Auth
    case AppRoutes.loginPageRoute:
      //? we back CupertinoPageRoute, need both builder && settings
      //! if path not take parameters make it const
      //* don't forget send settings
      return CupertinoPageRoute(
        builder: (_) =>
            const AuthPage(), //! not take any parameters so but it const
        settings: settings,
      );
    case AppRoutes.bottomNavBarRoute:
      return CupertinoPageRoute(
        builder: (_) => const BottomNavbar(),
        settings: settings,
      );
    //?########################################################
    //! how we recive arrguments from navigation == constructor injection
    // case AppRoutes.productDetailsRoute:
    //* access to arrgs through seetings, and assign it with allile
    //*   final product = settings.arguments as Product;
    //   return CupertinoPageRoute(
    //! when we use builder, back our arrgs
    //     builder: (_) => ProductDetails(product: product),
    //     settings: settings,
    //   );
    //! to solve provider error with add to cart
    //?########################################################
    case AppRoutes.productDetailsRoute:
      //!!!!!!!!!!!!!!!!!!! [back here] !!!!!!!!!!!!!!!!!!!!!
      //* we need 3 ->
      final args = settings.arguments as Map<String, dynamic>;
      final product = args['product'];
      final database = args['database'];
      return CupertinoPageRoute(
        builder: (_) => Provider<Database>.value(
          value: database,
          child: ProductDetails(product: product),
        ),
        settings: settings,
      );
    //?########################################################
    case AppRoutes.landingPageRoute:

    //? handle it with default route to catch any errors
    default: //* if there any problem
      return CupertinoPageRoute(
        builder: (_) => const LandingPage(),
        settings: settings,
      );
  }
}
