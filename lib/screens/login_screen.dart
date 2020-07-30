import 'package:flutter/material.dart';

import '../models/LoginRequest.dart';
import '../models/User.dart';
import '../screens/transactions_screen.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      resizeToAvoidBottomPadding: true,
      body: Padding(
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
                            _onSuccess(context, snapshot.data);
                          } else if (snapshot.hasError) {
                            _onError(context, snapshot.error.toString());
                          }
                          _futureLogin = null;
                          return loginButton();
                        }

                        return CircularProgressIndicator();
                      },
                    ),
            ),
          ],
        ),
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

  void _onSuccess(BuildContext context, UserResponse response) {
    Future.delayed(
        Duration.zero,
            () =>
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => TransactionsScreen())));
  }

  void _onError(BuildContext context, String error) {
    Future.delayed(
        Duration.zero,
            () =>
            Scaffold.of(context).showSnackBar(SnackBar(content: Text(error))));
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
