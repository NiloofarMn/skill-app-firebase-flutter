import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_test/pages/home/home.dart';
import 'package:firebase_test/pages/register/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider.of<User?>(context) == null ? AuthPage() : MyHomePage();
  }
}
