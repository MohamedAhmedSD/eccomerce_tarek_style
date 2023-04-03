import 'package:day1/utilities/router.dart';
import 'package:day1/utilities/routes.dart';
import 'package:flutter/material.dart';

// we are on day 1
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
      theme: ThemeData(
        // color of most app
        scaffoldBackgroundColor: const Color(0xFFE5E5E5),
        // COLOR OF BUTTONS
        primaryColor: Colors.red,
        // primarySwatch: Colors.blue,
        // border themes
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: Theme.of(context).textTheme.labelSmall,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(2.0),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(2.0),
            borderSide: const BorderSide(color: Colors.grey),
          ),
        ),
      ),
      onGenerateRoute:
          onGenerate, // we not need any parameter here. we used that come from router
      // use one home or initialRoute,
      initialRoute: AppRoutes.loginPageRoute,
      // home: Container(),
    );
  }
}


/// we use MCV + services & utilities , don't forget use assets