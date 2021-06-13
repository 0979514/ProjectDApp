import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ChooseWorkoutScreen extends StatefulWidget {
  const ChooseWorkoutScreen({Key key}) : super(key: key);

  @override
  _ChooseWorkoutScreenState createState() => _ChooseWorkoutScreenState();
}

class _ChooseWorkoutScreenState extends State<ChooseWorkoutScreen> {
  void exit() {
    _saveWorkoutPlan();
    Navigator.pop(context);
  }

  _readWorkoutPlan() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getInt("workoutplan") == null) {
      prefs.setInt("workoutplan", -1);
    }
    workoutplan = prefs.getInt("workoutplan");
    setState(() {});
  }

  _saveWorkoutPlan() async {
    final prefs = await SharedPreferences.getInstance();

    prefs.setInt("workoutplan", workoutplan);
  }

  _readHoursAWeek() async {
    final prefs = await SharedPreferences.getInstance();
    hoursaweek = prefs.getInt("hours-a-week");
    setState(() {});
  }

  int workoutplan;
  int hoursaweek;
  @override
  Widget build(BuildContext context) {
    _readHoursAWeek();
    _readWorkoutPlan();
    return Scaffold(
      appBar: AppBar(
        title: Text("Set Goal"),
        centerTitle: true,
        backgroundColor: Colors.blue[400],
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 0.0),
          child: Center(
            child: Column(children: <Widget>[
              FlatButton(
                  color: Colors.blue,
                  onPressed: () {
                    workoutplan = 1;
                    exit();
                  },
                  child: Center(
                    child: Text(
                        "2 days a week workout plan ${workoutplan == 1 ? "| current" : ""} ${hoursaweek <= 2 ? "| Recommended" : ""}"),
                  )),
              FlatButton(
                  color: Colors.blue,
                  onPressed: () {
                    workoutplan = 2;
                    exit();
                  },
                  child: Center(
                    child: Text(
                        "3 days a week workout plan ${workoutplan == 2 ? "| current" : ""} ${2 < hoursaweek && hoursaweek <= 5 ? "| Recommended" : ""}"),
                  )),
              FlatButton(
                  color: Colors.blue,
                  onPressed: () {
                    workoutplan = 3;
                    exit();
                  },
                  child: Center(
                    child: Text(
                        "5 days a week workout plan ${workoutplan == 3 ? "| current" : ""} ${hoursaweek > 5 ? "| Recommended" : ""}"),
                  )),
              FlatButton(
                  color: Colors.blue,
                  onPressed: () {
                    workoutplan = -1;
                    exit();
                  },
                  child: Center(
                    child: Text("Remove workout"),
                  )),
            ]),
          ),
        ),
      ),
    );
  }
}
