import 'package:flutter/material.dart';

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
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("AM Delivey"),
            IconButton(
              icon: Icon(Icons.notifications),
              onPressed: () {
                //TODO add transition to notification screen
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Hello, Ahmed",
              //TODO Make it so that the user Fname is displayed here
              style: TextStyle(fontSize: 30),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.blue.withOpacity(0.5),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("Track Your Package", style: TextStyle(fontSize: 20)),
                  Text(
                    "Enter the Tracking Number of your package",
                    style: TextStyle(color: Colors.black.withOpacity(0.5)),
                  ),
                  TextField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50)
                        ),
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
                          )
                        ],
                      ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
                    ),
                  )
                ],
              ),
              width: 300,
              height: 300,

              ),
          ],
        ),
      ),
    );
  }
}
