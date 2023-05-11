import 'package:day1/controllers/auth_controller.dart';
import 'package:day1/views/widgets/main_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utilities/assets.dart';
import '../../utilities/enums.dart';
import '../../utilities/routes.dart';
import '../widgets/main_button.dart';
import '../widgets/social_media_button.dart';

//? same to login page => put we use our enum to use one page for both =>
//* Login && register

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  //? ============ formKey & TEC =====================
  //* we use global key form state later to check if fields are valid
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  //? ============focusNode =====================
  //! to go to next TFF(focusNode) when press (enter) on TFF
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  //![1] >>>>>>>>>>>> dose btn take FocusNode or recive FN from TFF >>>>>>>>>>>>
  //?=========================================================
  //* by using onFieldSubmitted with unfocus for both email && password
  //* we connect btn method with password onFieldSubmitted after finish to
  //* call that method
  //?=============== validate functions ================
  //! [ use function to back bool not simple trur or false]
  // Define a boolean flag to keep track of password validity
  bool _isPasswordValid = false;
  bool _isEmailValid = false;

  // Define a boolean flag to indicate password visibility
  bool _isPasswordVisible = false;
  // Method to validate password based on certain criteria
  void _validatePassword() {
    // Check if password is at least 8 characters long
    // and contains at least one uppercase, lowercase, and numeric character
    // RegExp regex = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$');
    // RegExp regex = RegExp(r'^(?=.*?[a-z])(?=.*?[0-9]).{8,}$');
    RegExp regex = RegExp(r'^(?=.*?[a-zA-Z])(?=.*?[0-9]).{8,}$');
    bool isValid = regex.hasMatch(_passwordController.text);
    setState(() {
      _isPasswordValid = isValid;
    });
  }

  // read about regular expression
  // Method to validate password based on certain criteria
  void _validateEmail() {
    // Check if password is at least 8 characters long
    // and contains at least one uppercase, lowercase, and numeric character
    // RegExp regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    // RegExp regex = RegExp(r'^(?=.*?[.])(?=.*?[a-z])(?=.*?[@]).{8,}$');
    // use any lower case our upper case letters => [a-zA-Z]
    RegExp regex = RegExp(r'^(?=.*?[.])(?=.*?[a-zA-Z])(?=.*?[@]).{8,}$');
    bool isValid = regex.hasMatch(_emailController.text);
    setState(() {
      _isEmailValid = isValid;
    });
  }

  // Method to toggle password visibility
  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  //? ============ init & dispose TEC =====================
  @override
  void initState() {
    _passwordController.addListener(_validatePassword);
    _emailController.addListener(_validateEmail);
    super.initState();
  }

  //* use dispose to close controller after finish from them
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    //?======================
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  //? ============ reset & submit =====================
  void clearTFF() {
    _emailController.clear();
    _passwordController.clear();
  }

  void clearTFFSecondWay() {
    _emailController.text = "";
    _passwordController.text = "";
  }

  Future<void> _submit(AuthController model) async {
    try {
      clearTFF(); //! I add it to clear fields after submit
      await model.submit();

      //* if we need nav to page we need mount them first
      //* to avoid context problem with build

      if (!mounted) return;
      Navigator.of(context).pushNamed(AppRoutes.landingPageRoute);
      //? on it we deal with date to make our choice
    }
    //! I use catched error as my content
    catch (e) {
      MainDialog(
        context: context,
        title: 'Error',
        // content: e.toString(),
        content: "Please Re Enter a Correct Data ",
      ).showAlertDialog();
    }
  }

  //? ============ UI =====================
  @override
  Widget build(BuildContext context) {
    //* use MQ is difficult on big apps
    //* May use dimensions class that you make with get.
    //![2] >>>>>>>>>> how we make dimensions by provider >>>>>>>>>>>>

    final size = MediaQuery.of(context).size;
    //! access to our provider
    //? ask parents on widget tree , till find generic class, then assign it to variable => auth
    // final auth = Provider.of<AuthBase>(context);  //? it able edit UI
    //* on main page we assign Provider to Material root so we able to Use => Consumer here
    //! base of tree
    //? where we apply it by consumer
    //* required Widget Function(BuildContext, AuthController, Widget?) builder,

    //? ============ Consumer & form =====================
    return Consumer<AuthController>(builder: (_, model, __) {
      // consumer return widget to listen changes on it
      return Scaffold(
        //! try to avoid KB problem, when keyboard open on phone
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              // vertical: 60.0,
              // horizontal: 32.0,
              vertical: 32.0,
              horizontal: 16.0,
            ),
            child: Form(
              key: _formKey,
              // we make our column content scrollable by SingleChildScrollView
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // we make condition to choose our login status
                    Text(
                      // use from model not from local variable
                      model.authFormType == AuthFormType.login
                          ? 'Login'
                          : 'Register',
                      // style: Theme.of(context).textTheme.headlineMedium,
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          //! == [we use .copyWith to change them style]
                          .copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 32),
                    ),
                    // const SizedBox(height: 80.0),
                    const SizedBox(height: 50.0),
                    //? ============ email =====================
                    TextFormField(
                      controller: _emailController,
                      obscureText: false,
                      //* to use it later
                      focusNode: _emailFocusNode,
                      onFieldSubmitted: (_) {
                        _emailFocusNode.unfocus();
                        FocusScope.of(context).requestFocus(_passwordFocusNode);
                      },
                      //* when end use TFF

                      onEditingComplete: () =>
                          //? as navigator
                          // how we go from one node to another
                          // our current node request another focuse
                          FocusScope.of(context)
                              .requestFocus(_passwordFocusNode),
                      //* to change Done on KB into other word as next
                      textInputAction: TextInputAction.next,
                      //:::::::::::::::::::::::
                      // add simple validator to ensure field is n't empty
                      // we need add proberty to accept enter to confirm field
                      // and go to next one ::::::::::::::::::::::::::::::::::
                      // validator: (val) =>
                      //     val!.isEmpty ? 'Please enter your email!' : null,

                      // validator: (value) {
                      //   if (value!.isNotEmpty && value.length > 7) {
                      //     return null;
                      //   } else {
                      //     return 'Please enter your email!, It should be more than 7';
                      //   }
                      // },
                      // //:::::::::::::::::::::::::: use on changed
                      // // it give us update to happen
                      // // access method => model == AuthController model
                      // onChanged: model.updateEmail,
                      //* val => what I received
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter an Email address';
                        } else if (!_isEmailValid) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                      onChanged: (_) => _formKey.currentState!.validate(),
                      decoration: const InputDecoration(
                        labelText: "Email",
                        hintText: "Enter your email",
                        //! ======[ how fix label text inside TFF ]============
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                      ),
                    ),
                    const SizedBox(height: 24.0),
                    //? ============ pw =====================
                    TextFormField(
                      obscureText: !_isPasswordVisible,
                      controller: _passwordController,
                      focusNode: _passwordFocusNode,
                      onFieldSubmitted: (_) {
                        _passwordFocusNode.unfocus();
                        // _loginPressed(); == _submit();
                        _submit(model);
                      },
                      //! not add => onEditingComplete, textInputAction
                      // validator: (val) =>
                      //     val!.isEmpty ? 'Please enter your password!' : null,

                      // validator: (value) {
                      //   if (value!.isNotEmpty && value.length > 7) {
                      //     return null;
                      //   } else {
                      //     return 'Passwordshould be more than 7';
                      //   }
                      // },
                      // // on changed
                      // onChanged: model.updatePassword,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a password';
                        } else if (!_isPasswordValid) {
                          return 'Please enter a valid password';
                        }
                        return null;
                      },
                      onChanged: (_) => _formKey.currentState!.validate(),

                      // decoration: const InputDecoration(
                      //   labelText: 'Password',
                      //   hintText: 'Enter your pasword!',
                      // ),
                      decoration: InputDecoration(
                        labelText: 'Password',
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordVisible
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: _togglePasswordVisibility,
                        ),
                        suffix: SizedBox(
                          width: 24.0,
                          height: 24.0,
                          child: _isPasswordValid
                              ? const Icon(
                                  Icons.check,
                                  color: Colors.green,
                                )
                              : null,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    //* if we on login page appear to user certain text
                    // Forgot your password?
                    // if (_authType == AuthFormType.login)
                    // use from model not from local variable
                    //? ============ forget pw =====================
                    if (model.authFormType == AuthFormType.login)
                      Align(
                        alignment: Alignment.topRight,
                        child: InkWell(
                          child: const Text('Forgot your password?'),
                          onTap: () {
                            //! not add yet
                          },
                        ),
                      ),
                    const SizedBox(height: 24.0),
                    // also here about what written on button
                    //? ============ login or register  =====================
                    MainButton(
                      hasCircularBorder: true,
                      // text: _authType == AuthFormType.login
                      text: model.authFormType == AuthFormType.login
                          ? 'Login'
                          : 'Register', // login or register
                      onTap: () {
                        // we go to bottomNav if user enter valid data
                        // we write condition => by using formkey && its state
                        if (_formKey.currentState!.validate()) {
                          //* test our model work or not
                          //! if work our controller it done
                          //? we make this to make our controller use services
                          //* and auth page only call function => submit()
                          if (kDebugMode) {
                            print("email: ${model.email}");
                          }
                          if (kDebugMode) {
                            print("password: ${model.password}");
                          }

                          //! use model by this way not login
                          //? difference between submit && _submit

                          // model.submit();

                          //* we call function from above this page
                          //! and pass model as its parameter

                          //? ============ submit =====================
                          _submit(model);

                          // how we navigate
                          //! [1] not good way
                          // read about inherited statements
                          //? Navigator.of(context)
                          //     .pushNamed(AppRoutes.bottomNavBarRoute);
                          //! we need connect our auth with firestore
                        }
                      },
                    ),
                    const SizedBox(height: 16.0),
                    //? ============ toggle =====================
                    Align(
                      alignment: Alignment.center,
                      // also additional text
                      child: InkWell(
                        child: Text(
                          // _authType == AuthFormType.login
                          model.authFormType == AuthFormType.login
                              ? 'Don\'t have an account? Register' // login
                              : 'Have an account? Login', // register
                        ),
                        onTap: () {
                          //* every time you press on this text
                          // your all date inside form will be deleted
                          // then go to opposite [login or register]

                          //! by using key not work

                          //* [A] it work
                          clearTFF();
                          //* [B] it work
                          // clearTFFSecondWay();

                          //*::::::::: toggle == exchange ::::::::::::

                          //! just call our toggle
                          model.toggleFormType();
                        },
                      ),
                    ),
                    // const Spacer(),
                    //* we use MQ instead of spacer, less problems
                    SizedBox(height: size.height * 0.09),
                    Align(
                        alignment: Alignment.center,
                        child: Text(
                          // _authType == AuthFormType.login
                          model.authFormType == AuthFormType.login
                              ? 'Or Login with'
                              : 'Or Register with',
                          // style: Theme.of(context).textTheme.subtitle1,
                          style: Theme.of(context).textTheme.labelSmall,
                        )),
                    const SizedBox(height: 16.0),
                    //? ============ docial icons =====================
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SocialMediaButton(
                          iconName: AppAssets.facebookIcon,
                          onPress: () {},
                        ),
                        const SizedBox(width: 16.0),
                        SocialMediaButton(
                          iconName: AppAssets.googleIcon,
                          onPress: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
