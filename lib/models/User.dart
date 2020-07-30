import '../models/Response.dart';

class UserResponse extends Response<User> {
  UserResponse(Map<String, dynamic> json) : super(json);

  @override
  User parseData(Map<String, dynamic> data) {
    return User.fromJson(data);
  }
}

class User {
  final Remitter remitter;

  User({this.remitter});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(remitter: Remitter.fromJson(json['remitter']));
  }
}

class Remitter {
  final String name;

  Remitter({this.name});

  factory Remitter.fromJson(Map<String, dynamic> json) {
    return Remitter(name: json['name']);
  }
}
