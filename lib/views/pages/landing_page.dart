import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/auth_controller.dart';
import '../../services/auth.dart';
import 'auth.dart';
import 'bottom_navbar.dart';

// we make intermediated page to deal with user data to
// know is it authenticated or not
class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // our provider here not need listen all time
    final auth = Provider.of<AuthBase>(context, listen: false);
    // access stream => StreamBuilder, back User from FireBase auth
    return StreamBuilder<User?>(
      stream: auth.authStateChanges(), //call stateChanges
      builder: (context, snapshot) {
        // snapshot == access stream data through it
        if (snapshot.connectionState == ConnectionState.active) {
          // active => brimg data and end , waiting, done ...

          // access data from snapshot
          final user = snapshot.data;
          if (user == null) {
            // no user auth => nav to auth page
            return ChangeNotifierProvider<AuthController>(
              create: (_) => AuthController(auth: auth),
              child: const AuthPage(),
            );
          }
          // user not null => accesss homePage
          return ChangeNotifierProvider<AuthController>(
            create: (_) => AuthController(auth: auth),
            child: const BottomNavbar(),
          );
        }
        // We will refactor this to make one component for loading
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
