// stf
// we wrap inside SafeArea to avoid space of bar even appBar or bottom bar

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../utilities/assets.dart';
import '../widgets/main_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // to reach by key for your certain form
  // it deal with => FormState
  final _formKey = GlobalKey<FormState>();
  // make controllers for fill TFF by user data
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  //! [ use function to back bool not simple trur or false]
  // Define a boolean flag to keep track of password validity
  bool _isPasswordValid = false;
  bool _isEmailValid = false;

  // Define a boolean flag to indicate password visibility
  bool _isPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(_validatePassword);
    _emailController.addListener(_validateEmail);
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  // Method to validate password based on certain criteria
  void _validatePassword() {
    // Check if password is at least 8 characters long
    // and contains at least one uppercase, lowercase, and numeric character
    // RegExp regex = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$');
    RegExp regex = RegExp(r'^(?=.*?[a-z])(?=.*?[0-9]).{8,}$');
    bool isValid = regex.hasMatch(_passwordController.text);
    setState(() {
      _isPasswordValid = isValid;
    });
  }

  // Method to validate password based on certain criteria
  void _validateEmail() {
    // Check if password is at least 8 characters long
    // and contains at least one uppercase, lowercase, and numeric character
    // RegExp regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    RegExp regex = RegExp(r'^(?=.*?[.])(?=.*?[a-z])(?=.*?[@]).{8,}$');
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //! is it SA => Scafold?
      //? Scaffold => SA => form => Col
      //* why we use SafeArea ?? to make space from status bar for widget under it
      body: SafeArea(
          child: Padding(
        //! to make padding for our column we wrap it with Pdding??
        //* children take its parent settings
        // padding: const EdgeInsets.symmetric(vertical: 60.0, horizontal: 32.0),
        padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 16.0),
        child: Form(
          //* we wrap column under Form then
          //? we need make a GlobalKey from FormState to be able used our TFF
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // try use them from material lib
              Text(
                "Login",
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium!
                    //! == [we use .copyWith to change them style]
                    .copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 32),
              ),
              const SizedBox(
                // height: 100.0,
                height: 50.0,
              ),
              //? ========== [ email ] ====================
              SizedBox(
                height: 70,
                child: TextFormField(
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
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: "Email",
                    hintText: "Enter your email",
                    //! ======[ how fix label text inside TFF ]============
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                  ),
                ),
              ),
              const SizedBox(
                // height: 24.0,
                height: 12.0,
              ),
              //? ========== [ password ] ====================

              SizedBox(
                height: 70,
                child: TextFormField(
                  controller: _passwordController,
                  obscureText: !_isPasswordVisible,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a password';
                    } else if (!_isPasswordValid) {
                      return 'Please enter a valid password';
                    }
                    return null;
                  },
                  onChanged: (_) => _formKey.currentState!.validate(),
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
              ),
              const SizedBox(
                height: 16.0,
              ),
              //? ========== [ Forget your password ] ====================
              Align(
                //* we change it if arabic to => topLeft
                alignment: Alignment.topRight,
                child: InkWell(
                  child: const Text("Forget your password"),
                  onTap: () {},
                ),
              ),

              const SizedBox(
                height: 24.0,
              ),
              MainButton(
                text: "Login",
                onTap: () {},
                hasCircularBorder: true,
              ),
              const SizedBox(
                height: 16.0,
              ),

              Align(
                alignment: Alignment.center,
                child: InkWell(
                  child: const Text("Don't have an account? Register"),
                  onTap: () {},
                ),
              ),
              //! to take all available space
              // it different interact according deal with Row or Column
              // we can use flex proberties to change default one == 1
              // here under Column
              const Spacer(),
              Align(
                alignment: Alignment.center,
                child: Text(
                  "Or Login with social account",
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              // to buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.0),
                        color: Colors.white),
                    // child: const Icon(Icons.add),
                    child: Center(
                      child: SvgPicture.asset(
                        AppAssets.googleIcon,
                        height: 40,
                        width: 40,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 16.0,
                  ),
                  Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.0),
                        color: Colors.white),
                    // child: const Icon(Icons.add),
                    child: Center(
                      child: SvgPicture.asset(
                        AppAssets.facebookIcon,
                        height: 40,
                        width: 40,
                      ),
                    ),
                  ),
                ],
              )
              // take all possible space y spacer
            ],
          ),
        ),
      )),
    );
  }
}
