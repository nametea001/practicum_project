import 'package:flutter/material.dart';
import 'package:smart_garage_app/models/garage.dart';
import 'package:smart_garage_app/models/user.dart';

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
        // onTap: () {
        //   showDialog(
        //     context: context,
        //     builder: (BuildContext context) => AlertDialog(
        //       title: Text('Details'),
        //       backgroundColor: Colors.white,
        //       content: SizedBox(
        //         width: 400.0,
        //         height: 100.0,
        //         child: Column(
        //           children: [
        //             Row(
        //               children: [
        //                 Flexible(
        //                   child: Text(
        //                     "${garage.customerName}",
        //                     style: TextStyle(
        //                       fontSize: 16.0,
        //                     ),
        //                   ),
        //                 )
        //               ],
        //             ),
        //             Row(
        //               children: [
        //                 Text(
        //                   "Tel No: ${customer.telNo} ",
        //                   style: TextStyle(
        //                     fontSize: 14.0,
        //                   ),
        //                 )
        //               ],
        //             ),
        //             Row(
        //               children: [
        //                 Text(
        //                   "Address: ${customer.address} ",
        //                   style: TextStyle(
        //                     fontSize: 14.0,
        //                   ),
        //                 ),
        //               ],
        //             ),
        //           ],
        //         ),
        //       ),
        //       actions: <Widget>[
        //         TextButton(
        //             child: Text('Close'),
        //             style: TextButton.styleFrom(
        //               primary: Colors.white,
        //               backgroundColor: Colors.blueGrey,
        //             ),
        //             onPressed: () {
        //               Navigator.pop(context);
        //             }),
        //       ],
        //     ),
        //   );
        // },
      );
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
        // actions: [
        //   IconButton(
        //     icon: Icon(Icons.camera_alt_outlined),
        //     onPressed: () {},
        //   )
        // ],
      ),
      body: Container(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Icon(Icons.garage_sharp,
                      size: 140.0, color: Colors.orange),
                ),
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
