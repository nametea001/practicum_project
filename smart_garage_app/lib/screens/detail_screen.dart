import 'package:flutter/material.dart';
import 'package:packing/models/garage.dart';
import 'package:packing/models/user.dart';

class DetailScreen extends StatefulWidget {
  final User? user;
  final int? garageId;
  final String? garageName;
  DetailScreen({
    this.user,
    this.garageId,
    this.garageName,
  });

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  String garageName = "";
  int garageId = 0;
  User user = User();

  @override
  void initState() {
    super.initState();
    garageId = (widget.garageId)!;
    garageName = (widget.garageName)!;
    user = (widget.user)!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${garageName}"),
        backgroundColor: Colors.orange,
        actions: [
          IconButton(
            icon: Icon(Icons.camera_alt_outlined),
            onPressed: () async {
              // var result = await BarcodeScanner.scan();
              // if (result.rawContent == "SMART_GARAGE_1") {
              //   print("GG");
              // }
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
                TextButton(
                  child: Column(
                    children: [
                      Icon(Icons.lock_open_outlined,
                          size: 140.0, color: Colors.green),
                      Text(
                        "Unlock",
                        style: TextStyle(
                          fontSize: 28.0,
                          color: Colors.black,
                        ),
                      )
                    ],
                  ),
                  onPressed: () async {
                    await Garage.openGarage(garageId);
                  },
                ),
                TextButton(
                  child: Column(
                    children: [
                      Icon(Icons.lock_outline,
                          size: 140.0, color: Colors.black),
                      Text(
                        "Lock",
                        style: TextStyle(
                          fontSize: 28.0,
                          color: Colors.black,
                        ),
                      )
                    ],
                  ),
                  onPressed: () async {
                    await Garage.closeGarage(garageId);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
