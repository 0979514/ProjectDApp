import 'package:flutter/material.dart';

class MeasurementScreen extends StatefulWidget {
  const MeasurementScreen({Key key}) : super(key: key);

  @override
  _MeasurementScreenState createState() => _MeasurementScreenState();
}

class _MeasurementScreenState extends State<MeasurementScreen> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
///else if (phase == "BeforeMagicMile") {
//       return Scaffold(
//         body: Column(
//           children: <Widget>[
//             Expanded(
//               child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: <Widget>[
//                     Text("You have to do the One mile time trial")
//                   ]),
//             ),
//             Expanded(
//                 child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: <Widget>[
//                       Container(
//                           width: 100,
//                           child: TextField(
//                               onChanged: (nieuwtext) {
//                                 int BeforeMagicMileTime = int.parse(nieuwtext);
//                               },
//                               textAlign: TextAlign.left,
//                               keyboardType: TextInputType.number,
//                               decoration: InputDecoration(
//                                 border: InputBorder.none,
//                                 hintText: 'Magic Mile',
//                                 hintStyle: TextStyle(color: Colors.grey),
//                               )))
//                     ])),
//             Expanded(
//               child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: <Widget>[
//                     RaisedButton(
//                       child: Text('Back'),
//                       onPressed: () {
//                           phase = "pickHours";
//                           setState(() {});
//                         },
//                     ),
//                     RaisedButton(
//                       child: Text('Finish'),
//                       onPressed: () {
//                         Navigator.pushNamed(context, "/");
//                         phase = "pickDate";
//                         setState(() {});
//                       },
//                     )
//                   ]),
//             )
//           ],
//         ),
//       );
//
//     }
