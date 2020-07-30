import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isEmailValid = false;
  bool _isPasswordValid = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: "Email",
            ),
            onChanged: _validateEmail,
            controller: _emailController,
          ),
          TextField(
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              labelText: "Password",
            ),
            obscureText: true,
            onChanged: _validatePassword,
            controller: _passwordController,
          ),
          Container(
            margin: EdgeInsets.only(top: 16),
            child: FlatButton(
              color: Colors.green,
              textColor: Colors.limeAccent,
              disabledColor: Colors.green[100],
              child: Text("Login"),
              onPressed: _isEmailValid && _isPasswordValid ? _login : null,
            ),
          ),
        ],
      ),
    );
  }

  void _login() {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(
          "email: ${_emailController.text}, pass: ${_passwordController.text}"),
    ));
  }

  void _validateEmail(String email) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    setState(() {
      _isEmailValid = (!regex.hasMatch(email)) ? false : true;
    });
  }

  void _validatePassword(String password) {
    setState(() {
      _isPasswordValid = password.length >= 3;
    });
  }
}
