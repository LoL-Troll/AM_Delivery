import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'constants.dart';
import 'customWidgets.dart';
import 'database.dart';
import 'login_account.dart';

class EditAddress extends StatefulWidget {
  final String? customerId;

  EditAddress({super.key, required this.customerId});

  @override
  State<EditAddress> createState() =>
      _EditAddressState(customerId: customerId);
}

class _EditAddressState extends State<EditAddress> {
  String? customerId;
  String? countryValue, stateValue, cityValue;



  _EditAddressState({required this.customerId});


  Future<Map<String, String?>> getCustomerAddress() async {
    var x = await Database.getCustomerAddress(customerId: customerId!);
    return x;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Edit Address"),
          centerTitle: true,
        ),
        // backgroundColor: kLightColor,
        body: Column(
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
                        border: Border.all(
                            color: Colors.grey.shade300)),

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
                        countryValue = value
                            .substring(value.indexOf(" "))
                            .trim();
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


            FutureBuilder(
                future: getCustomerAddress(),
                builder: (ctx, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    // If we got an error
                    if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          '${snapshot.error} occurred',
                          style: TextStyle(fontSize: 18),
                        ),
                      );

                      // if we got our data
                    } else if (snapshot.hasData) {
                      // Extracting data from snapshot object
                      Map<String, String?> data = snapshot.data as Map<String, String?>;

                       final zipCodeController = TextEditingController(text: data["Zip_code"]);

                       final streetController = TextEditingController(text: data["Street"]);
                       final houseNumberController = TextEditingController(text: data["HouseNumber"]);

                      return SingleChildScrollView(
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              CustomInputTextField(
                                label: "Zip Code",
                                controller: zipCodeController,
                                keyboardtype: TextInputType.number,
                              ),
                              CustomInputTextField(
                                label: "Street",
                                controller: streetController,
                                inputformatters: [
                                  LengthLimitingTextInputFormatter(50)
                                ],
                              ),
                              CustomInputTextField(
                                label: "House Number",
                                controller: houseNumberController,
                                keyboardtype: TextInputType.number,
                              ),
                              CustomBigButton(
                                label: "Confirm",
                                onPressed: () {
                                  if (countryValue != null &&
                                      cityValue != null &&
                                      streetController.text.isNotEmpty &&
                                      zipCodeController.text.isNotEmpty &&
                                      houseNumberController.text.isNotEmpty) {
                                    Database.editCustomerAddress(
                                        country: countryValue!,
                                        city: cityValue!,
                                        street: streetController.text,
                                        zip: zipCodeController.text,
                                        hubId: data["Hub_ID"]!);

                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => LoginScreen(),
                                      ),
                                      (route) => false,
                                    );
                                  } else {
                                    Alert(
                                        context: context,
                                        title: "All Fields Must Be Filled",
                                        buttons: [
                                          DialogButton(
                                            child: Text(
                                              "OK",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20),
                                            ),
                                            onPressed: () => Navigator.pop(context),
                                            width: 120,
                                          )
                                        ],
                                        style: AlertStyle(
                                          titleStyle: kHeading1TextStyle,
                                        )).show();
                                  }
                                },
                              )
                            ],
                          ),
                        ),
                      );
                    }
                  }
                  // Displaying LoadingSpinner to indicate waiting state
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }),
          ],
        ));
  }
}
