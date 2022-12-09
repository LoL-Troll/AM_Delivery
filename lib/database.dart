import 'dart:async';
import 'package:mysql_client/mysql_client.dart';
class Database {
  static Future getConnection() async {
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

    var result = await conn.execute('''
    select *
    from USER
    where Fname = "Majed";
    ''');

    print(result.numOfColumns);
    print(result.numOfRows);
    print(result.lastInsertID);
    print(result.affectedRows);

    // print query result
    for (final row in result.rows) {
      print(row.colAt(2));
      // print(row.colByName("title"));

      // print all rows as Map<String, String>
      //print(row.assoc());
    }

    await conn.close();

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
