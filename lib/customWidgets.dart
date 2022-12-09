import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_db/constants.dart';

// TextField For inputing text
class CustomInputTextField extends StatelessWidget {
  String label;
  TextEditingController controller;
  TextInputType? keyboardtype = TextInputType.text;
  List<TextInputFormatter>? inputformatters;
  bool? obsureText = false;

  CustomInputTextField({
    required this.label,
    required this.controller,
    this.keyboardtype,
    this.inputformatters,
    this.obsureText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(label, textAlign: TextAlign.left),
        TextField(
          inputFormatters: inputformatters,
          keyboardType: keyboardtype,
          controller: controller,
          decoration: const InputDecoration(
            // errorText: "This Field Should Not Be Empty",
            border: OutlineInputBorder(),
          ),
        ),
      ]),
    );
  }
}

// Drop down menu
class CustomDropdownButton extends StatelessWidget {
  late String title;
  late String value;
  late List<String> items;
  late void Function(String?)? onChanged;

  CustomDropdownButton({
    required this.title,
    required this.value,
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
          Text(title),
          DropdownButtonFormField<String>(
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
            ),
            value: value,
            style: kCaptionTextStyle,
            items: items.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
