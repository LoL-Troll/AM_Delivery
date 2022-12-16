import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:test_db/EditProfile.dart';
import 'package:test_db/SendPackageUI.dart';
import 'package:test_db/constants.dart';
import 'package:test_db/track_package.dart';
import 'HistoryPackage.dart';
import 'PackageSummury.dart';
import 'User.dart';

// TODO NO NEED FOR THIS
void main() {
  runApp(const MyApp());
}

class Main extends StatefulWidget {
  const Main({Key? key}) : super(key: key);

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  int currentIndex = 0;
  List<Widget> _children = [
    MyHomePage(),
    TrackPackage(),
    HistoryPackage(),
    EditProfile()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.track_changes),
            label: 'Track',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        unselectedItemColor: Colors.black,
        currentIndex: currentIndex,
        selectedItemColor: Color(0xff03dffc),
      ),
      body: _children[currentIndex],
    );
  }
}

// TODO NO NEED FOR THIS
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
        appBarTheme: AppBarTheme(
          color: Colors.amber,
        ),
      ),
      home: MyHomePage(),
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
  final trackingNumberController = TextEditingController();

  Future<String> scanBarcodeNormal() async {
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
    if (!mounted) return "Error";

    return barcodeScanRes;
    // setState(() {
    //   _scanBarcode = barcodeScanRes;
    // });
  }

  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
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
                String packageID = await scanBarcodeNormal();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PackageSummury(packageID: packageID),
                  ),
                );
              },
            )
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
                  "Hello, ${User.getInstance().sex == "M" ? "Mr." : "Ms."} ${User.getInstance().FName}",
                  style: kTitleTextStyle,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: kLightColor,
                ),
                height: MediaQuery.of(context).size.height * 0.3,
                width: MediaQuery.of(context).size.width * 0.9,
                child: Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "Track Your Package",
                        style: kHeading2TextStyle,
                        softWrap: false,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                      ),
                      Text(
                        "Enter the Tracking Number of your package",
                        style: kCaptionTextStyle,
                      ),
                      TextField(
                        controller: trackingNumberController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50)),
                          hintText: "Enter the Tracking Number",
                          hintStyle: kCaptionTextStyle,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PackageSummury(
                                  packageID: trackingNumberController.text),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            )),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Track Now",
                              style: kCaptionTextStyle,
                            ),
                            Icon(
                              Icons.arrow_right_alt_sharp,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(height: 15),
                  Text(
                    "Our Services: ",
                    style: kHeading1TextStyle,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.15,
                    width: MediaQuery.of(context).size.width * 0.9,
                    margin: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: kLightColor,
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
                                  style: kHeading2TextStyle,
                                ),
                                Text(
                                  "Deliver Packages from 8-12 days after pickup",
                                  style: kCaptionTextStyle,
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
                      color: kLightColor,
                    ),
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SendPackageUI(
                              expressShipping: true,
                            ),
                          ),
                        );
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
                                  style: kHeading2TextStyle,
                                ),
                                Text(
                                  "Deliver Packages from 3-5 days after pickup",
                                  style: kCaptionTextStyle,
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
