import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:packing/models/user.dart';
import 'package:packing/models/garage.dart';
import 'package:packing/global.dart' as globals;
import 'package:packing/services/config_system.dart';
import 'package:packing/constants.dart';

import 'main_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String ip = '';
  String username = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Garage V1.0'),
        backgroundColor: Colors.orange,
        actions: [
          IconButton(
              icon: Icon(Icons.settings),
              onPressed: () async {
                if (globals.serverIP == "") {
                  globals.serverIP = await ConfigSystem.getServer();
                }
                await showDialog(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                          title: Text('Config server ip'),
                          content: Row(
                            children: <Widget>[
                              Icon(
                                Icons.important_devices,
                                color: Colors.orangeAccent,
                                size: 50.0,
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                              Expanded(
                                child: TextFormField(
                                  initialValue: globals.serverIP,
                                  textAlign: TextAlign.center,
                                  onChanged: (value) {
                                    //Do something with the user input.
                                    ip = value;
                                  },
                                  decoration: kTextFieldDecoration.copyWith(
                                      hintText: 'Enter Server IP'),
                                ),
                              )
                            ],
                          ),
                          actions: <Widget>[
                            TextButton(
                              child: Text('Save'),
                              style: TextButton.styleFrom(
                                primary: Colors.white,
                                backgroundColor: Colors.teal,
                              ),
                              onPressed: () {
                                globals.serverIP = ip;
                                ConfigSystem.setServer(globals.serverIP);
                                Navigator.pop(context);
                              },
                            ),
                            TextButton(
                                child: Text('Close'),
                                style: TextButton.styleFrom(
                                  primary: Colors.white,
                                  backgroundColor: Colors.blueGrey,
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                }),
                          ],
                        ));
              }),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height,
            maxWidth: MediaQuery.of(context).size.width,
          ),
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            Colors.amber.shade800,
            Colors.amber.shade600,
            Colors.amber.shade400,
          ], begin: Alignment.topLeft, end: Alignment.centerRight)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 36.0, horizontal: 24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Login",
                        style: GoogleFonts.balsamiqSans(
                          color: Colors.white,
                          fontSize: 65,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "Enter username and password for sign in",
                        style: GoogleFonts.balsamiqSans(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.w400),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 7,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(35),
                        topRight: Radius.circular(35),
                      )),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextField(
                            onChanged: (value) {
                              username = value;
                            },
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: BorderSide.none),
                                filled: true,
                                fillColor: Colors.blue.shade50,
                                hintText: "username",
                                hintStyle: GoogleFonts.balsamiqSans(),
                                prefixIcon: Icon(
                                  Icons.person,
                                  color: Colors.red.shade600,
                                ))),
                        SizedBox(height: 20.0),
                        TextField(
                            obscureText: true,
                            onChanged: (value) {
                              password = value;
                            },
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: BorderSide.none),
                                filled: true,
                                fillColor: Colors.blue.shade50,
                                hintText: "password",
                                hintStyle: GoogleFonts.balsamiqSans(),
                                prefixIcon: Icon(
                                  Icons.vpn_key,
                                  color: Colors.red.shade600,
                                ))),
                        Container(
                            child: Padding(
                          padding: const EdgeInsets.fromLTRB(179.7, 0, 0, 0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    "Forget your password?",
                                    style: GoogleFonts.balsamiqSans(
                                        color: Colors.red.shade900,
                                        decoration: TextDecoration.underline,
                                        fontStyle: FontStyle.italic),
                                  ))
                            ],
                          ),
                        )),
                        SizedBox(height: 30),
                        Container(
                            width: double.infinity,
                            child: RaisedButton(
                              onPressed: () async {
                                User? u =
                                    await User.checkLogin(username, password);
                                if (u != null) {
                                  print("Login success!!");
                                  List<Garage>? garages =
                                      await Garage.getGarageFromUserId(
                                          u.userID!);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => MainScreen(
                                                user: u,
                                                garages: garages,
                                              )));
                                } else {
                                  print("Login Fail");
                                  await showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                      title: Text('Error'),
                                      content: Text(
                                          'Incorrect username or password'),
                                      actions: <Widget>[
                                        TextButton(
                                            child: Text('Close'),
                                            style: TextButton.styleFrom(
                                              primary: Colors.white,
                                              backgroundColor: Colors.blueGrey,
                                            ),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            }),
                                      ],
                                    ),
                                  );
                                }
                              },
                              color: Colors.amber.shade400,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                child: Text(
                                  "Login",
                                  style: GoogleFonts.balsamiqSans(
                                      color: Colors.black, fontSize: 16),
                                ),
                              ),
                            )),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
