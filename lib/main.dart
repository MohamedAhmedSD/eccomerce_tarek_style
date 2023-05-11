import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'services/auth.dart';
import 'utilities/router.dart';
import 'utilities/routes.dart';
import 'utilities/theme.dart';

//? we are on day 9

//? ======== some general information ==========================
//* [change app name]
//! we can change package name with change_app_package_name
//* flutter pub run change_app_package_name:main com.new.package.name
//* com.shikh.Store => com.domain.app
//? flutter pub run change_app_package_name:main com.shikh.Store
//* when change it not affect firebase

//* [SHA]
//https://console.firebase.google.com/
//? SHA => we write on our terminal =>
//* keytool -list -v -keystore C:\Users\Toshiba\.android\debug.keystore -storepass android -keypass android
// download json file <under android_app folder> and follow instructions

//* [Gradle]
//? we can avoid error on build.gdarle by use =>
//* 1. remove new or 2.FileNotFoundException
//? don't forget we use Future, due to deal with data

//? =========== connect with FB ==================================================
//* [access Firebase]
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    // name: "sheikh-eccomerce",
    //* a. options: DefaultFirebaseOptions.currentPlatform,
    options: DefaultFirebaseOptions.android,
//* c. options: const FirebaseOptions(
//? from where we get these information => FB => project overview => project setteings => look at web
//   apiKey: "AIzaSyC_VV0-LqmJn7xpqzo8vTFzKs5E9u8hCtc",
//   appId: "app id here",
//   messagingSenderId: "messaging id",
//   projectId: "ecommerce-tarek",
// )

//! another way, handle by certain device, using bool with ? :
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

//? ============== wrap under Provider ==========================
//! when use Provider, we reach data without modify UI, not as CNP
  @override
  Widget build(BuildContext context) {
    //? wrap under provider <our services>
    //* how we call model Auth from its Abstract class == AuthBase
    return Provider<AuthBase>(
      create: (_) => Auth(), //! model implement from abstract
      //* we note that : T == Services & Model is controller
      //* so we use services with controller as logic and minumum use logic on view
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title:
            'Sheikh Alarab Store', //* it what apper on our browser or status bar

        //?============ themes ===========================================
        theme: AppTheme.appTheme,
        //! deal with theme here is not better way
        // theme: ThemeData(
        //   //* color of most app
        //   scaffoldBackgroundColor: AppColors.scaffoldBG,
        //   //* COLOR OF BUTTONS
        //   primaryColor: AppColors.primeryColor,
        //   // primarySwatch: Colors.blue,
        //   appBarTheme: const AppBarTheme(
        //     backgroundColor: AppColors.appBarTheme,
        //     elevation: 2,
        //     iconTheme: IconThemeData(color: AppColors.icontheme),
        //   ),
        //   //? border themes:::::::::::::::::::::::::::::::::::::
        //   //* group [A] ==== [grey] ==============================
        //   inputDecorationTheme: InputDecorationTheme(
        //     labelStyle: Theme.of(context).textTheme.labelSmall,
        //     //* to deal with all borders
        //     //* all same prpberties and errors different on only them color
        //     focusedBorder: OutlineInputBorder(
        //       borderRadius: BorderRadius.circular(2.0),
        //       borderSide: const BorderSide(
        //         color: Colors.grey,
        //       ),
        //     ),
        //     disabledBorder: OutlineInputBorder(
        //       borderRadius: BorderRadius.circular(2.0),
        //       borderSide: const BorderSide(
        //         color: Colors.grey,
        //       ),
        //     ),
        //     enabledBorder: OutlineInputBorder(
        //       borderRadius: BorderRadius.circular(2.0),
        //       borderSide: const BorderSide(
        //         color: Colors.grey,
        //       ),
        //     ),
        //     //* group [B] =======[red]==============================
        //     errorBorder: OutlineInputBorder(
        //       borderRadius: BorderRadius.circular(2.0),
        //       borderSide: const BorderSide(
        //         color: Colors.red,
        //       ),
        //     ),
        //     focusedErrorBorder: OutlineInputBorder(
        //       borderRadius: BorderRadius.circular(2.0),
        //       borderSide: const BorderSide(
        //         color: Colors.red,
        //       ),
        //     ),
        //   ),
        // ),
        //? ==== routing :::::::::::::::::::::::::::::::::::::::::::::
        onGenerateRoute: onGenerate, //! it is a method
        ///* {Route<dynamic>? Function(RouteSettings)? onGenerateRoute}
        ///* Type: Route<dynamic>? Function(RouteSettings)?
        ///? we deal with it on utilities, so we just call method that back our Route
        //* we not need any parameter here. we used that come from router
        //*! use only one home or initialRoute, here we better use initialRoute
        //* our app start from landingPage
        initialRoute: AppRoutes.landingPageRoute,
        // home: const LoginPage(),
      ),
    );
  }
}

///* we use MCV + services & utilities , don't forget use assets
