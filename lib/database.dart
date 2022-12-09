import 'dart:async';
import 'package:mysql_client/mysql_client.dart';
import 'package:test_db/User.dart';

class Database {
  static Future<MySQLConnection> getConnection() async {
    // Open a connection (testdb should already exist)
    final conn = await MySQLConnection.createConnection(
      host: '193.122.73.150',
      port: 3306,
      userName: "Troll",
      password: "Ics321#@!",
      databaseName: "sql7581270", // optional
    );

    await conn.connect();
    print("Connected");

    return conn;

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

    await getConnection().then((conn) => conn.execute("""INSERT INTO USER
    VALUES($id, '$fName', '$lName', '$sex', '$phone', '$email', '$password', 'Customer')"""));
    print("A USER WITH NAME $fName $lName BEEN ADDED TO THE DATABASE");
  }

  static Future<Map<String, String?>> getUser(
      {required String email, required String password}) async {
    var result = await getConnection().then((conn) => conn.execute("""
     SELECT *
     FROM USER
     WHERE Email = '$email' AND Password = '$password';"""));
    //TODO Make it so that if the input is incorrect show an alert to the user
    print(result.toString());
    int id = 3; //int.parse(result.toString());

    return result.rows.first.assoc();
  }

  static Future addPackage({
    required int val,
    required int length,
    required int width,
    required int height,
    required int weight,
    required String category,
    required int resPhoneNum,
    required
  }) async {

  }
}
