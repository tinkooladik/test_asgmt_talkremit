import '../models/Response.dart';

class TransactionResponse extends Response<List<Transaction>> {
  TransactionResponse(Map<String, dynamic> json) : super(json);

  @override
  List<Transaction> parseData(dynamic data) {
    return _parseList(data["transactions"]);
  }

  List<Transaction> _parseList(List data) {
    return data.map((t) => Transaction.fromJson(t)).toList();
  }
}

class Transaction {
  final String ref;

  Transaction({this.ref});

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(ref: json['trans_ref']);
  }
}
