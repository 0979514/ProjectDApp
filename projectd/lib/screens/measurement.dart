import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:projectd/classes/User.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MeasurementScreen extends StatefulWidget {
  const MeasurementScreen({Key key}) : super(key: key);

  @override
  _MeasurementScreenState createState() => _MeasurementScreenState();
}

_loadMeasurement() async {
  final prefs = await SharedPreferences.getInstance();
  try {
    measurement = prefs.getString("measurement");
  } catch (e) {}
}

_saveMeasurement(String s) async {
  final prefs = await SharedPreferences.getInstance();
  try {
    prefs.setString("measurement", s);
  } catch (e) {
    print("saving went wrong");
  }
}

var measurement = '0';

class _MeasurementScreenState extends State<MeasurementScreen> {
  final TextEditingController tcontroller = new TextEditingController();

  String phase = 'notloading';

  String GetMinute(String x) {
    int seconds = int.parse(x);
    int secondsminute = seconds - (seconds % 60);
    String minutes = (secondsminute / 60).toString();
    return minutes;
  }

  @override
  Widget build(BuildContext context) {
    _loadMeasurement();
    if (phase == 'notloading') {
      return Scaffold(
        appBar: AppBar(
          title: Text("Measurement"),
          centerTitle: true,
          backgroundColor: Colors.blue[400],
          elevation: 0.0,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 0.0),
            child: Column(
              children: <Widget>[
                Center(
                    child: Text(
                  'What to do',
                  style: TextStyle(
                    letterSpacing: 1.0,
                    fontWeight: FontWeight.bold,
                    fontSize: 30.0,
                  ),
                )),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  '1. Warm up your body with a slow 5 - 10 minute run   ',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 15.0,
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  '2. Now measure the time for the Magic Mile                ',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 15.0,
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  '3. Run about as hard as you can for one mile               ',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 15.0,
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  '4. Pace yourself as even as possible on each quarter mile',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 15.0,
                  ),
                ),
                SizedBox(
                  height: 40.0,
                ),
                Text(
                  'Enter how long it took, in seconds',
                  style: TextStyle(
                    fontSize: 15.0,
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  padding: EdgeInsets.all(20),
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.black)),
                  child: TextField(
                      decoration: new InputDecoration(
                        hintText: "Enter in seconds",
                      ),
                      keyboardType: TextInputType.number,
                      onSubmitted: (String str) {
                        setState(() {
                          //Er zijn nog bugs met invoer bijv crash als je . , of andere tekens erin zet
                          measurement = str != '' ? str : '0';
                        });
                        tcontroller.text = "";
                        GetMinute(measurement);
                      },
                      controller: tcontroller),
                ),
                SizedBox(height: 20.0),
                Text("So your time is: $measurement seconds?"),
                SizedBox(height: 20.0),
                Text("Confirm that your time is"),
                SizedBox(height: 10.0),
                Text(
                    "${GetMinute(measurement)} minutes and ${int.parse(measurement) % 60}.0 seconds"),
                SizedBox(height: 10.0),
                FlatButton(
                    color: Colors.blue,
                    onPressed: () {
                      print("measurement = $measurement");
                      //calculate marathon speed

                      _saveMeasurement(measurement);
                      Navigator.pop(
                        context,
                      );
                      setState(() {
                        phase = 'loading';
                      });
                    },
                    child: Text('Update current pace')),
              ],
            ),
          ),
        ),
      );
    } else {
      return Scaffold(
        body: Center(
          child: SpinKitPumpingHeart(
            color: Colors.pink,
            size: 100.0,
          ),
        ),
      );
    }
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
