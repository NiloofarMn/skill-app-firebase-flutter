import 'package:firebase_test/shared/auth_service.dart';
import 'package:firebase_test/shared/configs.dart';
import 'package:firebase_test/pages/laoding.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _email = '';
  String _pass = '';
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Loading()
        : Padding(
            padding: const EdgeInsets.all(20.0),
            child: makeUserAndPassPanel(),
          );
  }

  Form makeUserAndPassPanel() {
    return Form(
      key: _formKey,
      child: Center(
        child: ListView(
          shrinkWrap: true,
          children: [
            buildEmailTextField(),
            const SizedBox(
              height: 10,
            ),
            buildPasswordTextField(),
            const SizedBox(
              height: 30,
            ),
            submitDataButton(),
            const SizedBox(
              height: 30,
            ),
            Text(
              error,
              style: TextStyle(
                color: Configs.compColors2,
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextFormField buildEmailTextField() {
    return TextFormField(
      initialValue: _email,
      decoration: Configs.fieldDecoration.copyWith(label: const Text('Email')),
      keyboardType: TextInputType.emailAddress,
      onChanged: (value) => setState(() {
        _email = value;
      }),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Don't leave Email Field Empty";
        }
        if (!RegExp(
          r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$",
        ).hasMatch(value)) {
          return 'The input is not an Email';
        }
      },
    );
  }

  TextFormField buildPasswordTextField() {
    return TextFormField(
      decoration:
          Configs.fieldDecoration.copyWith(label: const Text('Password')),
      obscureText: true,
      autocorrect: false,
      keyboardType: TextInputType.visiblePassword,
      onChanged: (value) => _pass = value,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Don't leave Password Field Empty";
        }
      },
    );
  }

  ElevatedButton submitDataButton() {
    return ElevatedButton(
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            setState(() {
              loading = true;
            });
            dynamic authResult =
                await AuthService().signInWithEmailAndPassword(_email, _pass);
            if (authResult == null) {
              setState(() {
                error = 'Email or password is wrong';
                loading = false;
              });
            }
          }
        },
        child: const Text('Login'));
  }
}
