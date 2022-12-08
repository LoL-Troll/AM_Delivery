import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// TextField For inputing text
Widget inputTextField({
  required String label,
  required TextEditingController controller,
  keyboardtype = TextInputType.text,
  inputformatters = null,
}) {
  return Padding(
    padding: const EdgeInsets.all(15.0),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(label, textAlign: TextAlign.left),
      TextField(
        inputFormatters: inputformatters,
        keyboardType: keyboardtype,
        controller: controller,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
        ),
      ),
    ]),
  );
}

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
      appBar: AppBar(

      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            inputTextField(
                label: "Item Value in SAR",
                controller: itemValController,
                keyboardtype: TextInputType.number),
            inputTextField(
                label: "Item Length",
                controller: lengthController,
                keyboardtype: TextInputType.number),
            inputTextField(
                label: "Item Width",
                controller: widthController,
                keyboardtype: TextInputType.number),
            inputTextField(
                label: "Item Height",
                controller: hieghtController,
                keyboardtype: TextInputType.number),
            inputTextField(
                label: "Item Weight",
                controller: weightController,
                keyboardtype: TextInputType.number),
            Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Category"),
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                    ),
                    value: category,
                    style: Theme.of(context).textTheme.caption,
                    items: ["Regular", "Fragile", "Liquid", "Chemical"]
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        category = value!;
                      });
                    },
                  ),
                ],
              ),
            ),
            Padding(padding: EdgeInsets.fromLTRB(0, 15, 0, 0)),
            ElevatedButton(
              onPressed: () {},
              child: Container(
                height: MediaQuery.of(context).size.height * 0.1,
                width: MediaQuery.of(context).size.width * 0.9,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Confirm",
                      style: TextStyle(color: Colors.white, fontSize: 30),
                    ),
                    Padding(padding: EdgeInsets.all(5)),
                    Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 50,
                    ),
                  ],
                ),
              ),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20))),
            )
          ],
        ),
      ),
    );
  }
}
