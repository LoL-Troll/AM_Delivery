import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_db/constants.dart';
import 'package:test_db/customWidgets.dart';
import 'package:test_db/login_account.dart';
import 'User.dart';
import 'database.dart';

class RegisterAddress extends StatefulWidget {
  final String? customerID;

  const RegisterAddress({super.key, required this.customerID});

  @override
  State<RegisterAddress> createState() =>
      _RegisterAddressState(customerID: customerID);
}

class _RegisterAddressState extends State<RegisterAddress> {
  String? countryValue, stateValue, cityValue;
  final zipCodeController = TextEditingController();
  final streetController = TextEditingController();
  final houseNumberController = TextEditingController();
  String? customerID;

  _RegisterAddressState({required this.customerID});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Address Information"),
          centerTitle: true,
        ),
        // backgroundColor: kLightColor,
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Region Information",
                        style: kCaptionTextStyle,
                      ),
                      SizedBox(height: 5),
                      CSCPicker(
                        ///Dropdown box decoration to style your dropdown selector [OPTIONAL PARAMETER] (USE with disabledDropdownDecoration)
                        dropdownDecoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                        ),

                        ///Disabled Dropdown box decoration to style your dropdown selector [OPTIONAL PARAMETER]  (USE with disabled dropdownDecoration)
                        disabledDropdownDecoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300)),

                        ///placeholders for dropdown search field
                        countrySearchPlaceholder: "Country",
                        stateSearchPlaceholder: "State",
                        citySearchPlaceholder: "City",

                        ///labels for dropdown
                        countryDropdownLabel: "Country",
                        stateDropdownLabel: "State",
                        cityDropdownLabel: "City",

                        selectedItemStyle: kCaptionTextStyle,

                        ///DropdownDialog Heading style [OPTIONAL PARAMETER]
                        dropdownHeadingStyle: kHeading1TextStyle,

                        ///DropdownDialog Item style [OPTIONAL PARAMETER]
                        dropdownItemStyle: kCaptionTextStyle,

                        ///Dialog box radius [OPTIONAL PARAMETER]
                        dropdownDialogRadius: 10.0,

                        ///Search bar radius [OPTIONAL PARAMETER]
                        searchBarRadius: 10.0,

                        ///triggers once country selected in dropdown
                        onCountryChanged: (value) {
                          setState(() {
                            ///store value in country variable
                            countryValue =
                                value.substring(value.indexOf(" ")).trim();
                          });
                        },

                        ///triggers once state selected in dropdown
                        onStateChanged: (value) {
                          setState(() {
                            ///store value in state variable
                            stateValue = value;
                          });
                        },

                        ///triggers once city selected in dropdown
                        onCityChanged: (value) {
                          setState(() {
                            ///store value in city variable
                            cityValue = value;
                          });
                        },
                      ),
                    ],
                  ),
                ), // CustomCountryPicker
                CustomInputTextField(
                    label: "Zip Code", controller: zipCodeController),
                CustomInputTextField(
                    label: "Street", controller: streetController),
                CustomInputTextField(
                    label: "House Number", controller: houseNumberController),
                CustomBigButton(
                  label: "Confirm",
                  onPressed: () {
                    Database.addCustomerAddress(
                        country: countryValue!,
                        city: cityValue!,
                        street: streetController.text,
                        zip: zipCodeController.text,
                        houseNumber: houseNumberController.text,
                        customerID: customerID!);
                    print(countryValue! + " " + cityValue!);

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
