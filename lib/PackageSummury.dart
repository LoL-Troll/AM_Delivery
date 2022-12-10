import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_db/constants.dart';
import 'package:test_db/database.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PackageSummury(
        packageID: "2",
      ),
    ),
  );
}

class PackageSummury extends StatefulWidget {
  const PackageSummury({super.key, required this.packageID});

  final String packageID;
  @override
  State<PackageSummury> createState() =>
      _PackageSummaryState(packageID: packageID);
}

class _PackageSummaryState extends State<PackageSummury> {
  late String packageID;
  late Map<String, String?> packageInfo;
  late Map<String, String?> receiverInfo;

  _PackageSummaryState({required String packageID}) {
    Database.getPackage(packageID: packageID).then((value) async {
      packageInfo = value;
    });

    Database.getUserMapFromID(id: packageInfo["ReceiverID"]!)
        .then((value) async {
      receiverInfo = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Package Summary"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                Text(
                  "Package Status",
                  style: kHeading2TextStyle,
                ),
                Text(
                  packageInfo["Status"]!,
                  style: kHeading2TextStyle,
                ),
              ],
            ),
            Column(
              children: [
                Text(
                  "Estimated Delivery Date",
                  style: kHeading2TextStyle,
                ),
                Text(
                  packageInfo["Expected_Delivery_Date"]!,
                  style: kHeading2TextStyle,
                ),
              ],
            ),
            Column(
              children: [
                Text(
                  "Package Information",
                  style: kHeading2TextStyle,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Text(
                          "Length",
                          style: kHeading2TextStyle,
                        ),
                        Text(
                          packageInfo["Length"]! + " cm",
                          style: kHeading2TextStyle,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          "Width",
                          style: kHeading2TextStyle,
                        ),
                        Text(
                          packageInfo["Width"]! + " cm",
                          style: kHeading2TextStyle,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          "Height",
                          style: kHeading2TextStyle,
                        ),
                        Text(
                          packageInfo["Height"]! + " cm",
                          style: kHeading2TextStyle,
                        ),
                      ],
                    )
                  ],
                ),
                Column(
                  children: [
                    Text(
                      "Weight",
                      style: kHeading2TextStyle,
                    ),
                    Text(
                      packageInfo["Weight"]! + " KG",
                      style: kHeading2TextStyle,
                    ),
                  ],
                ),
              ],
            ),
            Column(
              children: [
                Text(
                  "Catagory",
                  style: kHeading2TextStyle,
                ),
                Text(
                  packageInfo["Catagory"]!,
                  style: kHeading2TextStyle,
                ),
              ],
            ),
            Column(
              children: [
                Text(
                  "Receiver Information",
                  style: kHeading2TextStyle,
                ),
                Text(
                  receiverInfo["Fname"]!,
                  style: kHeading2TextStyle,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
