import 'package:day1/controllers/database_controller.dart';
import 'package:day1/models/user_data.dart';
import 'package:day1/utilities/constants.dart';
import 'package:flutter/material.dart';
import '../services/auth.dart';
import '../utilities/enums.dart';

//* we use ChangeNotifier with our controller to access them && rebuild
//* ChangeNotifier => mixins, make it easy use multible inheritence classes

class AuthController with ChangeNotifier {
// class AuthController extends ChangeNotifier {

  //! use controller to :-
  //* 1. what things I need control on them
  //* 2. also we need move busisnece logic here

  //? ========= [A] variables of your Model =========================
  //* make an object from service => AuthBase
  final AuthBase auth;

  //! if variables was final, I can't change them from inner copyWith()
  String email;
  String password;
  AuthFormType authFormType;

  //! for test purpose && not good practise, set value FSDB == 123
  final Database database = FirestoreDatabase("123"); //? call from abstract

  //? our constructor, it start as empty fields on login page
  AuthController({
    required this.auth,
    this.email = '', //* default value or initilized a value
    this.password = '',
    this.authFormType = AuthFormType.login,
  });

  //? ========= [B] functions of your Model ==================================
  //? ========= copyWith && use it to update email & PW & AuthFormType =======

//* [1] update changes
//? dart data class plugin => ctrl + n => copy
//* make it back void when I want only used inside our class

  void copyWith({
    //! we need make notifylistener to it, rebuild by => copyWith
    //? change attributes inside current mode
    //* without building new object
    //! they may nullable

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
    //* so we use copyWith to build updateEmail & updatePassword methods
  }

//?======================================
//? we need controller talk to service ==
//?======================================

//*******************************************************************
//* so we use copyWith to build updateEmail & updatePassword methods
//*******************************************************************

//? we need both [2 + 3] to send our entry to firebase
//* [2] change my email only by call copyWith to change that on controller
  void updateEmail(String email) => copyWith(email: email);

//* [3] change my pw by call copyWith to change that on controller
  void updatePassword(String password) => copyWith(password: password);

//? ================== others ===================================
//* [4] toggle == exchange
  void toggleFormType() {
    //! it mean if your  AuthFormType == login change it into register and vers versa
    //? assign into formType value of authFormType, which equal on start login,
    //* save register on it.

    //! ==== try edit final, also not reset data on UI =========================
    final formType = authFormType == AuthFormType.login
        ? AuthFormType.register
        : AuthFormType.login;

    copyWith(
      //* we make our email & pw empty when use toggle
      //* by give them => an empty String == ""
      //! we can't but final attribute on it => final AuthBase auth;

      email: '',
      password: '',
      authFormType: formType,
    );
  }

  //* [5] submit => to login or register  through controller
  //! it look to email && password from [2 + 3] =============

  Future<void> submit() async {
    try {
      if (authFormType == AuthFormType.login) {
        //* call login function
        await auth.loginWithEmailAndPassword(email, password);
      } else {
        //* call register function
        final user = await auth.signUpWithEmailAndPassword(email, password);

        //? ====== FS ======================================
        //* ======= create collection on firestore =========
        //! when sign up we need set userdata on fire store
        //* we create collection on firestore
        // await database.setUserData(
        //     UserData(uid: documentIdFromLocalData(), email: email));

        //* ===== create collection on firestore + connect uid with cart ====
        //! we need connect uid with cart
        await database.setUserData(UserData(
          uid: user?.uid ?? documentIdFromLocalData(),
          email: email,
        ));
        //* we delete auth && users collection on firestore
        //? then restart app, if it have old data before we write full code
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
