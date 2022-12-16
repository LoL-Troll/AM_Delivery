import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'User.dart';
import 'constants.dart';
import 'customWidgets.dart';
import 'database.dart';

class EditPassword extends StatefulWidget {
  const EditPassword({Key? key}) : super(key: key);

  @override
  State<EditPassword> createState() => _EditPasswordState();
}

class _EditPasswordState extends State<EditPassword> {
  final oldpassController = TextEditingController();
  final oldpass2Controller = TextEditingController();
  final newPassword = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Password"),
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
                label: "Old Password",
                obscureText: true,
                controller: oldpassController,
                inputformatters: [LengthLimitingTextInputFormatter(20)],
              ),
              CustomInputTextField(
                label: "Old Password again",
                obscureText: true,
                controller: oldpass2Controller,
                inputformatters: [LengthLimitingTextInputFormatter(20)],
              ), // First Name, Last Name
              CustomInputTextField(
                label: "New Password",
                obscureText: true,
                controller: newPassword,
                inputformatters: [LengthLimitingTextInputFormatter(50)],
              ), // Email
              // Password
              Padding(padding: EdgeInsets.all(15)),
              CustomBigButton(
                label: "Confirm",
                onPressed: () {
                  User user = User.getInstance();
                    if((oldpassController.text == oldpass2Controller.text) && oldpassController.text == user.password && newPassword.text.isNotEmpty){
                      user.password = newPassword.text;
                      Database.modifyCustomerPassword(user);
                      Navigator.pop(context);
                    }
                    else{
                      Alert(
                          context: context,
                          title: "Please enter all of the above information correctly",
                          buttons: [
                            DialogButton(
                              child: Text(
                                "OK",
                                style:
                                TextStyle(color: Colors.white, fontSize: 20),
                              ),
                              onPressed: () => Navigator.pop(context),
                              width: 120,
                            )
                          ],
                          style: AlertStyle(
                            titleStyle: kHeading1TextStyle,
                          )).show();
                    }

                  // TODO create the editCustomerUser Method
                  // Database.editCustomerUser(
                  //   fName: fName,
                  //   lName: lName,
                  //   sex: sex,
                  //   phone: phone,
                  //   email: email,
                  // );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
