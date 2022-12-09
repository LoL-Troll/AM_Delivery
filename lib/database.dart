import 'dart:async';
import 'package:mysql1/mysql1.dart';

class Database {
  static Future<MySqlConnection> getConnection() async {
    var settings = new ConnectionSettings(
        host: 'sql7.freesqldatabase.com',
        port: 3306,
        user: 'sql7581270',
        db: 'sql7581270',
        password: 'Wbh5iGZkJl');

    return await MySqlConnection.connect(settings);
  }

  static Future addCustomerUser({
    required String fName,
    required String lName,
    sex = null,
    required String phone,
    required String email,
    required String password,
  }) async {
    int id = 2; // TODO

    await getConnection().then((conn) => conn.query("""INSERT INTO USER
    VALUES($id, '$fName', '$lName', '$sex', '$phone', '$email', '$password', 'Customer')"""));
    print("A USER WITH NAME $fName $lName BEEN ADDED TO THE DATABASE");
  }

  static Future<int> getUserID(
      {required String email, required String password}) async {
    var result = await getConnection().then((conn) => conn.query("""
     SELECT UserID
     FROM USER
     WHERE Email = '$email' AND Password = '$password';"""));

    print(result.toString());
    int id = 3; //int.parse(result.toString());

    return id;
  }
}
