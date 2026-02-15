/*
Auth Page - Determines Whether to login or register page. 
*/

import 'package:flutter/material.dart';
import 'package:notes_app_sync/features/auth/presentation/pages/login_page.dart';
import 'package:notes_app_sync/features/auth/presentation/pages/register_page.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
//initially show logged in page
  bool showLoginPage = true;
  void togglePage() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage(togglePage: togglePage);
    } else {
      return RegisterPage(togglePage: togglePage);
    }
  }
}
