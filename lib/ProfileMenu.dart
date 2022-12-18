import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_db/EditAddress.dart';
import 'package:test_db/EditPassword.dart';
import 'package:test_db/EditProfile.dart';
import 'package:test_db/User.dart';
import 'package:test_db/constants.dart';
import 'customWidgets.dart';

class ProfileMenu extends StatefulWidget {
  const ProfileMenu({Key? key}) : super(key: key);

  @override
  State<ProfileMenu> createState() => _ProfileMenuState();
}

class _ProfileMenuState extends State<ProfileMenu> {
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
        title: Text("Account Information"),
        centerTitle: true,
      ),
      // backgroundColor: kLightColor,
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.person,
                size: 150,
              ),
              Text(
                "Customer",
                style: kHeading1TextStyle,
              ),
              SizedBox(
                height: 20,
              ),
              const Divider(
                height: 10,
                indent: 30,
                endIndent: 30,
                color: kPrimaryColor,
                thickness: 2,
              ),
              CustomLabel(
                  title: "Name",
                  label:
                      "${User.getInstance().FName!} ${User.getInstance().LName!}"),
              CustomLabel(
                  title: "Gender",
                  label: User.getInstance().sex == "M" ? "Male" : "Female"),
              CustomLabel(
                  title: "Phone Number", label: User.getInstance().phone!),
              CustomLabel(
                title: "Email",
                label: User.getInstance().email!,
              ),
              const Divider(
                height: 10,
                indent: 30,
                endIndent: 30,
                color: kPrimaryColor,
                thickness: 2,
              ),
              Padding(padding: EdgeInsets.all(15)),
              CustomBigButton(
                label: "Change Information",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const EditProfile()),
                  );
                },
              ),
              CustomBigButton(
                label: "Change Password",
                icon: Icons.password,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const EditPassword()),
                  );
                },
              ),
              CustomBigButton(
                label: "Change Address",
                icon: Icons.home,
                onPressed: () {
                  String? id = User.getInstance().userId;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EditAddress(customerId: id)),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
