class User {
  int? _id;
  String? _email;
  String? _password;

  User(this._email, this._password);

  User.fromMap(dynamic obj) {
    _email = obj['userEmail'];
    _password = obj['userPassword'];
  }

  String? get email => _email;
  String? get password => _password;

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map["email"] = _email;
    map["password"] = _password;
    return map;
  }
}