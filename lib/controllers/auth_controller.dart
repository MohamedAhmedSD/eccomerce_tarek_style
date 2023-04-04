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
  // submit
  Future<void> submit() async {
    try {
      if (authFormType == AuthFormType.login) {
        await auth.loginWithEmailAndPassword(email, password);
      } else {
        await auth.signUpWithEmailAndPassword(email, password);
      }
    } catch (e) {
      rethrow;
    }
  }

  void toggleFormType() {
    final formType = authFormType == AuthFormType.login
        ? AuthFormType.register
        : AuthFormType.login;
    copyWith(
      email: '',
      password: '',
      authFormType: formType,
    );
  }

  void updateEmail(String email) => copyWith(email: email);

  void updatePassword(String password) => copyWith(password: password);

// update changes
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

  Future<void> logout() async {
    try {
      await auth.logout();
    } catch (e) {
      rethrow;
    }
  }
}
