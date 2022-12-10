import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:test_db/constants.dart';
import 'package:test_db/customWidgets.dart';
import 'package:test_db/database.dart';
import 'package:test_db/User.dart';

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
  late Map<String, String?> receiverInfo;

  _PackageSummaryState({required this.packageID});

  @override
  void initState() {
    super.initState();
    Database.getPackage(packageID: packageID).then((value) {
      setState(() {
        packageInfo = value;

        Database.getUser(id: packageInfo["ReceiverID"]!).then((value) {
          setState(() {
            receiverInfo = value;
          });
        });
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
                  "Package Tracking QR Code",
                  style: kHeading1TextStyle,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: BarcodeWidget(
                  barcode: Barcode.qrCode(),
                  data: packageID,
                  width: 200,
                  height: 200,
                ),
              ),
              CustomLabel(
                title: "Package Status",
                label: packageInfo["Status"]!,
              ),
              CustomLabel(
                title: "Estimated Delivery Date",
                label: packageInfo["Expected_Delivery_Date"]!,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CustomLabel(
                      title: "Length", label: packageInfo["Length"]! + " cm"),
                  CustomLabel(
                      title: "Width", label: packageInfo["Width"]! + " cm"),
                  CustomLabel(
                      title: "Height", label: packageInfo["Height"]! + " cm"),
                ],
              ),
              CustomLabel(title: "Catagory", label: packageInfo["Catagory"]!),
              CustomLabel(
                  title: "Sender Name",
                  label:
                      "${User.getInstance().FName} ${User.getInstance().LName}"),
              CustomLabel(
                  title: "Sender Phone Number",
                  label: User.getInstance().phone!),
              CustomLabel(
                  title: "Receiver Name",
                  label: receiverInfo["Fname"]! + " " + receiverInfo["Lname"]!),
              CustomLabel(
                  title: "Receiver Phone Number",
                  label: receiverInfo["Phone"]!),
            ],
          ),
        ),
      );
    } catch (e) {
      return Scaffold(body: Center(child: const CircularProgressIndicator()));
    }
  }
}
