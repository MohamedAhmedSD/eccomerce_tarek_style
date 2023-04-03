import 'package:flutter/material.dart';

import '../../utilities/enums.dart';
import '../../utilities/routes.dart';
import '../widgets/main_button.dart';

// same to login put we use our enum
class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  // enum
  // choose our login status when start
  var _authType = AuthFormType.login;
  // to go to next TFF when press on its button
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  // use dispose to close controller after finsh from them
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // use MQ
    final size = MediaQuery.of(context).size;

    return Scaffold(
      // try to avoid KB problem, when keyboard open on phone
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 60.0,
            horizontal: 32.0,
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
                    _authType == AuthFormType.login ? 'Login' : 'Register',
                    // style: Theme.of(context).textTheme.headline4,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 80.0),
                  TextFormField(
                    controller: _emailController,
                    // to use it later
                    focusNode: _emailFocusNode,
                    // when end use TFF
                    onEditingComplete: () =>
                        // as navigator
                        // how we go from on node to another
                        FocusScope.of(context).requestFocus(_passwordFocusNode),
                    // to change Done on KB into other word
                    textInputAction: TextInputAction.next,
                    //:::::::::::::::::::::::
                    // add simple validator to ensure field is n't empty
                    // we need add proberty to accept enter to confirm field
                    // and go to next one ::::::::::::::::::::::::::::::::::
                    validator: (val) =>
                        val!.isEmpty ? 'Please enter your email!' : null,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      hintText: 'Enter your email!',
                    ),
                  ),
                  const SizedBox(height: 24.0),
                  TextFormField(
                    controller: _passwordController,
                    focusNode: _passwordFocusNode,
                    // not add => onEditingComplete, textInputAction
                    validator: (val) =>
                        val!.isEmpty ? 'Please enter your password!' : null,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      hintText: 'Enter your pasword!',
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  // if we on login page appear to user certain text
                  // Forgot your password?
                  if (_authType == AuthFormType.login)
                    Align(
                      alignment: Alignment.topRight,
                      child: InkWell(
                        child: const Text('Forgot your password?'),
                        onTap: () {},
                      ),
                    ),
                  const SizedBox(height: 24.0),
                  // also here about what written on button
                  MainButton(
                    text: _authType == AuthFormType.login
                        ? 'Login'
                        : 'Register', // login or register
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        // how we navigate
                        // read about inherited statements
                        Navigator.of(context)
                            .pushNamed(AppRoutes.bottomNavBarRoute);
                      }
                    },
                  ),
                  const SizedBox(height: 16.0),
                  Align(
                    alignment: Alignment.center,
                    // also additional text
                    child: InkWell(
                      child: Text(
                        _authType == AuthFormType.login
                            ? 'Don\'t have an account? Register' // login
                            : 'Have an account? Login', // register
                      ),
                      onTap: () {
                        // inside setState
                        //
                        setState(() {
                          //
                          _formKey.currentState!.reset();
                          //
                          if (_authType == AuthFormType.login) {
                            _authType = AuthFormType.register;
                          } else {
                            // opposite
                            _authType = AuthFormType.login;
                          }
                        });
                      },
                    ),
                  ),
                  // const Spacer(),
                  // we use MQ instead of spacer, less problems
                  SizedBox(height: size.height * 0.09),
                  Align(
                      alignment: Alignment.center,
                      child: Text(
                        _authType == AuthFormType.login
                            ? 'Or Login with'
                            : 'Or Register with',
                        // style: Theme.of(context).textTheme.subtitle1,
                        style: Theme.of(context).textTheme.labelSmall,
                      )),
                  const SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.0),
                          color: Colors.white,
                        ),
                        child: const Icon(Icons.add),
                      ),
                      const SizedBox(width: 16.0),
                      Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.0),
                          color: Colors.white,
                        ),
                        child: const Icon(Icons.add),
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
  }
}
