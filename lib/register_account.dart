import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_db/constants.dart';
import 'package:test_db/customWidgets.dart';
import 'User.dart';
import 'database.dart';
import 'register_location.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RegisterScreen(),
    );
  }
}

class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final fNameController = TextEditingController();
  final lNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();

  late String fName, lName, email, password, phone;
  String gender = "Male";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Register For a Customer Account"),
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
                CustomInputTextField(
                  label: "Password",
                  obsureText: true,
                  controller: passwordController,
                  inputformatters: [LengthLimitingTextInputFormatter(50)],
                ), // Password
                Padding(padding: EdgeInsets.all(15)),
                CustomBigButton(
                  label: "Confirm",
                  onPressed: () async {
                    fName = fNameController.text;
                    lName = lNameController.text;
                    phone = phoneController.text;
                    email = emailController.text;
                    password = passwordController.text;
                    String sex = gender == "Male" ? "M" : "F";

                    // TODO ENCRYPT PASSWORD
                    String? customerID = await Database.addCustomerUser(
                        fName: fName,
                        lName: lName,
                        sex: sex,
                        phone: phone,
                        email: email,
                        password: password);

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RegisterAddress(
                          customerID: customerID,
                        ),
                      ),
                    );
                  },
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => RegisterScreen()),
                  // );
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
