import 'package:provider/provider.dart';

import '../controllers/database_controller.dart';
import '../utilities/routes.dart';
import '../views/pages/landing_page.dart';
import '../views/pages/bottom_navbar.dart';

import 'package:flutter/cupertino.dart';

import '../views/pages/auth.dart';
import '../views/pages/product_details.dart';

//! read => https://dev.to/geekpius/how-to-use-on-generate-route-in-flutter-4kml

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

//! Routes vs onGR 

//? Difference
/**
 * routes is static and doesn't offer functionalities like passing an 
 * argument to the widget, implementing a different PageRoute etc,
 *  which is why onGenerateRoute exists.
 */

//?  onGR 
/**
 * The route generator callback used when the app is navigated to a named route.
If this returns null when building the routes to handle the specified initialRoute, 
then all the routes are discarded and Navigator.defaultRouteName
 is used instead (/). See initialRoute.
During normal app operation, the onGenerateRoute callback will only 
be applied to route names pushed by the application, and so should never return null.
This is used if routes does not contain the requested route.
The Navigator is only built if routes are provided 
(either via home, routes, onGenerateRoute, or onUnknownRoute); 
if they are not, builder must not be null.
 */

//? Routes
/**
 * The application's top-level routing table.
When a named route is pushed with Navigator.pushNamed, the route name
 is looked up in this map. If the name is present, the associated widgets.
 WidgetBuilder is used to construct a MaterialPageRoute that performs an 
 appropriate transition, including Hero animations, to the new route.
If the app only has one page, then you can specify it using home instead.
If home is specified, then it implies an entry in this table for the
 Navigator.defaultRouteName route (/), and it is an error to redundantly 
 provide such a route in the routes table.
If a route is requested that is not specified in this table (or by home),
 then the onGenerateRoute callback is called to build the page instead.
The Navigator is only built if routes are provided (either via home, 
routes, onGenerateRoute, or onUnknownRoute); if they are not,
 builder must not be null.
 */

 