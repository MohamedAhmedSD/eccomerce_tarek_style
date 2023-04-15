import 'package:firebase_auth/firebase_auth.dart';

//! this service to talk auth firebase
//? we use abstract class
//* when outer prople access just by now name and not able to modify this function
abstract class AuthBase {
  // User => model from firebase auth
  User? get currentUser;

  Stream<User?> authStateChanges();

  // method wait data will back on future
  // may back by null => User?
  Future<User?> loginWithEmailAndPassword(String email, String password);

  Future<User?> signUpWithEmailAndPassword(String email, String password);

  Future<void> logout();
}

// concrate implements from abstract class
class Auth implements AuthBase {
  // we use it many time
  // so better assign it to variable
  final _firebaseAuth = FirebaseAuth.instance;

  // async
  @override
  Future<User?> loginWithEmailAndPassword(String email, String password) async {
    // UserCredential userAuth
    final userAuth = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    // UserCredential userAuth
    return userAuth.user; // User? get user
  }

  @override
  Future<User?> signUpWithEmailAndPassword(
      String email, String password) async {
    final userAuth = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    return userAuth.user;
  }

//! stream == back realtime data
// make stream => to back current status of auth
// authStateChanges() => Stream<User?> Function()
  @override
  Stream<User?> authStateChanges() => _firebaseAuth.authStateChanges();

//! back current user => not need parameters
//? get function
  @override
  //* 1. User?
  User? get currentUser => _firebaseAuth.currentUser;
  //* 2. logout
  @override
  Future<void> logout() async => await _firebaseAuth.signOut();
}
