import 'package:another_stepper/dto/stepper_data.dart';
import 'package:another_stepper/widgets/another_stepper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mysql_client/mysql_client.dart';
import 'package:test_db/constants.dart';
import 'database.dart';

class DetailedTrack extends StatefulWidget {
  final String packageID;

  const DetailedTrack({super.key, required this.packageID});

  @override
  State<DetailedTrack> createState() =>
      _DetailedTrackState(packageID: packageID);
}

class _DetailedTrackState extends State<DetailedTrack> {
  String packageID;
  List<StepperData> items = [];
  int index = 0;
  var x;

  _DetailedTrackState({required this.packageID});

  Future<List<StepperData>> getPackageDetails() async {
    Iterable<ResultSetRow> result =
        await Database.getTrackingDetails(packageID: packageID);

    items.add(StepperData(
        title: StepperText(
          "Order Placed",
          textStyle: const TextStyle(
            color: Colors.grey,
          ),
        ),
        subtitle: StepperText("Your order has been placed"),
        iconWidget: Container(
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
              color: kPrimaryColor,
              borderRadius: BorderRadius.all(Radius.circular(30))),
          child: const Icon(Icons.home, color: Colors.white),
        )));

    for (ResultSetRow r in result) {
      index++;
      x = await Database.getHub(HubID: r.assoc()["DestinationHub"]);
      String activity = r.assoc()["Activity"]!;
      String eventType = r.assoc()["Type"]!;
      String hubType = x["Type"]!;
      String country = x["Country"]!;
      String city = x["City"]!;
      Icon icon;

      String sub;
      sub = city + " " + country + "\n";

      if (activity == "In Transit") {
        icon = Icon(
          eventType == "Plane"
              ? Icons.airplanemode_active_outlined
              : Icons.local_shipping_outlined,
          color: Colors.white,
        );
        sub += "Package is on its way to a $hubType";
      } else {
        if (hubType == "Airport") {
          icon = Icon(
            Icons.airplanemode_active_outlined,
            color: Colors.white,
          );
        } else if (hubType == "Retail Center") {
          icon = Icon(
            Icons.shopping_basket_outlined,
            color: Colors.white,
          );
        } else if (hubType == "Warehouse") {
          icon = Icon(
            Icons.warehouse_outlined,
            color: Colors.white,
          );
        } else {
          icon = Icon(
            Icons.home,
            color: Colors.white,
          );
        }
        sub += "Shipment has been received in $hubType";
      }
      sub += "\n${r.assoc()["Date"]}";

      items.add(
        StepperData(
            title: StepperText(
              activity,
              textStyle: kHeading1TextStyle,
            ),
            subtitle: StepperText(sub),
            iconWidget: Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.all(Radius.circular(30))),
              child: icon,
            )),
      );
    }

    if(x["Type"] == "Customer Address" && result.last.assoc()["Activity"]! == "Arrived"){
      index++;
      items.add(StepperData(
          title: StepperText(
            "Delivered",
            textStyle: const TextStyle(
              color: Colors.black,
            ),
          ),
          subtitle: StepperText("Your order has been delivered"),
          iconWidget: Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.all(Radius.circular(30))),
            child: const Icon(Icons.check_outlined, color: Colors.white),
          )));
    }
    else{
      items.add(StepperData(
          title: StepperText(
            "Delivered",
            textStyle: const TextStyle(
              color: Colors.black,
            ),
          ),
          iconWidget: Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.all(Radius.circular(30))),
            child: const Icon(Icons.check_outlined, color: Colors.green),
          )));
    }

    return items;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tracking Details"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(25),
          child: FutureBuilder(
            future: getPackageDetails(),
            builder: (ctx, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                // If we got an error
                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      '${snapshot.error} occurred',
                      style: TextStyle(fontSize: 18),
                    ),
                  );

                  // if we got our data
                } else if (snapshot.hasData) {
                  // Extracting data from snapshot object
                  List<StepperData> data = snapshot.data!;
                  return AnotherStepper(
                    stepperList: data,
                    stepperDirection: Axis.vertical,
                    activeBarColor: kPrimaryColor,
                    inActiveBarColor: Colors.black,
                    activeIndex: index,
                  );
                }
              }

              // Displaying LoadingSpinner to indicate waiting state
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ),
    );
  }
}
