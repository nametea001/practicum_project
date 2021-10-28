import 'package:flutter/material.dart';
import 'package:smart_garage_app/screens/login_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: LoginScreen());
  }
}

// import 'package:flutter/material.dart';

// void main() {
//   runApp(MaterialApp(
//     home: MyApp(),
//   ));
// }

// class MyApp extends StatefulWidget {
//   @override
//   _State createState() => _State();
// }

// class _State extends State<MyApp> {
//   final List<String> names = <String>[];
//   final List<int> msgCount = <int>[];

//   TextEditingController nameController = TextEditingController();

//   void addItemToList(){
//     setState(() {
//       names.insert(0,nameController.text);
//       msgCount.insert(0, 0);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Flutter Tutorial - googleflutter.com'),
//       ),
//       body: Column(
//         children: <Widget>[
//           Padding(
//             padding: EdgeInsets.all(20),
//             child: TextField(
//               controller: nameController,
//               decoration: InputDecoration(
//                 border: OutlineInputBorder(),
//                 labelText: 'Contact Name',
//               ),
//             ),
//           ),
//           RaisedButton(
//             child: Text('Add'),
//             onPressed: () {
//               addItemToList();
//             },
//           ),
//           Expanded(
//             child: ListView.builder(
//               padding: const EdgeInsets.all(8),
//               itemCount: names.length,
//               itemBuilder: (BuildContext context, int index) {
//                 return Container(
//                   height: 50,
//                   margin: EdgeInsets.all(2),
//                   color: msgCount[index]>=10? Colors.blue[400]:
//                     msgCount[index]>3? Colors.blue[100]: Colors.grey,
//                   child: Center(
//                     child: Text('${names[index]} (${msgCount[index]})',
//                       style: TextStyle(fontSize: 18),
//                     )
//                   ),
//                 );
//               }
//             )
//           )
//         ]
//       )
//     );
//   }
// }
