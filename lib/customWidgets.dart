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

  CustomBigButton({required this.label, required this.onPressed});

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
              const Icon(
                Icons.check,
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
