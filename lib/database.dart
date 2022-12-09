import 'dart:async';
import 'package:mysql_client/mysql_client.dart';

Future main() async {
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