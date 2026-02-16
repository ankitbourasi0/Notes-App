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

class RegisterPage extends StatefulWidget {
  final void Function()? togglePage;
  const RegisterPage({super.key, required this.togglePage});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  //register button pressed
  void register() {
    //prepare info
    final String name = nameController.text;
    final String email = emailController.text;
    final String password = passwordController.text;
    final String confirmPassword = confirmPasswordController.text;

    //auth cubit
    final authCubit = context.read<AuthCubit>();

    // ensure fields aren't empty
    if (email.isNotEmpty && password.isNotEmpty && confirmPassword.isNotEmpty) {
      //ensure password match
      if (password == confirmPassword) {
        authCubit.register(name, email, password);
      } else {
        //passwords don't match
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Passwords don't match")));
      }
    } else {
      //Fields are empty -> display error
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please complete all fields!")));
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //Scaffold
    return Scaffold(
      //APP BAR
      appBar: AppBar(
        title: const Text("Register"),
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
                "Let's create an account for you",
                style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.inversePrimary),
              ),

              const SizedBox(
                height: 25,
              ),
              MyTextfield(
                  controller: nameController,
                  hintText: "Name",
                  obscureText: false),
              const SizedBox(
                height: 10,
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

              //Confirm Password Text Field
              MyTextfield(
                  controller: confirmPasswordController,
                  hintText: "Confirm Password",
                  obscureText: true),

              const SizedBox(
                height: 10,
              ),
              //Login Button
              MyButton(onTap: register , text: 'SIGN UP'),
              const SizedBox(
                height: 25,
              ),

              //Dont have account yet? Register
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account?",
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.primary),
                  ),
                  GestureDetector(
                    onTap: widget.togglePage,
                    child: Text(
                      " Login Now",
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
