import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mysql_client/mysql_client.dart';
import 'package:test_db/constants.dart';
import 'package:test_db/customWidgets.dart';
import 'package:test_db/register_account.dart';
import 'User.dart';
import 'database.dart';
import 'main.dart';

void main() {
  runApp(const Login());
}

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          color: kPrimaryColor,
        ),
        primarySwatch: MaterialColor(kDarkColor.value, color),
      ),
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
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image(
                  height: 250,
                  image: AssetImage(
                    "assets/logo.png",
                  ),
                ),
                CustomInputTextField(
                  label: "Email",
                  controller: emailController,
                  inputformatters: [LengthLimitingTextInputFormatter(50)],
                ), // Email

                CustomInputTextField(
                  label: "Password",
                  obsureText: true, // TODO BROKEN
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
                  onPressed: () async {
                    email = emailController.text;
                    password = passwordController.text;
                    Map<String, String?> userInfo = await Database.loginUser(
                        email: email, password: password);

                    User.craeteObj(userInfo);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MyHomePage()),
                    );
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
