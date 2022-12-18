import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_db/PackageSummury.dart';
import 'package:test_db/constants.dart';

// TextField For inputing text
class CustomInputTextField extends StatelessWidget {
  String label;
  TextEditingController controller;
  TextInputType? keyboardtype = TextInputType.text;
  List<TextInputFormatter>? inputformatters;
  bool obscureText;

  CustomInputTextField({
    required this.label,
    required this.controller,
    this.keyboardtype,
    this.inputformatters,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            textAlign: TextAlign.left,
            style: kCaptionTextStyle,
          ),
          TextField(
            style: kCaptionTextStyle,
            inputFormatters: inputformatters,
            keyboardType: keyboardtype,
            controller: controller,
            obscureText: obscureText,
            decoration: const InputDecoration(
              // errorText: "This Field Should Not Be Empty",
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
    );
  }
}

// Drop down menu
class CustomDropdownButton extends StatelessWidget {
  late String title;
  late String? value;
  late List<String> items;
  late void Function(String?)? onChanged;

  CustomDropdownButton({
    required this.title,
    this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: kCaptionTextStyle,
          ),
          DropdownButtonFormField<String>(
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
            ),
            value: value,
            style: kCaptionTextStyle,
            items: items.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  style: kCaptionTextStyle.copyWith(
                    color: Colors.black,
                  ),
                ),
              );
            }).toList(),
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}

// Big button
class CustomBigButton extends StatelessWidget {
  late String label;
  late void Function() onPressed;
  final IconData icon;

  CustomBigButton(
      {required this.label, required this.onPressed, this.icon = Icons.check});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20))),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.1,
          width: MediaQuery.of(context).size.width * 0.9,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                label,
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
              Padding(padding: EdgeInsets.all(5)),
              Icon(
                icon,
                color: Colors.white,
                size: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomLabel extends StatelessWidget {
  late String title, label;

  CustomLabel({required this.title, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          Text(
            title,
            style: kHeading1TextStyle,
            softWrap: false,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            maxLines: 3,
          ),
          Text(
            label,
            style: kHeading2TextStyle,
            textAlign: TextAlign.center,
            softWrap: false,
            overflow: TextOverflow.ellipsis,
            maxLines: 3,
          ),
        ],
      ),
    );
  }
}

class CustomLabel2 extends StatelessWidget {
  late String title, label;
  Color? labelColor = Colors.black;

  CustomLabel2({
    required this.title,
    required this.label,
    this.labelColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Column(
        children: [
          Text(
            title,
            style: kHeading1TextStyle.copyWith(fontSize: 22),
            softWrap: false,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            maxLines: 3,
          ),
          Text(
            label,
            style: kHeading2TextStyle.copyWith(
              fontSize: 20,
              color: labelColor,
            ),
            textAlign: TextAlign.center,
            softWrap: false,
            overflow: TextOverflow.ellipsis,
            maxLines: 3,
          ),
        ],
      ),
    );
  }
}

class CustomListViewItem extends StatelessWidget {
  late String packageID, date, sender, receiver, status;

  CustomListViewItem({
    required this.packageID,
    required this.date,
    required this.sender,
    required this.receiver,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PackageSummury(packageID: packageID),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: kLightColor,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: CustomLabel2(
                      title: "Status",
                      label: status,
                      labelColor: status == "In Transit"
                          ? Color(0xFF095769)
                          : (status == "Delivered"
                              ? Colors.green.shade800
                              : Colors.red.shade700),
                    ),
                  ),
                  Expanded(
                    child: CustomLabel2(
                      title: "Package ID",
                      label: packageID,
                    ),
                  ),
                  Expanded(
                    child: CustomLabel2(
                      title: "Exp. Arrival Date",
                      label: date,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: CustomLabel2(
                      title: "Sender",
                      label: sender,
                    ),
                  ),
                  Expanded(
                    child: CustomLabel2(
                      title: "Receiver",
                      label: receiver,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
