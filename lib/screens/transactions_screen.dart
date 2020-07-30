import 'package:flutter/material.dart';

import '../models/Transaction.dart';
import '../services/api_service.dart';

class TransactionsScreen extends StatefulWidget {
  @override
  _TransactionsScreenState createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  final Future<List<Transaction>> _futureTransactions =
      ApiService.fetchTransactions();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Transactions"),
      ),
      resizeToAvoidBottomPadding: true,
      body: Container(
        alignment: Alignment.center,
        width: double.infinity,
        height: double.infinity,
        margin: EdgeInsets.only(top: 16),
        child: FutureBuilder<List<Transaction>>(
          future: _futureTransactions,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                return Text("Success");
              } else if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              }
            }

            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
