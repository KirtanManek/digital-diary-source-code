class User {
  late int _id;
  late String _name;
  late String _email;
  late String _password;

  User(this._id, this._name, this._email, this._password);

  User.fromMap(dynamic obj) {
    _id = obj['UserID'];
    _name = obj['UserName'];
    _email = obj['UserEmail'];
    _password = obj['UserPassword'];
  }

  int? get id => _id;
  String? get name => _name;
  String? get email => _email;
  String? get password => _password;

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map["UserID"] = _id;
    map["UserName"] = _name;
    map["UserEmail"] = _email;
    map["UserPassword"] = _password;
    return map;
  }
}