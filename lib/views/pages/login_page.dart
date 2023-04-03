// stf
// we wrap inside SafeArea to avoid space of bar even appBar or bottom bar

import 'package:day1/views/widgets/main_button.dart';
import 'package:flutter/material.dart';

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
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Scaffold => SA => form => Col
      body: SafeArea(
          child: Padding(
        // to make space
        padding: const EdgeInsets.symmetric(vertical: 60.0, horizontal: 32.0),
        child: Form(
          // we wrap col in Form
          key: _formKey, // we need make a GlobalKey
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // try use them from material lib
              Text(
                "LOGIN",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(
                height: 100.0,
              ),
              TextFormField(
                // val => what I received
                validator: (val) =>
                    val!.isEmpty ? "Please enter your email" : null,
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: "Email",
                  hintText: "Enter your email",
                  // border: OutlineInputBorder(
                  //   borderRadius: BorderRadius.circular(8.0),
                  // ),
                ),
              ),
              const SizedBox(
                height: 24.0,
              ),
              TextFormField(
                validator: (val) =>
                    val!.isEmpty ? "Please enter your password" : null,
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: "Password",
                  hintText: "Enter your Password",
                  // border: OutlineInputBorder(
                  //   borderRadius: BorderRadius.circular(8.0),
                  // ),
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              Align(
                alignment: Alignment.topRight,
                child: InkWell(
                  child: const Text("Forget your password"),
                  onTap: () {},
                ),
              ),

              const SizedBox(
                height: 24.0,
              ),
              MainButton(text: "Login", onTap: () {}),
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
              // to take available space
              // it different interact according deal with Row or Column
              // we can use flex proberties to change default one == 1
              // here under Column
              const Spacer(),
              Align(
                alignment: Alignment.center,
                child: Text(
                  "Or Login with",
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
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.0),
                        color: Colors.white),
                    child: const Icon(Icons.add),
                  ),
                  const SizedBox(
                    width: 16.0,
                  ),
                  Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.0),
                        color: Colors.white),
                    child: const Icon(Icons.add),
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
