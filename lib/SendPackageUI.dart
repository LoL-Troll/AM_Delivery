import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'customWidgets.dart';

class SendPackageUI extends StatefulWidget {
  const SendPackageUI({super.key, required this.shipType});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String shipType;

  @override
  State createState() => _SendPackageUI();
}

class _SendPackageUI extends State<SendPackageUI> {
  @override
  final itemValController = TextEditingController();
  final widthController = TextEditingController();
  final hieghtController = TextEditingController();
  final weightController = TextEditingController();
  final lengthController = TextEditingController();
  late String category = "Regular";

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // TODO add seperator (Package information)
            CustomInputTextField(
                label: "Item Value (in SAR)",
                controller: itemValController,
                keyboardtype: TextInputType.number),
            CustomInputTextField(
                label: "Item Length",
                controller: lengthController,
                keyboardtype: TextInputType.number),
            CustomInputTextField(
                label: "Item Width",
                controller: widthController,
                keyboardtype: TextInputType.number),
            CustomInputTextField(
                label: "Item Height",
                controller: hieghtController,
                keyboardtype: TextInputType.number),
            CustomInputTextField(
                label: "Item Weight",
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
            // TODO add seperator (reciver information)
            CustomBigButton(
              label: "Confirm",
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
