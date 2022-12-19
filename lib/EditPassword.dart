import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
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

                  /// Encrypting the password
                  final key =
                      encrypt.Key.fromUtf8('my 32 length key................');
                  final iv = encrypt.IV.fromLength(16);

                  final encrypter = encrypt.Encrypter(encrypt.AES(key));
                  final String encryptedOld1 =
                      encrypter.encrypt(oldpassController.text, iv: iv).base64;
                  final String encryptedOld2 =
                      encrypter.encrypt(oldpass2Controller.text, iv: iv).base64;

                  if ((encryptedOld1 == encryptedOld2) &&
                      encryptedOld1 == user.password &&
                      newPassword.text.isNotEmpty) {
                    user.password = newPassword.text;
                    Database.modifyCustomerPassword(user);
                    Navigator.pop(context);
                  } else {
                    Alert(
                        context: context,
                        title:
                            "Please enter all of the above information correctly",
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
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
