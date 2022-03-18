import 'package:firebase_test/pages/register/login.dart';
import 'package:firebase_test/pages/register/signup.dart';
import 'package:firebase_test/shared/auth_service.dart';
import 'package:firebase_test/shared/configs.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLogin = true;
  final AuthService _authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            "Welcome to Skill App",
            style: TextStyle(color: Configs.compColors1),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          actions: [
            TextButton(
                onPressed: () {
                  setState(() {
                    isLogin = !isLogin;
                  });
                },
                child: Text(isLogin ? 'Sign up' : 'Login'))
          ]),
      body: isLogin ? const LoginPage() : const SignUpPage(),
      floatingActionButton: TextButton(
          onPressed: () async {
            dynamic authResult = await _authService.signInAnon();
            // print(authResult);
            // print(authResult.uid);
          },
          child: const Text('Login as a guest.')),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
