import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:test_db/DetailedTrack.dart';
import 'package:test_db/constants.dart';
import 'package:test_db/customWidgets.dart';
import 'package:test_db/database.dart';
import 'package:test_db/User.dart';
import 'package:test_db/payment.dart';

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
  String packageID;
  late Map<String, String?> packageInfo;
  late Map<String, String?> senderInfo;
  late Map<String, String?> receiverInfo;
  late double deliveryCost;
  late double insurance;

  _PackageSummaryState({required this.packageID});

  @override
  void initState() {
    super.initState();
    Database.getPackage(packageID: packageID).then((value) {
      setState(() {
        packageInfo = value;

        Database.getUser(id: packageInfo["SenderID"]!).then((value) {
          setState(() {
            senderInfo = value;
          });
        });

        Database.getUser(id: packageInfo["ReceiverID"]!).then((value) {
          setState(() {
            receiverInfo = value;
          });
        });

        deliveryCost = double.parse(packageInfo['Weight']!) * 0.5 +
            double.parse(packageInfo['Length']!) * 0.3 +
            double.parse(packageInfo['Width']!) * 0.3;
        insurance = 0.3 * double.parse(packageInfo["item_Value"]!);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    try {
      return Scaffold(
        appBar: AppBar(
          title: Text("Package Summary"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Package Tracking Barcode",
                  style: kHeading1TextStyle,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: BarcodeWidget(
                  barcode: Barcode.code39(),
                  data: packageID,
                  width: 300,
                  height: 200,
                ),
              ),
              const Divider(
                height: 10,
                indent: 30,
                endIndent: 30,
                color: kPrimaryColor,
                thickness: 2,
              ),
              CustomLabel(
                title: "Package Status",
                label: packageInfo["Status"]!,
              ),
              CustomLabel(
                title: "Package Created On",
                label: packageInfo["Sent_Date"]!,
              ),
              CustomLabel(
                title: "Estimated Delivery Date",
                label: packageInfo["Expected_Delivery_Date"]!,
              ),
              const Divider(
                height: 10,
                indent: 30,
                endIndent: 30,
                color: kPrimaryColor,
                thickness: 2,
              ),
              CustomLabel(title: "Bill Info", label: """
              Delivery Cost: $deliveryCost SAR
              Insurance Cost: $insurance SAR
              -------------------
              Total Cost: XXXXX + YYYYY SAR
              """),
              const Divider(
                height: 10,
                indent: 30,
                endIndent: 30,
                color: kPrimaryColor,
                thickness: 2,
              ),
              Text(
                "Package Information",
                style: kHeading1TextStyle.copyWith(fontSize: 30),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CustomLabel(
                          title: "Length",
                          label: packageInfo["Length"]! + " cm"),
                      CustomLabel(
                          title: "Width", label: packageInfo["Width"]! + " cm"),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CustomLabel(
                          title: "Height",
                          label: packageInfo["Height"]! + " cm"),
                      CustomLabel(
                          title: "Weight",
                          label: packageInfo["Weight"]! + " g"),
                    ],
                  ),
                ],
              ),
              CustomLabel(title: "Catagory", label: packageInfo["Catagory"]!),
              CustomLabel(
                  title: "Item Value",
                  label: packageInfo["item_Value"]! + " SAR"),
              const Divider(
                height: 10,
                indent: 30,
                endIndent: 30,
                color: kPrimaryColor,
                thickness: 2,
              ),
              CustomLabel(
                  title: "Sender Name",
                  label: "${senderInfo["Fname"]} ${senderInfo["Lname"]}"),
              CustomLabel(
                title: "Sender Phone Number",
                label: senderInfo["Phone"]!,
              ),
              const Divider(
                height: 10,
                indent: 30,
                endIndent: 30,
                color: kPrimaryColor,
                thickness: 2,
              ),
              CustomLabel(
                  title: "Receiver Name",
                  label: receiverInfo["Fname"]! + " " + receiverInfo["Lname"]!),
              CustomLabel(
                  title: "Receiver Phone Number",
                  label: receiverInfo["Phone"]!),
              const Divider(
                height: 10,
                indent: 30,
                endIndent: 30,
                color: kPrimaryColor,
                thickness: 2,
              ),
              packageInfo["Payment_Status"] == '0'
                  ? CustomBigButton(
                      label: "Pay Now",
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PaymentScreen(
                              packageID: packageID,
                              bill: deliveryCost,
                            ),
                          ),
                        );
                      })
                  : SizedBox(), // TODO DISABLE WHEN PAID (NOT DONE YET)
              CustomBigButton(
                  label: "Track Package",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailedTrack(
                          packageID: packageID,
                        ),
                      ),
                    );
                  }),
            ],
          ),
        ),
      );
    } catch (e) {
      return Scaffold(
          body: Center(
              child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          Text(
            "Fetching Data of Package No. $packageID",
            style: kCaptionTextStyle,
          )
        ],
      )));
    }
  }
}
