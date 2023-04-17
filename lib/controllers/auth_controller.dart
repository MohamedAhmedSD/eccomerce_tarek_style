import 'package:day1/controllers/database_controller.dart';
import 'package:day1/models/user_data.dart';
import 'package:day1/utilities/constants.dart';
import 'package:flutter/material.dart';
import '../services/auth.dart';
import '../utilities/enums.dart';

// we use provider with ChangeNotifier
// ChangeNotifier => mixins, make it easy use multible inheritence
class AuthController with ChangeNotifier {
  // what things I need control on them
  // also we need move busisnece logic

  final AuthBase auth;
  String email; //! if final I can't change them from inner copyWith()
  String password;
  AuthFormType authFormType;
  //! for test purpose && not good practise
  final Database database = FirestoreDatabase("123"); // call from abstract

  AuthController({
    required this.auth,
    this.email = '', // default value or initilized a value
    this.password = '',
    this.authFormType = AuthFormType.login,
  });

//* [1] update changes
// dart data class pkugin => ctrl + n => copy
// make it back void when I want only used inside our class
  void copyWith({
    //! we need make notifylistener to it by using => copyWith
    //? change attributes inside current mode
    //* without building new object
    // they may nullable
    String? email,
    String? password,
    AuthFormType? authFormType,
    // not take immutable == final  as auth above
  }) {
    //? look to this logic
    //* if you pass value get it, else used that inside controller
    //! if you use new value use it if not use that on model
    //* we need by this to minium use of controller
    this.email = email ?? this.email;
    this.password = password ?? this.password;
    this.authFormType = authFormType ?? this.authFormType;
    //! need it to update our provider
    notifyListeners();
  }

// we need controller talk to service
//* [2] change my email only by call copyWith to change that on controller
  void updateEmail(String email) => copyWith(email: email);
//* [3] change my pw by call copyWith to change that on controller
  void updatePassword(String password) => copyWith(password: password);

  //* [4] toggle == exchange
  void toggleFormType() {
    //! it mean if your  AuthFormType == login change it into register and vers versa
    //? assign into formType value of authFormType, which equal on start login,
    //* save register on it.
    final formType = authFormType == AuthFormType.login
        ? AuthFormType.register
        : AuthFormType.login;

    copyWith(
      //! we make our email & pw empty when use toggle
      // by give them => an empty String == ""
      // we can't but final attribute on it => final AuthBase auth;

      email: '',
      password: '',
      authFormType: formType,
    );
  }

  // methods
  //* [5] submit => to login or register  through controller
  Future<void> submit() async {
    try {
      if (authFormType == AuthFormType.login) {
        // call login function
        await auth.loginWithEmailAndPassword(email, password);
      } else {
        // call register function
        final user = await auth.signUpWithEmailAndPassword(email, password);
        //! when sign up we need set userdata on fire store
        //* we create collection on firestore
        // await database.setUserData(
        //     UserData(uid: documentIdFromLocalData(), email: email));
        //! we need connect uid with cart
        await database.setUserData(UserData(
          uid: user?.uid ?? documentIdFromLocalData(),
          email: email,
        ));
        //! we delete auth && users collection on firestore
        //? then restart app
      }
      // handle error
    } catch (e) {
      rethrow;
    }
  }

  //* [6] logout
  // call it from service to use by controller
  Future<void> logout() async {
    try {
      await auth.logout();
    } catch (e) {
      rethrow;
    }
  }
}
