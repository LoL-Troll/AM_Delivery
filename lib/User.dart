class User {
  late String? _userId;
  late String? _sex;
  late String? _FName;
  late String? _LName;
  late String? _phone;
  late String? _email;
  late String? _password;
  late String? _type;
  static late User _user;

  User(this._userId, this._sex, this._FName, this._LName, this._phone,
      this._email, this._password, this._type);

  static void craeteObj(Map<String, String?> userInfo) {
    _user = User(
      userInfo["UserID"],
      userInfo["Sex"],
      userInfo["Fname"],
      userInfo["Lname"],
      userInfo["Phone"],
      userInfo["Email"],
      userInfo["Password"],
      userInfo["Type"],
    );
  }

  static User getInstance() {
    return _user;
  }

  String? get type => _type;

  String? get password => _password;

  String? get email => _email;

  String? get phone => _phone;

  String? get LName => _LName;

  String? get FName => _FName;

  String? get sex => _sex;

  String? get userId => _userId;

  set type(String? value) {
    _type = value;
  }

  set password(String? value) {
    _password = value;
  }

  set email(String? value) {
    _email = value;
  }

  set phone(String? value) {
    _phone = value;
  }

  set LName(String? value) {
    _LName = value;
  }

  set FName(String? value) {
    _FName = value;
  }

  set sex(String? value) {
    _sex = value;
  }
}
