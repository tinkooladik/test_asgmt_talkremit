import '../models/Response.dart';

class TransactionResponse extends Response<Transaction> {
  TransactionResponse(Map<String, dynamic> json) : super(json);

  @override
  Transaction parseData(Map<String, dynamic> data) {
    return Transaction.fromJson(data);
  }
}

class Transaction {
  final String ref;

  Transaction({this.ref});

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(ref: json['trans_ref']);
  }
}
