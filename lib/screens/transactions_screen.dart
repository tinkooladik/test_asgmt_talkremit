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
                return snapshot.data.isNotEmpty
                    ? _successState(snapshot.data)
                    : _emptyState();
              } else if (snapshot.hasError) {
                return _errorState(snapshot.error.toString());
              }
            }

            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }

  Widget _successState(List<Transaction> list) {
    var total = list.map((t) => t.paid).toList().reduce((a, b) => a + b);
    var avg = total / list.length;
    return Column(children: <Widget>[
      Text("total send transactions amount: $total"),
      Text("average transactions amount: $avg"),
      Container(
        height: 400,
        child: ListView.builder(
          itemCount: list.length,
          itemBuilder: (ctx, index) => _TransactionItem(
            transaction: list[index],
          ),
        ),
      ),
    ]);
  }

  Widget _emptyState() {
    return Text("You have no transactions");
  }

  Widget _errorState(String error) {
    return Text(
      error,
      style: TextStyle(color: Colors.red),
    );
  }
}

class _TransactionItem extends StatelessWidget {
  final Transaction transaction;

  _TransactionItem({this.transaction});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        margin: EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 8,
        ),
        padding: EdgeInsets.all(8),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.purple,
            width: 2,
          ),
          color: Colors.limeAccent,
        ),
        child: Text(
          "\$${transaction.paid}",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.purple,
          ),
        ),
      ),
    );
  }
}
