import 'package:firebase_auth/firebase_auth.dart';

//! this service to talk with auth firebase
//? we use abstract class
//* when outer people access just by certain given name and not able to modify this function

abstract class AuthBase {
  //* User => model from firebase auth
  User? get currentUser;

  //? ========= Stream =====================
  ///* A source of asynchronous data events.
  /// A Stream provides a way to receive a sequence of events.
  /// Each event is either a data event, also called an element of the stream,
  ///  or an error event, which is a notification that something has failed.
  /// When a stream has emitted all its events, a single "done" event
  ///  notifies the listener that the end has been reached.

  Stream<User?> authStateChanges(); //! User?

  //* authStateChanges => method wait data may back on future
  //! or may back by null => User?
  //* authStateChanges => A source of asynchronous data events

  //? ========= Future<User?> && How access AuthController methods ===========
  ///* The result of an asynchronous computation.
  /// An asynchronous computation cannot provide a result immediately
  /// when it is started, unlike a synchronous computation which does
  /// compute a result immediately by either returning a value or by throwing.
  /// An asynchronous computation may need to wait for something
  ///  external to the program (reading a file, querying a database,
  /// fetching a web page) which takes time. Instead of blocking
  /// all computation until the result is available, the asynchronous
  /// computation immediately returns a Future which
  /// will eventually "complete" with the result.

  Future<User?> loginWithEmailAndPassword(String email, String password);

  Future<User?> signUpWithEmailAndPassword(String email, String password);

  Future<void> logout();
}

//? ================ concrate implements from abstract class ==============
class Auth implements AuthBase {
  //* we use it many time
  //* so better assign it to variable
  final _firebaseAuth = FirebaseAuth.instance;

  //?============ rewrite methods [async] ==============================
  //! we use function from controller ===================================

  //? =========== login =====================
  @override
  Future<User?> loginWithEmailAndPassword(String email, String password) async {
    final userAuth = await _firebaseAuth.signInWithEmailAndPassword(
        //* Attempts to sign in a user with the given email address and password.
        email: email,
        password: password);
    //* UserCredential userAuth
    return userAuth.user; //! User? get user
  }

  //? =========== sign up =====================

  @override
  Future<User?> signUpWithEmailAndPassword(
      String email, String password) async {
    final userAuth = await _firebaseAuth.createUserWithEmailAndPassword(
        //* Tries to create a new user account with the given email address and password.
        email: email,
        password: password);
    return userAuth.user;
  }

  //? =========== authState =====================

//! stream == back realtime data
//* make stream => to back current status of auth
// authStateChanges() => Stream<User?> Function()
  @override
  Stream<User?> authStateChanges() => _firebaseAuth.authStateChanges();
  //* Notifies about changes to the user's sign-in state (such as sign-in or sign-out).

//! back current user => not need parameters
  //? ============= get functions ============
  //? =========== user =====================

  @override
  User? get currentUser => _firebaseAuth
      .currentUser; //*Returns the current [User] if they are currently signed-in, or null if not.

  //? =========== logout =====================

  //* 2. logout
  @override
  Future<void> logout() async =>
      await _firebaseAuth.signOut(); //* Signs out the current user.
}
