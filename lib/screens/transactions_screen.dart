import 'package:flutter/material.dart';

class TransactionsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Transactions"),
      ),
      resizeToAvoidBottomPadding: true,
      body: Container(
        child: Text("Transactions screen"),
      ),
    );
  }
}
