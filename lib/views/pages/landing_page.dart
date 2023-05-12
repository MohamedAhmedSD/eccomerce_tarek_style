import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/database_controller.dart';
import '../../services/auth.dart';
import 'auth.dart';
import 'bottom_navbar.dart';

//? =============== [deal with Stream] ===============
//? we make intermediated page to deal with user data to
//* know is it authenticated or not
//* and its session is open or terminated

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //? ============ Provider ====================
    //? auth reference
    //! our provider here not need listen all time just rech to data, not update UI

    final auth = Provider.of<AuthBase>(context, listen: false);

    //? ============ auth state => Streamuilder ====================
    //* access stream => StreamBuilder, back User from FireBase auth
    //? authStateChanges => from our abstract class

    //* Creates a new [StreamBuilder] that builds itself based on the
    //? latest snapshot of interaction with the specified [stream] and
    //* whose build strategy is given by [builder].

    return StreamBuilder<User?>(
      //!call stateChanges == Stream of Users
      stream: auth.authStateChanges(),
      builder: (context, snapshot) {
        //* snapshot == access stream data through it

        if (snapshot.connectionState == ConnectionState.active) {
          //* active => bring data ,
          //* other status as => end , waiting, done ...

          //? access data from snapshot == snapshot.data == User
          //* get The latest data received by the asynchronous computation.
          final user = snapshot.data;

          //! [1] no user auth => nav to auth page
          //!================================================================
          if (user == null) {
            //* need to create a user so Nav them to register

            //! use CNP on if block to wrap AuthPage with AuthController model
            //* so it can start used data by just call Consumer on certain widget
            //* with no need to write Provider.of(context) on that page

            //? go into auth page with ability to access AuthController page
            return ChangeNotifierProvider<AuthController>(
              create: (_) => AuthController(auth: auth),
              child: const AuthPage(),
            );
          }

          //! [2] user not null => nav into BottomNavbar => homePage screen
          //!================================================================

          //* by wrap them with CNP with AuthController model go to homePage
          //? homepage == BottomNavbar
          //! but here we need to pass user id to used later on others page

          return ChangeNotifierProvider<AuthController>(
            create: (_) => AuthController(auth: auth),

            //? ========= pass UID to another page ===================
            //! we need wrap BottomNavbar with => provider to reach db controller
            child: Provider<Database>(
                create: (_) =>

                    //? ===== call function that make UID on it ===============
                    FirestoreDatabase(user.uid), //? snapshot.data.uid
                child: const BottomNavbar()),
          );
        }

        //! ================= [**] if loading till now ===========================
        //* We will refactor this to make one component for loading
        //! ======== use package here to change it ======================
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
