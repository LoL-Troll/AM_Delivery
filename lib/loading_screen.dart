import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_db/PackageSummury.dart';
import 'package:test_db/customWidgets.dart';
import 'package:test_db/main.dart';

import 'constants.dart';

// void main() {
//   runApp(
//     MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: LoadingTransaction(),
//     ),
//   );
// }

class LoadingTransaction extends StatefulWidget {
  final String packageID;

  const LoadingTransaction({Key? key, required this.packageID});

  @override
  State<LoadingTransaction> createState() =>
      _LoadingTransactionState(packageID: packageID);
}

class _LoadingTransactionState extends State<LoadingTransaction> {
  final String packageID;

  _LoadingTransactionState({required this.packageID});

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
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Main(),
                                ),
                                (route) => false,
                              );
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
