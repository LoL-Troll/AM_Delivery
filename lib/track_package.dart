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
  String showOnly = "Sent & Received Packages";
  List<Widget> items = [];

  @override
  void initState() {
    super.initState();
    setState(() {
      setItems("Sent & Received Packages");
    });
  }

  Future<void> setItems(String show) async {
    print(show);
    bool sent = show.contains("Sent");
    bool received = show.contains("Received");

    Iterable<ResultSetRow> resultMap = await Database.getSentOrReceivedPackges(
      userID: User.getInstance().userId,
      sent: sent,
      received: received,
    );
    List<Widget> newitems = [];
    for (ResultSetRow r in resultMap) {
      newitems.add(
        CustomListViewItem(
          packageID: r.assoc()["PackageID"]!,
          date: r.assoc()["Expected_Delivery_Date"]!,
          receiver: r.assoc()["ReceiverID"]!,
          sender: r.assoc()["SenderID"]!,
        ),
      );
      this.items = newitems;
    }
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
                value: showOnly,
                items: [
                  "Sent & Received Packages",
                  "Sent Packages",
                  "Received Packages"
                ],
                onChanged: (value) {
                  setState(() {
                    showOnly = value!;
                    setItems(value);
                  });
                }),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: items,
                // children: [
                //   Container(
                //     decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(20),
                //       color: kLightColor,
                //     ),
                //     child: Column(
                //       children: [
                //         Row(
                //           children: [
                //             Expanded(
                //               child: CustomLabel2(
                //                 title: "Package ID",
                //                 label: "12123",
                //               ),
                //             ),
                //             Expanded(
                //               child: CustomLabel2(
                //                 title: "Exp. Arrival Date",
                //                 label: "2-5-22",
                //               ),
                //             ),
                //           ],
                //         ),
                //         Row(
                //           children: [
                //             Expanded(
                //               child: CustomLabel2(
                //                 title: "Sender",
                //                 label: "XXX",
                //               ),
                //             ),
                //             Expanded(
                //               child: CustomLabel2(
                //                 title: "Receiver",
                //                 label: "YYY",
                //               ),
                //             ),
                //           ],
                //         )
                //       ],
                //     ),
                //   ),
                // ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
