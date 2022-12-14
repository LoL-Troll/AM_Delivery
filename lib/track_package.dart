import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mysql_client/src/mysql_client/connection.dart';
import 'package:test_db/User.dart';
import 'package:test_db/customWidgets.dart';
import 'package:test_db/database.dart';

import 'constants.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TrackPackage(),
    ),
  );
}

class TrackPackage extends StatefulWidget {
  const TrackPackage({Key? key}) : super(key: key);

  @override
  State<TrackPackage> createState() => _TrackPackageState();
}

class _TrackPackageState extends State<TrackPackage> {
  late Future<List<Widget>> items;
  String showOnly = "Sent & Received Packages";
  // List<Widget> items = [];

  @override
  void initState() {
    super.initState();
    items = setItems(showOnly);
  }

  Future<List<Widget>> setItems(String show) async {
    print(show + " ???");
    bool sent = show.contains("Sent");
    bool received = show.contains("Received");

    Iterable<ResultSetRow> resultMap = await Database.getSentOrReceivedPackgesInTransit(
      userID: User.getInstance().userId,
      sent: sent,
      received: received,
    );

    print(resultMap.length);
    List<Widget> newitems = [];
    print("----");
    for (ResultSetRow r in resultMap) {
      String packageID = r.assoc()["PackageID"]!;
      String date = r.assoc()["Expected_Delivery_Date"]!;
      String receiver = r.assoc()["ReceiverID"]!;
      String sender = r.assoc()["SenderID"]!;
      String status = r.assoc()["Status"]!;

      newitems.add(
        CustomListViewItem(
          packageID: packageID,
          date: date,
          receiver: receiver,
          sender: sender,
          status: status,
        ),
      );
    }
    print(newitems.length);
    print("");
    return newitems;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Track Packages"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomDropdownButton(
                title: "Show Only",
                value: "Sent & Received Packages",
                items: [
                  "Sent & Received Packages",
                  "Sent Packages",
                  "Received Packages"
                ],
                onChanged: (value) {
                  setState(() {
                    showOnly = value!;
                    items = setItems(value!);
                  });
                }),
            FutureBuilder(
                future: setItems(showOnly),
                builder: (ctx, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    // If we got an error
                    if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          '${snapshot.error} occurred',
                          style: TextStyle(fontSize: 18),
                        ),
                      );

                      // if we got our data
                    } else if (snapshot.hasData) {
                      // Extracting data from snapshot object
                      var data = snapshot.data as List<Widget>;
                      return Column(
                        children: data,
                      );
                    }
                  }

                  // Displaying LoadingSpinner to indicate waiting state
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                })
          ],
        ),
      ),
    );
  }
}
