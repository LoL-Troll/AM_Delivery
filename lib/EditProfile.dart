import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_db/EditAddress.dart';
import 'package:test_db/EditPassword.dart';
import 'package:test_db/User.dart';
import 'package:test_db/database.dart';
import 'customWidgets.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final fNameController = TextEditingController(text: User.getInstance().FName);
  final lNameController = TextEditingController(text: User.getInstance().LName);
  final emailController = TextEditingController(text: User.getInstance().email);
  final phoneController = TextEditingController(text: User.getInstance().phone);

  late String fName,
      lName,
      gender = User.getInstance().sex == "M" ? "Male" : "Female",
      email,
      phone;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Account"),
        centerTitle: true,
      ),
      // backgroundColor: kLightColor,
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Title
              CustomInputTextField(
                label: "First Name",
                controller: fNameController,
                inputformatters: [LengthLimitingTextInputFormatter(20)],
              ),
              CustomInputTextField(
                label: "Last Name",
                controller: lNameController,
                inputformatters: [LengthLimitingTextInputFormatter(20)],
              ), // First Name, Last Name
              CustomDropdownButton(
                  title: "Gender",
                  //TODO DO THE GENDER THING
                  value: gender,
                  items: ["Male", "Female"],
                  onChanged: (String? value) {
                    setState(() {
                      gender = value!;
                    });
                  }),

              CustomInputTextField(
                label: "Email",
                controller: emailController,
                inputformatters: [LengthLimitingTextInputFormatter(50)],
              ), // Email
              CustomInputTextField(
                label: "Phone Number",
                controller: phoneController,
                keyboardtype: TextInputType.phone,
                inputformatters: [LengthLimitingTextInputFormatter(10)],
              ),
              // Password
              Padding(padding: EdgeInsets.all(15)),
              CustomBigButton(
                label: "Confirm",
                onPressed: () {
                  fName = fNameController.text;
                  lName = lNameController.text;
                  phone = phoneController.text;
                  email = emailController.text;
                  String sex = gender == "Male" ? "M" : "F";

                  User user = User.getInstance();
                  user.FName = fName;
                  user.LName = lName;
                  user.phone = phone;
                  user.email = email;
                  user.sex = sex;

                  Database.modifyCustomerUser(user);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
