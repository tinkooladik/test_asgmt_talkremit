import '../models/Response.dart';

class UserResponse extends Response<User> {
  UserResponse(Map<String, dynamic> json) : super(json);

  @override
  User parseData(Map<String, dynamic> data) {
    return User.fromJson(data);
  }
}

class User {
  final _Remitter _remitter;
  final _Token _token;

  String get name {
    return _remitter._name;
  }

  String get token {
    return _token._token;
  }

  User({_Remitter remitter, _Token token})
      : _remitter = remitter,
        _token = token;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        remitter: _Remitter.fromJson(json['remitter']),
        token: _Token.fromJson(json['token']));
  }
}

class _Remitter {
  final String _name;

  _Remitter({String name}) : _name = name;

  factory _Remitter.fromJson(Map<String, dynamic> json) {
    return _Remitter(name: json['name']);
  }
}

class _Token {
  final String _token;

  _Token({String token}) : _token = token;

  factory _Token.fromJson(Map<String, dynamic> json) {
    return _Token(token: json['token']);
  }
}
