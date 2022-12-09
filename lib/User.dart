class User {
  late String? userId;
  late String? sex;
  late String? FName;
  late String? LName;
  late String? phone;
  late String? email;
  late String? password;
  late String? type;
  static User? user;

  User(
      {required this.userId,
      required this.sex,
      required this.FName,
      required this.LName,
      required this.phone,
      required this.email,
      required this.password,
      required this.type});

  static void craeteObj(Map<String, String?> userInfo) {
    user ??= User(
          userId: userInfo["UserID"],
          sex: userInfo["Sex"],
          FName: userInfo["Fname"],
          LName: userInfo["Lname"],
          phone: userInfo["Phone"],
          email: userInfo["Email"],
          password: userInfo["Password"],
          type: userInfo["Type"]);
  }

  static User? getInstance() {
    return user;
  }
}
