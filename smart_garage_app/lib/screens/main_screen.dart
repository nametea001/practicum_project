import 'package:flutter/material.dart';
import 'package:packing/models/garage.dart';
import 'package:packing/models/user.dart';
import 'package:packing/screens/detail_screen.dart';
import 'package:barcode_scan2/barcode_scan2.dart';

class MainScreen extends StatefulWidget {
  final User? user;
  final List<Garage>? garages;
  MainScreen({
    this.user,
    this.garages,
  });

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Garage> garages = [];
  User user = User();
  int i = 0;

  TextEditingController controllerQty = TextEditingController();

  listColor(num) {
    if (num % 2 == 0) {
      var color = Color.fromRGBO(235, 235, 239, 1);
      return color;
    } else {
      var color = Color.fromRGBO(250, 250, 250, 1);
      return color;
    }
  }

  dateAndTime(dt) {
    var dt2 = dt.split("T");
    var dt3 = dt2[1].split(":");
    var dateTime = "Parking date " + dt2[0] + " " + dt3[0] + ":" + dt3[1];
    return dateTime;
  }

  List<ListTile> getListTile() {
    List<ListTile> list = [];
    for (var garage in garages) {
      i++;
      var l = ListTile(
          title: Text(garage.name!),
          tileColor: listColor(i),
          subtitle: Column(
            children: [
              Row(
                children: [
                  Text("${garage.status!}"),
                ],
              ),
              Row(
                children: [
                  Text(dateAndTime(garage.dateTime)),
                ],
              ),
            ],
          ),
          onTap: () {
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //         builder: (context) => DetailScreen(
            //               user: user,
            //               garageId: garage.id,
            //               garageName: garage.name,
            //             )));

            showDialog(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: Text("${garage.name}"),
                content: Text('Do you want open the door '),
                actions: <Widget>[
                  TextButton(
                    child: Text('Yes'),
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: Colors.green,
                    ),
                    onPressed: () async {
                      await showDialog(
                        context: context,
                        builder: (context) {
                          return StatefulBuilder(builder:
                              (BuildContext context, StateSetter setState) {
                            return AlertDialog(
                              title: Text("Confirm"),
                              content: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    children: [
                                      Text("Enter Password"),
                                    ],
                                  ),
                                  Row(children: [
                                    Text("Password: "),
                                    Expanded(
                                      child: TextFormField(
                                        controller: controllerQty,
                                        decoration: InputDecoration(
                                            hintText: "Password"),
                                      ),
                                    ),
                                  ]),
                                ],
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () async {
                                    var password = controllerQty.text;
                                    var check = await User.checkOpenGarage(
                                        user.userID!, password);
                                    if (check != null) {
                                      await Garage.openGarage(garage.id!);
                                    } else {
                                      await showDialog(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            AlertDialog(
                                          title: Text('Error'),
                                          content: Text('Incorrect password'),
                                          actions: <Widget>[
                                            TextButton(
                                                child: Text('Close'),
                                                style: TextButton.styleFrom(
                                                  primary: Colors.white,
                                                  backgroundColor:
                                                      Colors.blueGrey,
                                                ),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                }),
                                          ],
                                        ),
                                      );
                                      controllerQty.text = "";
                                    }
                                  },
                                  child: Text('Yes'),
                                  style: TextButton.styleFrom(
                                    primary: Colors.white,
                                    backgroundColor: Colors.red,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    controllerQty.text = "";
                                  },
                                  child: Text("No"),
                                  style: TextButton.styleFrom(
                                    primary: Colors.white,
                                    backgroundColor: Colors.blue[400],
                                  ),
                                ),
                              ],
                            );
                          });
                        },
                      );
                      updateUI();
                      Navigator.pop(context);
                    },
                  ),
                  TextButton(
                      child: Text('No'),
                      style: TextButton.styleFrom(
                        primary: Colors.white,
                        backgroundColor: Colors.red,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                ],
              ),
            );
          });
      list.add(l);
    }
    return list;
  }

  @override
  void initState() {
    super.initState();
    garages = (widget.garages ?? []).toList();
    user = (widget.user)!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Garage"),
        backgroundColor: Colors.orange,
        actions: [
          IconButton(
            icon: Icon(Icons.camera_alt_outlined),
            onPressed: () async {
              var result = await BarcodeScanner.scan();
            },
          )
        ],
      ),
      body: Container(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(Icons.garage_sharp, size: 140.0, color: Colors.orange),
              ],
            ),
            Expanded(
                child: RefreshIndicator(
              onRefresh: () async {
                updateUI();
              },
              child: ListView(
                children: getListTile(),
              ),
            ))
          ],
        ),
      ),
    );
  }

  Future updateUI() async {
    List<Garage>? tempDetails = await Garage.getGarageFromUserId(user.userID!);
    setState(() {
      garages = tempDetails ?? [];
    });
  }
}
