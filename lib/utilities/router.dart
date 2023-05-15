import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/database_controller.dart';
import '../utilities/routes.dart';
import '../views/pages/checkout/add_shipping_address_page.dart';
import '../views/pages/checkout/checkout_page.dart';
import '../views/pages/checkout/shipping_addresses_page.dart';
import '../views/pages/landing_page.dart';
import '../views/pages/bottom_navbar.dart';

import '../views/pages/auth.dart';
import '../views/pages/product_details.dart';
import 'args_models/add_shipping_address_args.dart';

//! read => https://dev.to/geekpius/how-to-use-on-generate-route-in-flutter-4kml

///! we make function back Route <is abstract class> by pass its settings as parameter
///? and inside it we use switch with settings.name to access certain route name
///* for every case
///? it use CupertinoPageRoute, I changed them into MaterialPageRoute

Route<dynamic> onGenerate(RouteSettings settings) {
  //* it used switch sentence
  //* according to settings.name we choose our route cases
  switch (settings.name) {
    //?:::::::: we make login and register on one as Auth
    //?################[ loginPageRoute ]###################################

    case AppRoutes.loginPageRoute:
      //? we back MaterialPageRoute, need both builder && settings
      //! if path not take parameters make it const
      //* ====== don't forget send settings on end of route ==========
      return MaterialPageRoute(
        builder: (_) =>
            const AuthPage(), //! not take any parameters so but it const
        settings: settings,
      );
    case AppRoutes.bottomNavBarRoute:
      return MaterialPageRoute(
        builder: (_) => const BottomNavbar(),
        settings: settings,
      );
//?################[ checkoutPageRoute ]###################################
    case AppRoutes.checkoutPageRoute:
      //* pass Database, we use provider<>.value
      final database = settings.arguments as Database;
      return MaterialPageRoute(
        builder: (_) => Provider<Database>.value(
            value: database, child: const CheckoutPage()),
        settings: settings,
      );
    //?################[ productDetailsRoute 1 ]###################################
    //! how we recive arrguments from navigation == constructor injection
    // case AppRoutes.productDetailsRoute:
    //* access to arrgs through seetings, and assign it with allile
    //*   final product = settings.arguments as Product;
    //   return MaterialPageRoute(
    //! when we use builder, back our arrgs
    //     builder: (_) => ProductDetails(product: product),
    //     settings: settings,
    //   );
    //! to solve provider error with add to cart
    //?################[ productDetailsRoute 2 ]###################################
    case AppRoutes.productDetailsRoute:
      //!!!!!!!!!!!!!!!!!!! [back here] !!!!!!!!!!!!!!!!!!!!!
      //* we need 3 ->
      final args = settings.arguments as Map<String, dynamic>;
      final product = args['product'];
      final database = args['database'];
      return MaterialPageRoute(
        builder: (_) => Provider<Database>.value(
          value: database,
          child: ProductDetails(product: product),
        ),
        settings: settings,
      );
    //?################[ ShippingAddress && addShippingAddressRoute ]###################################

    case AppRoutes.shippingAddressesRoute:
      final database = settings.arguments as Database;
      return MaterialPageRoute(
        builder: (_) => Provider<Database>.value(
          value: database,
          child: const ShippingAddressesPage(),
        ),
        settings: settings,
      );
    case AppRoutes.addShippingAddressRoute:
      final args = settings.arguments as AddShippingAddressArgs;
      final database = args.database;
      final shippingAddress = args.shippingAddress;

      return MaterialPageRoute(
        builder: (_) => Provider<Database>.value(
          value: database,
          child: AddShippingAddressPage(
            shippingAddress: shippingAddress,
          ),
        ),
        settings: settings,
      );
    //?################[ landingPageRoute ]###################################
    case AppRoutes.landingPageRoute:

    //? handle it with default route to catch any errors
    default: //* if there any problem
      return MaterialPageRoute(
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

 