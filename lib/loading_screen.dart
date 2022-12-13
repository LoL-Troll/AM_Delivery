import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mysql_client/src/mysql_client/connection.dart';
import 'package:test_db/User.dart';
import 'package:test_db/customWidgets.dart';
import 'package:test_db/database.dart';

import 'constants.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TransactionLoading(),
    ),
  );
}

class TransactionLoading extends StatefulWidget {
  const TransactionLoading({Key? key}) : super(key: key);

  @override
  State<TransactionLoading> createState() => _TransactionLoadingState();
}

class _TransactionLoadingState extends State<TransactionLoading> {
  Future<String> getData() {
    return Future.delayed(Duration(seconds: 2), () {
      return "Payment Succeeded";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Processing Transaction"),
        ),
        body: FutureBuilder(
          future: getData(),
          builder: (ctx, snapshot) {
            // Checking if future is resolved or not
            if (snapshot.connectionState == ConnectionState.done) {
              // If we got an error
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    '${snapshot.error} occurred',
                    style: kHeading1TextStyle,
                  ),
                );

                // if we got our data
              } else if (snapshot.hasData) {
                // Extracting data from snapshot object
                final data = snapshot.data as String;
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.check_circle,
                            color: Colors.green,
                            size: 100,
                          ),
                        ),
                        Text('$data', style: kHeading1TextStyle),
                        CustomBigButton(
                            label: "Back to Summary",
                            onPressed: () {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => RegisterAddress(
                              //       customerID: customerID,
                              //     ),
                              //   ),
                              // );
                            }),
                      ],
                    ),
                  ),
                );
              }
            }

            // Displaying LoadingSpinner to indicate waiting state
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: CircularProgressIndicator(),
                  ),
                  Text(
                    "Proccessing Transaction",
                    style: kHeading1TextStyle,
                  ),
                ],
              ),
            );
          },
        ));
  }
}
