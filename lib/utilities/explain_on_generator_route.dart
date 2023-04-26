//? https://dev.to/geekpius/how-to-use-on-generate-route-in-flutter-4kml

// ignore_for_file: slash_for_doc_comments

/**
 * On Generate Route
What the flutter team is saying is, instead of extracting the arguments 
directly inside the widget, you can also extract the arguments 
inside an onGenerateRoute() function and pass them to a widget.
Say our app always passes data to LocationScreen
I always to put my route in one file(route_generator.dart) 
so that it doesn't get mixed up and its a class. 
So we get the data from final args = settings.arguments; 
and pass it inside LocationScreen constructor. Refer to the image below
 */

/**
 * Setting Your Routes
So in the main.dart file I will call my initial route and set to the home screen 
using the name route not the name widget. I will also set my onGenerateRoute 
to the route method we created in our route class.
 */

/**
 * Using Your Route With Arguments
So now we can pass arguments to our target screen through our route. 
With the route below, the pushNamed takes two parameters: 
first, for our named route and second, for the data we want to pass to LocationScreen
 */

/**
 * Creating Constructor In LocationScreen
Create a constructor in the LocationScreen.
 Make it required if your screen/page is always going to get
  data which in this case it is.

 */

import 'package:day1/utilities/routes.dart';
import 'package:day1/views/pages/auth.dart';
import 'package:day1/views/pages/landing_page.dart';
import 'package:day1/views/pages/product_details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/database_controller.dart';

class OGR {
  //? static method
  static Route<dynamic> myOGR(RouteSettings settings) {
    //* =========== args ================================
    //? we need args from Product
    // final product = settings.arguments as Product;
    // final arg = settings.arguments as Product; //? == should use as =====

    //* =========== switch and route ================================
    switch (settings.name) {
      case ("/"): //? according to String value
        return MaterialPageRoute(
            builder: (context) => const LandingPage()); //* should back Widget
      case AppRoutes.loginPageRoute:
        //* we can use context or not => _
        return MaterialPageRoute(builder: (context) => const AuthPage());
      //? ===== pass single args =========================
      // case AppRoutes.productDetailsRoute:
      //   return MaterialPageRoute(
      //     builder: (context) => ProductDetails(
      //       product: arg,
      //     ),
      //   );
      //? ===== pass multi args as => Map or List ======================
      case AppRoutes.productDetailsRoute:
        //!!!!!!!!!!!!!!!!!!! [back here] !!!!!!!!!!!!!!!!!!!!!
        //* we need 3 ->
        //? we save data on args as Map
        final args = settings.arguments as Map<String, dynamic>;
        //? pass data into args => map[key] => args[keys]
        final product = args['product'];
        final database = args['database'];
        //? now I have map == args , with 2 keys product && database
        //?============================================
        return MaterialPageRoute(
          //! now builder nav us by Provider<>.value into DB controller
          //* Provider.value => require => value && child
          //? value => that data we need to get it from DB or FB and pass them into child
          //? child => is a widget recive data on its args that come from DB or FB
          builder: (_) => Provider<Database>.value(
            value: database,
            child: ProductDetails(product: product),
          ),
          settings: settings,
        );
      //* =========== default or return ================================
      //! [**] if we use default => no need use return out switch stmt
      default:
        // return MaterialPageRoute(builder: (_) => const LandingPage());
        return _errorRoute();
    }
    // return MaterialPageRoute(builder: (_) => const LandingPage());
    // return _errorRoute();
  }

  //* make method to back when there are error on route
  static Route<dynamic> _errorRoute() {
    /**
   * A value of type 'Null' can't be returned from the method 'onGenerateRoute' 
   * because it has a return type of 'Route<dynamic>'
   */

    //! [**] I forget start code block with => return
    return MaterialPageRoute(
      builder: (context) => Scaffold(
        appBar: AppBar(
          title: const Text("Error"),
        ),
        body: const Center(
          child: Text(",,,,"),
        ),
      ),
    );
  }
}
