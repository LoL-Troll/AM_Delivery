import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_db/constants.dart';
import 'package:test_db/customWidgets.dart';
import 'package:test_db/register_account.dart';
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
      home: LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  late String email, password;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Login"),
          centerTitle: true,
        ),
        // backgroundColor: kLightColor,
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CustomInputTextField(
                  label: "Email",
                  controller: emailController,
                  inputformatters: [LengthLimitingTextInputFormatter(50)],
                ), // Email

                CustomInputTextField(
                  label: "Password",
                  obsureText: true,
                  controller: passwordController,
                  inputformatters: [LengthLimitingTextInputFormatter(50)],
                ), // Password

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Need an Account?",
                      style: kCaptionTextStyle,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegisterScreen()),
                        );
                      },
                      child: Text(
                        "SIGN UP HERE",
                        style: kCaptionTextStyle,
                      ),
                    )
                  ],
                ),
                CustomBigButton(
                  label: "Confirm",
                  onPressed: () {
                    email = emailController.text;
                    password = passwordController.text;

                    Database.getUserID(email: email, password: password);
                    //TODO
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
