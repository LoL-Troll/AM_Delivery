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

  static Future<String?> addPackage({
    required int val,
    required int length,
    required int width,
    required int height,
    required int weight,
    required String catagory,
    required bool expressShipping,
    required String? reciverID,
  }) async {
    DateTime deliveryDate = DateTime.now().add(
      Duration(days: expressShipping ? 5 : 10),
    );
    String sendDateString =
        "${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}";

    String deliveryDateString =
        "${deliveryDate.year}-${deliveryDate.month}-${deliveryDate.day}";

    await getConnection().then(
      (conn) => conn.execute(
        """
        INSERT INTO PACKAGE
        VALUES(0, 'In Transit', '$deliveryDateString', $width, $length, $height,
        $weight, $val, '$catagory', ${User.getInstance().userId}, $reciverID, FALSE, '$sendDateString')""",
      ),
    );

    var packageID = (await getConnection().then((conn) => conn.execute("""
    SELECT max(PackageID)
    FROM PACKAGE"""))).rows.first.assoc()["max(PackageID)"];
    return packageID;
  }

  static Future<String?> addHub({
    required String country,
    required String city,
    required String street,
    required String zip,
    required String type,
  }) async {
    await getConnection().then(
      (conn) => conn.execute(
        """
        INSERT INTO HUB
        VALUES(0, '$type', $zip, '$city', '$street', '$country')
        """,
      ),
    );

    var hubID = (await getConnection().then((conn) => conn.execute("""
    SELECT max(Hub_ID)
    FROM HUB"""))).rows.first.assoc()["max(Hub_ID)"];
    return hubID;
  }

  static Future<String?> editHub({
    required String country,
    required String city,
    required String street,
    required String zip,
    required String type,
    required String hubId,
  }) async {
    await getConnection().then(
      (conn) => conn.execute(
        """
        UPDATE HUB
         SET Country = '$country', City = '$city', Street = '$street', Zip_code = '$zip', Type = '$type'
         Where Hub_ID = $hubId;
        """,
      ),
    );
  }

  static Future<String?> addCustomerAddress({
    required String country,
    required String city,
    required String street,
    required String zip,
    required String houseNumber,
    required String customerID,
  }) async {
    String? hubID = await addHub(
        country: country,
        city: city,
        street: street,
        zip: zip,
        type: "Customer Address");

    await getConnection().then(
      (conn) => conn.execute(
        """
        INSERT INTO CUSTOMER_ADDRESS
        VALUES($hubID, $houseNumber, $customerID)
        """,
      ),
    );

    return hubID;
  }

  static void editCustomerAddress({
    required String country,
    required String city,
    required String street,
    required String zip,
    required String hubId,
  }) async {
    await editHub(
      country: country,
      city: city,
      street: street,
      zip: zip,
      type: "Customer Address",
      hubId: hubId,
    );
  }

  static Future<Map<String, String?>> loginUser(
      {required String email, required String password}) async {
    return (await getConnection().then((conn) => conn.execute("""
    SELECT *
    FROM USER JOIN CUSTOMER
    WHERE CUSTOMER.CustomerID = USER.UserID
    AND email = '$email' AND password = '$password'"""))).rows.first.assoc();
  }

  static Future<String?> getUserIDFromPhone({required String phone}) async {
    return (await getConnection().then((conn) => conn.execute("""
    SELECT UserID
    FROM USER
    WHERE Phone = '$phone'"""))).rows.first.assoc()["UserID"];
  }

  static Future<String?> getUserIDFromEmail({required String email}) async {
    return (await getConnection().then((conn) => conn.execute("""
    SELECT UserID
    FROM USER
    WHERE Email = '$email'"""))).rows.first.assoc()["UserID"];
  }

  static Future<Map<String, String?>> getUser({required String id}) async {
    var result = await getConnection().then((conn) => conn.execute("""
     SELECT *
     FROM USER
     WHERE UserID = $id;"""));
    print(result.rows.first.assoc());

    return result.rows.first.assoc();
  }

  static Future<Map<String, String?>> getPackage(
      {required String packageID}) async {
    var result = await getConnection().then((conn) => conn.execute("""
     SELECT *
     FROM PACKAGE
     WHERE PackageID = $packageID;"""));
    print("DB");
    print(result.rows.first.assoc());

    return result.rows.first.assoc();
  }

  static Future<Iterable<ResultSetRow>> getSentOrReceivedPackgesInTransit({
    required String? userID,
    bool sent = false,
    bool received = false,
  }) async {
    String condition = "";
    if (sent && received) {
      condition = "SenderID = $userID OR ReceiverID = $userID";
    } else if (sent) {
      condition = "SenderID = $userID";
    } else if (received) {
      condition = "ReceiverID = $userID";
    }

    var result = await getConnection().then((conn) => conn.execute("""
     SELECT *
     FROM PACKAGE p
     WHERE ($condition)
     AND p.Status = 'In Transit';"""));

    return result.rows;
  }

  static Future<Iterable<ResultSetRow>> getSentOrReceivedPackges({
    required String? userID,
    bool sent = false,
    bool received = false,
  }) async {
    String condition = "";
    if (sent && received) {
      condition = "SenderID = $userID OR ReceiverID = $userID";
    } else if (sent) {
      condition = "SenderID = $userID";
    } else if (received) {
      condition = "ReceiverID = $userID";
    }

    var result = await getConnection().then((conn) => conn.execute("""
     SELECT *
     FROM PACKAGE p
     WHERE ($condition)
     AND p.Status NOT IN ('In Transit');"""));

    return result.rows;
  }

  static Future<Iterable<ResultSetRow>> getTrackingDetails(
      {required String? packageID}) async {
    var result = await getConnection().then((conn) => conn.execute("""
     Select *
    FROM (PACKAGE p NATURAL JOIN TRANSPORTS t) NATURAL JOIN TRANSPORT_EVENT te NATURAL JOIN TRANSPORT_ACTIVITY ta
    WHERE p.PackageID = $packageID
    ORDER BY ScheduleNum asc ,Date asc, Activity desc"""));
    return result.rows;
  }

  static Future<Map<String, String?>> getHub({required String? HubID}) async {
    var result = await getConnection().then((conn) => conn.execute("""
    Select *
    FROM HUB
    Where Hub_ID = $HubID"""));
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
    SET FName = '$fName', LName = '$lName', sex = '$sex', email = '$email', Phone = '$phone'
    WHERE UserID = $id"""));
  }

  static Future modifyCustomerPassword(User user) async {
    String? password = user.password;
    String? id = user.userId;

    var x = await getConnection().then((conn) => conn.execute("""
    UPDATE USER
    SET Password = '$password'
    WHERE UserID = $id"""));
  }

  static Future<Map<String, String?>> getCustomerAddress(
      {required String customerId}) async {
    var x = await getConnection().then((conn) => conn.execute("""
    Select *
    FROM CUSTOMER NATURAL JOIN CUSTOMER_ADDRESS NATURAL JOIN HUB
    Where CustomerID = $customerId;"""));

    return x.rows.first.assoc();
  }

  static Future setPaidPackage({required String packageID}) async {
    var x = await getConnection().then((conn) => conn.execute("""
    UPDATE PACKAGE
    SET Payment_Status = 1
    WHERE PackageID = $packageID"""));
  }
}
