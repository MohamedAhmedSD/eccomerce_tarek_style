import 'package:firebase_auth/firebase_auth.dart';

// we use abstract class
// when outer access just by now name and not able to modify this function
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
    return userAuth.user; // User? get user
  }

  @override
  Future<User?> signUpWithEmailAndPassword(
      String email, String password) async {
    final userAuth = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    return userAuth.user;
  }

// stream == back realtime data
// make stream => to back current status of auth
// authStateChanges() => Stream<User?> Function()
  @override
  Stream<User?> authStateChanges() => _firebaseAuth.authStateChanges();

// back current user => not need parameters
  @override
  // User?
  User? get currentUser => _firebaseAuth.currentUser;
  // logout
  @override
  Future<void> logout() async => await _firebaseAuth.signOut();
}
