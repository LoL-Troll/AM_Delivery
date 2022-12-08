import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_db/constants.dart';
import 'database.dart';

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

// TextField For inputing text
Widget inputTextField({
  required String label,
  obsureText = false,
  required TextEditingController controller,
  keyboardtype = TextInputType.text,
  inputformatters = null,
}) {
  return Expanded(
    child: Padding(
      padding: const EdgeInsets.all(5.0),
      child: TextField(
        inputFormatters: inputformatters,
        keyboardType: keyboardtype,
        controller: controller,
        obscureText: obsureText,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: kCaptionTextStyle,
          border: const OutlineInputBorder(),
        ),
      ),
    ),
  );
}

class _RegisterScreenState extends State<RegisterScreen> {
  final fNameController = TextEditingController();
  final lNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();

  late String fName, lName, gender = "Male", email, password, phone;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // backgroundColor: kLightColor,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "Register For a Customer Account",
                  style: kTitleTextStyle,
                ), // Title
                Row(
                  children: [
                    inputTextField(
                      label: "First Name",
                      controller: fNameController,
                      inputformatters: [LengthLimitingTextInputFormatter(20)],
                    ),
                    inputTextField(
                      label: "Last Name",
                      controller: lNameController,
                      inputformatters: [LengthLimitingTextInputFormatter(20)],
                    ),
                  ],
                ), // First Name, Last Name
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: "Gender",
                      labelStyle: kCaptionTextStyle,
                      border: const OutlineInputBorder(),
                    ),
                    value: gender,
                    style: kCaptionTextStyle,
                    items: ["Male", "Female"]
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        gender = value!;
                      });
                    },
                  ),
                ), // Gender Selection
                inputTextField(
                  label: "Email",
                  controller: emailController,
                  inputformatters: [LengthLimitingTextInputFormatter(50)],
                ), // Email
                inputTextField(
                  label: "Phone Number",
                  controller: phoneController,
                  keyboardtype: TextInputType.phone,
                  inputformatters: [LengthLimitingTextInputFormatter(10)],
                ),
                inputTextField(
                  label: "Password",
                  obsureText: true,
                  controller: passwordController,
                  inputformatters: [LengthLimitingTextInputFormatter(50)],
                ), // Password
                TextButton(
                  onPressed: () {
                    fName = fNameController.text;
                    lName = lNameController.text;
                    email = emailController.text;
                    password = passwordController.text;
                    phone = phoneController.text;
                    print([fName, lName, gender, email, password, phone]);

                    int id = 1; // TODO

                    String sex = gender == "Male" ? "M" : "F";
                    Database db = Database();
                    db
                        .getConnection()
                        .then((conn) => conn.query("""INSERT INTO USER
                    VALUES($id, '$fName', '$lName', '$sex', '$phone', '$email', '$password', 'Customer')"""));
                  },
                  child: Text("Confirm"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
