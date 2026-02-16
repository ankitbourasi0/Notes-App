/*
LOGIN PAGE UI

On this page, a user can login with their:
- email
- password
-------------------------------------------------------------------

Once a user successfully logs in they will be directed to home page

If user doesn't have an account , they can go to register page to create one.
*/

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app_sync/features/auth/presentation/components/my_button.dart';
import 'package:notes_app_sync/features/auth/presentation/components/my_textfield.dart';
import 'package:notes_app_sync/features/auth/presentation/cubits/auth_cubits.dart';

class LoginPage extends StatefulWidget {
  final void Function()? togglePage;

  const LoginPage({super.key, required this.togglePage});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  //login button
  void login() {
    //prepare email and password
    final String email = emailController.text;
    final String password = passwordController.text;

    //auth cubit
    final authcubit = context.read<AuthCubit>();

    //ensure all fields are filled
    if (email.isNotEmpty && password.isNotEmpty) {
      if (email.contains("@")) {
        //login
         authcubit.login(email, password);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Enter a valid email address")));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please enter both email & password.")));
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //Scaffold
    return Scaffold(
      //APP BAR
      appBar: AppBar(
        title: const Text("Login"),
      ),
      //BODY
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //Icon
              Icon(
                Icons.water_outlined,
                size: 80,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
              //Name
              const SizedBox(
                height: 25,
              ),

              Text(
                "R E F I N E   J O U R N A L",
                style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.inversePrimary),
              ),
              const SizedBox(
                height: 25,
              ),
              //Email Text Field

              MyTextfield(
                  controller: emailController,
                  hintText: "Email",
                  obscureText: false),
              const SizedBox(
                height: 10,
              ),

              //Password Text Field
              MyTextfield(
                  controller: passwordController,
                  hintText: "Password",
                  obscureText: true),

              const SizedBox(
                height: 10,
              ),

              //Forget password
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Forget Password?",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),

              const SizedBox(
                height: 10,
              ),
              //Login Button
              MyButton(onTap: login, text: 'LOGIN'),
              const SizedBox(
                height: 25,
              ),

              //Dont have account yet? Register
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?",
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.primary),
                  ),
                  GestureDetector(
                    onTap: widget.togglePage,
                    child: Text(
                      " Register Now",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary),
                    ),
                  ),
                ],
              )

              // const SizedBox(height: 25,),
            ],
          ),
        ),
      ),
    );
  }
}
