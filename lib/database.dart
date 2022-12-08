import 'dart:async';
import 'package:mysql1/mysql1.dart';

class Database {
  Future<MySqlConnection> getConnection() async {
    var settings = new ConnectionSettings(
        host: 'sql7.freesqldatabase.com',
        port: 3306,
        user: 'sql7581270',
        db: 'sql7581270',
        password: 'Wbh5iGZkJl');

    return await MySqlConnection.connect(settings);
  }

  // static Future addCustomerUser({
  //   required String fName,
  //   required String lName,
  //   sex = null,
  //   required String phone,
  //   required String email,
  //   required String password,
  // }) async {
  //   int id = 1;
  //   await _conn.query("""INSERT INTO USER
  //   VALUES($id, $fName, $lName, $sex, $phone, $email, $password, Customer)""");
  // }
}
