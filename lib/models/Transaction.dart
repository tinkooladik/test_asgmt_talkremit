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
  final double paid;
  final String type;

  Transaction({this.ref, this.paid, this.type});

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
        ref: json['trans_ref'],
        paid: json['paid_total'],
        type: json['trans_type']);
  }
}
