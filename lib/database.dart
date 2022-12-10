import 'dart:async';
import 'package:mysql_client/mysql_client.dart';
import 'package:test_db/User.dart';

class Database {
  static late final MySQLConnection conn;
  static bool initialized = false;

  static Future<MySQLConnection> getConnection() async {
    // Open a connection (testdb should already exist)
    if (!initialized) {
      conn = await MySQLConnection.createConnection(
        host: '193.122.73.150',
        port: 3306,
        userName: "Troll",
        password: "Ics321#@!",
        databaseName: "sql7581270", // optional
      );

      initialized = true;
      await conn.connect();
      print("Connected");
    }
    return conn;
  }

  static Future<String?> addCustomerUser({
    required String fName,
    required String lName,
    sex = null,
    required String phone,
    required String email,
    required String password,
  }) async {
    await getConnection().then((conn) => conn.execute("""
    INSERT INTO USER
    VALUES(0, '$fName', '$lName', '$sex', '$phone', '$email', '$password', 'Customer')"""));

    var id = (await getConnection().then((conn) => conn.execute("""
    SELECT UserID
    FROM USER
    WHERE email = '$email'"""))).rows.first.assoc()["UserID"];

    await getConnection().then((conn) => conn.execute("""
    INSERT INTO CUSTOMER
    VALUES($id)"""));

    print(
        "A USER WITH NAME $fName $lName AND ID $id BEEN ADDED TO THE DATABASE");

    return id;
  }

  static Future addPackage({
    required int val,
    required int length,
    required int width,
    required int height,
    required int weight,
    required String category,
    required int resPhoneNum,
    required,
  }) async {}

  static Future<Map<String, String?>> getUser(
      {required String email, required String password}) async {
    var result = await getConnection().then((conn) => conn.execute("""
     SELECT *
     FROM USER
     WHERE Email = '$email' AND Password = '$password';"""));
    //TODO Make it so that if the input is incorrect show an alert to the user
    print(result.rows.first.assoc());

    return result.rows.first.assoc();
  }

  static Future modifyCustomerUser(User user) async {
    String? id = user.userId,
        fName = user.FName,
        lName = user.LName,
        email = user.email,
        phone = user.phone,
        sex = user.sex;

    var x = await getConnection().then((conn) => conn.execute("""
    UPDATE USER
    SET FName = '$fName', LName = '$lName', sex = '$sex', email = '$email', Phone = $phone
    WHERE UserID = $id"""));
    print(x.rows.length);
    print("USER WITH NAME $fName $lName and ID $id BEEN MODIFIED");
  }
}
