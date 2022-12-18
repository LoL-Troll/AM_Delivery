import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:test_db/PackageSummury.dart';
import 'package:test_db/constants.dart';
import 'customWidgets.dart';
import 'database.dart';

class SendPackageUI extends StatefulWidget {
  const SendPackageUI({super.key, required this.expressShipping});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final bool expressShipping;

  @override
  State createState() => _SendPackageUI(expressShipping: expressShipping);
}

class _SendPackageUI extends State<SendPackageUI> {
  @override
  final itemValController = TextEditingController();
  final widthController = TextEditingController();
  final hieghtController = TextEditingController();
  final weightController = TextEditingController();
  final lengthController = TextEditingController();
  final resieverPhoneController = TextEditingController();

  late String category = "Regular";
  late bool expressShipping;

  _SendPackageUI({required this.expressShipping});

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Send a Package To a Customer ${expressShipping ? "(Express)" : "(Regular)"}",
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // TODO add seperator (Package information)
            Text(
              "Package Information",
              style: kHeading1TextStyle,
            ),
            CustomInputTextField(
                label: "Item Value (SAR)",
                controller: itemValController,
                keyboardtype: TextInputType.number),
            CustomInputTextField(
                label: "Item Length (cm)",
                controller: lengthController,
                keyboardtype: TextInputType.number),
            CustomInputTextField(
                label: "Item Width (cm)",
                controller: widthController,
                keyboardtype: TextInputType.number),
            CustomInputTextField(
                label: "Item Height (cm)",
                controller: hieghtController,
                keyboardtype: TextInputType.number),
            CustomInputTextField(
                label: "Item Weight (grams)",
                controller: weightController,
                keyboardtype: TextInputType.number),
            CustomDropdownButton(
                title: "Category",
                value: category,
                items: ["Regular", "Fragile", "Liquid", "Chemical"],
                onChanged: (String? value) {
                  setState(() {
                    category = value!;
                  });
                }),
            //TODO make a limit for the numbers inputed.
            Text(
              "Receiver Information",
              style: kHeading1TextStyle,
            ),
            CustomInputTextField(
                label: "Receiver phone number",
                controller: resieverPhoneController),
            // TODO add seperator (reciver information)

            CustomBigButton(
              label: "Confirm",
              onPressed: () async {
                String? reciverID = await Database.getUserIDFromPhone(
                    phone: resieverPhoneController.text);

                print("111111111");
                String? packageID = await Database.addPackage(
                    val: int.parse(itemValController.text),
                    length: int.parse(lengthController.text),
                    width: int.parse(widthController.text),
                    height: int.parse(hieghtController.text),
                    weight: int.parse(weightController.text),
                    catagory: category,
                    expressShipping: expressShipping, //TODO
                    reciverID: reciverID);

                print("HERE?");
                print(packageID);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          PackageSummury(packageID: packageID!)),
                );
                print("ORE HERE?");
              },
            ),
          ],
        ),
      ),
    );
  }
}
