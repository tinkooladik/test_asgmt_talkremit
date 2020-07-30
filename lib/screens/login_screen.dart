import 'package:flutter/material.dart';

import '../models/LoginRequest.dart';
import '../models/User.dart';
import '../services/api_service.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isEmailValid = false;
  bool _isPasswordValid = false;

  Future<UserResponse> _futureLogin;

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
            child: (_futureLogin == null)
                ? loginButton()
                : FutureBuilder<UserResponse>(
                    future: _futureLogin,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasData) {
                          return Text(
                              "Hi, ${snapshot.data.data.remitter.name}!");
                        } else if (snapshot.hasError) {
                          return Column(
                            children: <Widget>[
                              Text(
                                snapshot.error.toString(),
                                style: TextStyle(color: Colors.red),
                              ),
                              loginButton(),
                            ],
                          );
                        }
                      }

                      return CircularProgressIndicator();
                    },
                  ),
          ),
        ],
      ),
    );
  }

  FlatButton loginButton() {
    return FlatButton(
      color: Colors.green,
      textColor: Colors.limeAccent,
      disabledColor: Colors.green[100],
      child: Text("Login"),
      onPressed: _isEmailValid && _isPasswordValid ? _login : null,
    );
  }

  void _login() {
    setState(() {
      _futureLogin = ApiService.login(LoginRequest(
          email: _emailController.text, password: _passwordController.text));
    });
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
