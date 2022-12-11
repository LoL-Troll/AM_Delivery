import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:test_db/EditProfile.dart';
import 'package:test_db/SendPackageUI.dart';

import 'PackageSummury.dart';
import 'User.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _scanBarcode = 'Unknown';

  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      print(barcodeScanRes);
    } catch (e) {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("AM Delivey"),
            IconButton(
              icon: Icon(Icons.camera_alt),
              onPressed: () async {
                //TODO add transition to notification screen
                scanBarcodeNormal();
                print(_scanBarcode);
              },
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(
              onPressed: () {
                //TODO add transition to the main screen
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [Icon(Icons.home), Text("Home")],
              ),
            ),
            Padding(padding: EdgeInsets.only(left: 5)),
            TextButton(
              onPressed: () {
                //TODO add transition to the Track screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          PackageSummury(packageID: _scanBarcode)),
                );
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.track_changes),
                  Padding(padding: EdgeInsets.only(left: 5)),
                  Text("Track")
                ],
              ),
            ),
            Padding(padding: EdgeInsets.only(left: 5)),
            TextButton(
              onPressed: () {
                //TODO add transition to the History screen
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [Icon(Icons.history), Text("History")],
              ),
            ),
            Padding(padding: EdgeInsets.only(left: 5)),
            TextButton(
              onPressed: () {
                //TODO add transition to the Profile screen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const EditProfile()),
                );
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.person),
                  Padding(padding: EdgeInsets.only(left: 5)),
                  Text("Profile")
                ],
              ),
            ),
          ],
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.all(15),
                child: Text(
                  "Hello, ${User.getInstance().FName}",
                  //TODO Make it so that the user Fname is displayed here
                  style: TextStyle(fontSize: 30),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.blue.withOpacity(0.5),
                ),
                child: Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "Track Your Package",
                        style: TextStyle(fontSize: 20),
                        softWrap: false,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                      ),
                      Text(
                        "Enter the Tracking Number of your package",
                        style: TextStyle(color: Colors.black.withOpacity(0.5)),
                      ),
                      TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50)),
                          hintText: "Enter the Tracking Number",
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Track Now",
                              style: TextStyle(color: Colors.white),
                            ),
                            Icon(
                              Icons.arrow_right_alt_sharp,
                              color: Colors.white,
                            ),
                          ],
                        ),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20))),
                      )
                    ],
                  ),
                ),
                height: MediaQuery.of(context).size.height * 0.3,
                width: MediaQuery.of(context).size.width * 0.9,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Our Services: ",
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.15,
                    width: MediaQuery.of(context).size.width * 0.9,
                    margin: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.blue.withOpacity(0.5),
                    ),
                    child: TextButton(
                      onPressed: () {
                        //TODO Make it go to the Normal Delivey page/Service
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SendPackageUI(
                              expressShipping: false,
                            ),
                          ),
                        );
                      },
                      child: Row(
                        children: [
                          Image(
                              image: AssetImage(
                            "assets/Standard_Delivery.png",
                          )),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  "Normal Shipping",
                                  style: TextStyle(color: Colors.black),
                                ),
                                Text(
                                  "Deliver Packages from 1-3 days after pickup",
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(0.5)),
                                  softWrap: false,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 3,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.15,
                    width: MediaQuery.of(context).size.width * 0.9,
                    margin: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.blue.withOpacity(0.5),
                    ),
                    child: TextButton(
                      onPressed: () {
                        //TODO Make it go to the Express Delivey page/Service
                      },
                      child: Row(
                        children: [
                          Image(
                              image: AssetImage(
                            "assets/ExpressPackage.png",
                          )),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  "Express Shipping",
                                  style: TextStyle(color: Colors.black),
                                ),
                                Text(
                                  "Deliver Packages overnight after pickup",
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(0.5)),
                                  softWrap: false,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 3,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
