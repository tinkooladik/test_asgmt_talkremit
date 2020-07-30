import 'package:flutter/material.dart';

import './screens/login_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: MaterialApp(
        title: 'TalkRemit',
        theme: ThemeData(
          primarySwatch: Colors.amber,
        ),
        home: Scaffold(
          appBar: AppBar(
            title: Text("Login"),
          ),
          resizeToAvoidBottomPadding: true,
          body: LoginPage(),
        ),
      ),
    );
  }
}