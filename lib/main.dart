import 'package:day1/utilities/router.dart';
import 'package:day1/utilities/routes.dart';
import 'package:flutter/material.dart';

// we are on day 2
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ecommerce App',
      // deal with theme here is not better way
      theme: ThemeData(
        // color of most app
        scaffoldBackgroundColor: const Color(0xFFE5E5E5),
        // COLOR OF BUTTONS
        primaryColor: Colors.red,
        // primarySwatch: Colors.blue,
        // border themes:::::::::::::::::::::::::::::::::::::
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: Theme.of(context).textTheme.labelSmall,
          // to deal with all borders
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(2.0),
            borderSide: const BorderSide(
              color: Colors.grey,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(2.0),
            borderSide: const BorderSide(
              color: Colors.grey,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(2.0),
            borderSide: const BorderSide(
              color: Colors.grey,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(2.0),
            borderSide: const BorderSide(
              color: Colors.red,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(2.0),
            borderSide: const BorderSide(
              color: Colors.red,
            ),
          ),
        ),
      ),
      // routing :::::::::::::::::::::::::::::::::::::::::::::
      onGenerateRoute:

          /// {Route<dynamic>? Function(RouteSettings)? onGenerateRoute}
          /// Type: Route<dynamic>? Function(RouteSettings)?
          /// we deal with it on utilities, so we just call method that back our Route
          onGenerate, // we not need any parameter here. we used that come from router
      // use one home or initialRoute, here we better use initialRoute
      initialRoute: AppRoutes.loginPageRoute,
      // try land page
      // initialRoute: AppRoutes.landingPageRoute,
      // initialRoute: AppRoutes.registerPageRoute,
    );
  }
}


/// we use MCV + services & utilities , don't forget use assets