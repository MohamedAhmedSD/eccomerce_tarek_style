import 'package:day1/services/auth.dart';
import 'package:day1/utilities/router.dart';
import 'package:day1/utilities/routes.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

//? we are on day 9
//! we can change package name with change_app_package_name
//https://console.firebase.google.com/
//? SHA => we write on our terminal =>
//* keytool -list -v -keystore C:\Users\Toshiba\.android\debug.keystore -storepass android -keypass android
// download json file <under android_app folder> and follow instructions
//? we can avoid error by use =>
//* 1. remove new or 2.FileNotFoundException
//? don't forget we use Future, due to deal with data
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    // name: "sheikh-eccomerce",
    //* a. options: DefaultFirebaseOptions.currentPlatform,
    options: DefaultFirebaseOptions.android,
//* c. options: const FirebaseOptions(
//   apiKey: "AIzaSyC_VV0-LqmJn7xpqzo8vTFzKs5E9u8hCtc",
//   appId: "app id here",
//   messagingSenderId: "messaging id",
//   projectId: "ecommerce-tarek",
// ), //? from where we get information above
//! another way, handle by certain device
// bool needsWeb = Platform.isLinux | Platform.isWindows;
// await Firebase.initializeApp(
//   options: needsWeb
//       ? DefaultFirebaseOptions.web
//       : DefaultFirebaseOptions.currentPlatform,
// );
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

//! when use Provider, we reach data without modify UI, not as CNP
  @override
  Widget build(BuildContext context) {
    //? wrap under provider <our services>
    //* how we call model Auth from its Abstract class
    return Provider<AuthBase>(
      //! abstract class
      create: (_) => Auth(), //! model implement from abstract
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Ecommerce App',
        //? deal with theme here is not better way
        theme: ThemeData(
          //* color of most app
          scaffoldBackgroundColor: const Color(0xFFE5E5E5),
          //* COLOR OF BUTTONS
          primaryColor: Colors.red,
          // primarySwatch: Colors.blue,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            elevation: 2,
            iconTheme: IconThemeData(color: Colors.black),
          ),
          //? border themes:::::::::::::::::::::::::::::::::::::
          inputDecorationTheme: InputDecorationTheme(
            labelStyle: Theme.of(context).textTheme.labelSmall,
            //* to deal with all borders
            //* all same prpberties and errors different on only them color
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
        //? routing :::::::::::::::::::::::::::::::::::::::::::::
        onGenerateRoute:

            ///* {Route<dynamic>? Function(RouteSettings)? onGenerateRoute}
            ///* Type: Route<dynamic>? Function(RouteSettings)?
            ///* we deal with it on utilities, so we just call method that back our Route
            onGenerate, //! we not need any parameter here. we used that come from router
        //* use only one home or initialRoute, here we better use initialRoute
        //! our app start from landingPage
        initialRoute: AppRoutes.landingPageRoute,
      ),
    );
  }
}

///* we use MCV + services & utilities , don't forget use assets
