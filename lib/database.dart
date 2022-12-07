import 'dart:async';
import 'package:mysql1/mysql1.dart';

Future main() async {
  // Open a connection (testdb should already exist)
  final conn = await MySqlConnection.connect(
    ConnectionSettings(
        host: 'sql7.freesqldatabase.com',
        port: 3306,
        user: 'sql7581270',
        db: 'sql7581270',
        password: 'Wbh5iGZkJl'),
  );

  var results = await conn.query('''
  select e.fname, d.Dname
  from EMPLOYEE e right outer join DEPARTMENT d on e.Dno = d.Dnumber
  ''');

  var bruh = await conn.query('''
  INSERT into DEPARTMENT values ("Fu23n", 9966, 987654321, null)
  ''');

  for (var row in results) {
    print('Name: ${row[0]}, depratment: ${row[1]}');
  }

  conn.close();
}