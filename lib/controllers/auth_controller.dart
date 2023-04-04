import 'package:flutter/material.dart';
import '../services/auth.dart';
import '../utilities/enums.dart';

// we use provider with ChangeNotifier
// ChangeNotifier => mixins, make it easy use multible inheritence
class AuthController with ChangeNotifier {
  // what things I need control on them
  // also we need move busisnece logic

  final AuthBase auth;
  String email; // if final I can't change them
  String password;
  AuthFormType authFormType;

  AuthController({
    required this.auth,
    this.email = '', // default value or initilized a value
    this.password = '',
    this.authFormType = AuthFormType.login,
  });

  // methods
  // [5] submit => to login or register  through controller
  Future<void> submit() async {
    try {
      if (authFormType == AuthFormType.login) {
        // call login function
        await auth.loginWithEmailAndPassword(email, password);
      } else {
        // call register function
        await auth.signUpWithEmailAndPassword(email, password);
      }
      // handle error
    } catch (e) {
      rethrow;
    }
  }

  // [4] toggle == exchange
  void toggleFormType() {
    // it mean if your  AuthFormType == login chnge it into register and vers versa
    final formType = authFormType == AuthFormType.login
        ? AuthFormType.register
        : AuthFormType.login;
    // we need make notifylistener to it by using => copyWith
    copyWith(
      // we make our email & pw empty when use toggle
      // by give them => an empty String == ""
      email: '',
      password: '',
      authFormType: formType,
    );
  }

// we need controller talk to service
// [2] change my email by call copyWith to change that on controller
  void updateEmail(String email) => copyWith(email: email);
// [3] change my pw by call copyWith to change that on controller
  void updatePassword(String password) => copyWith(password: password);

// [1] update changes
// dart data class pkugin => ctrl + n => copy
// make it back void when I want only used inside our class
  void copyWith({
    // they may nullable
    String? email,
    String? password,
    AuthFormType? authFormType,
    // not take immutable == final  as auth above
  }) {
    // look to this logic
    // if you pass value get it, else used that inside controller
    this.email = email ?? this.email;
    this.password = password ?? this.password;
    this.authFormType = authFormType ?? this.authFormType;
    // need it to update our provider
    notifyListeners();
  }

  // [6] logout
  // call it from service to use by controller
  Future<void> logout() async {
    try {
      await auth.logout();
    } catch (e) {
      rethrow;
    }
  }
}
