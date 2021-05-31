import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class ChooseGoalScreen extends StatefulWidget {
  const ChooseGoalScreen({Key key}) : super(key: key);

  @override
  _ChooseGoalScreenState createState() => _ChooseGoalScreenState();
}

DateTime _goal;
int _goalhour;
int _goalminute;
int _goalsecond;
DateTime _date;
int _hoursAWeek;
String phase = "pickGoal";
bool loading = false;

_readDate() async {
  final prefs = await SharedPreferences.getInstance();
  try {
    var year = prefs.getInt('goal-year');
    var month = prefs.getInt('goal-month');
    var day = prefs.getInt('goal-day');
    print("$year, $month, $day");
    _date = DateTime(year, month, day);
  } catch (e) {
    print("Reading went wrong");
  }
}

_readGoal() async {
  final prefs = await SharedPreferences.getInstance();
  try {
    var hours = prefs.getInt('goal-hours');
    var minutes = prefs.getInt('goal-minutes');
    var seconds = prefs.getInt('goal-seconds');

    _date = DateTime.fromMicrosecondsSinceEpoch(
        (hours * 3600 + minutes * 60 + seconds) * 1000);
  } catch (e) {
    print("Reading went wrong");
  }
}

_readhours() async {
  final prefs = await SharedPreferences.getInstance();
  try {
    _hoursAWeek = prefs.getInt('hours-a-week');
  } catch (e) {
    print("Reading went wrong");
  }
}

_saveDate() async {
  final prefs = await SharedPreferences.getInstance();
  try {
    prefs.setInt('goal-year', _date.year);
    prefs.setInt('goal-month', _date.month);
    prefs.setInt('goal-day', _date.day);
    print(_date);
  } catch (e) {
    print("Saving went wrong");
  }
}

_saveGoal() async {
  final prefs = await SharedPreferences.getInstance();
  try {
    prefs.setInt('goal-hours', _goalhour);
    prefs.setInt('goal-minutes', _goalminute);
    prefs.setInt('goal-seconds', _goalsecond);
  } catch (e) {}
}

_saveHours() async {
  final prefs = await SharedPreferences.getInstance();
  try {
    prefs.setInt('hours-a-week', _hoursAWeek);
  } catch (e) {}
}

DateTime getDay(int n) {
  DateTime today = DateTime.now();
  return today.add(Duration(days: n));
}

class _ChooseGoalScreenState extends State<ChooseGoalScreen> {
  Map data = {};

  @override
  void initState() {
    super.initState();
    _readGoal();
    _readDate();
    _readhours();
  }

  void _showAlertDialog() {
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text("Error"),
      content: Text("Invalid/incorrect data"),
      actions: [
        okButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (phase == "pickGoal") {
      return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text("Choose goal"),
            centerTitle: true,
            backgroundColor: Colors.blue[400],
            elevation: 0.0,
          ),
          body: Column(
            children: <Widget>[
              Expanded(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                    Text(_date == null
                        ? 'Please enter the time you\'d like to achieve'
                        : "Time: ${_goal.hour}:${_goal.minute}:${_goal.second}")
                  ])),
              Expanded(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                    Expanded(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                            width: 20,
                            child: TextField(
                                onChanged: (newtext) {
                                  _goalhour = int.parse(newtext);
                                },
                                textAlign: TextAlign.left,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(color: Colors.grey),
                                ))),
                        Text(":"),
                        Container(
                            width: 20,
                            child: TextField(
                                onChanged: (newtext) {
                                  _goalminute = int.parse(newtext);
                                },
                                textAlign: TextAlign.left,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(color: Colors.grey),
                                ))),
                        Text(":"),
                        Container(
                            width: 20,
                            child: TextField(
                                onChanged: (newtext) {
                                  _goalsecond = int.parse(newtext);
                                },
                                textAlign: TextAlign.left,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(color: Colors.grey),
                                )))
                      ],
                    ))
                  ])),
              Expanded(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      RaisedButton(
                        child: Text('Next'),
                        onPressed: () {
                          if (_date != null) {
                            phase = "pickDate";
                            _saveGoal();
                            setState(() {});
                          } else {
                            _showAlertDialog();
                            setState(() {});
                          }
                        },
                      )
                    ]),
              )
            ],
          ));
    } else if (phase == "pickDate") {
      return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text("Choose goal"),
            centerTitle: true,
            backgroundColor: Colors.blue[400],
            elevation: 0.0,
          ),
          body: Column(
            children: <Widget>[
              Expanded(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                    Text(_date == null
                        ? 'Please pick the date of the challenge'
                        : "Date of challenge: ${_date.day}/${_date.month}/${_date.year}")
                  ])),
              Expanded(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                    RaisedButton(
                        child: Text('Pick a date'),
                        onPressed: () {
                          showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now()
                                      .add(const Duration(days: 10)),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime(2024))
                              .then((date) {
                            setState(() {
                              _date = date;
                            });
                          });
                        })
                  ])),
              Expanded(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      RaisedButton(
                        child: Text('Next'),
                        onPressed: () {
                          if (_date != null) {
                            phase = "pickHours";
                            _saveDate();
                            setState(() {});
                          } else {
                            _showAlertDialog();
                            setState(() {});
                          }
                        },
                      )
                    ]),
              ),
              Expanded(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      RaisedButton(
                        child: Text('Back'),
                        onPressed: () {
                          phase = "pickGoal";
                          if (_date != null) {
                            _saveDate();
                          }
                          setState(() {});
                        },
                      )
                    ]),
              )
            ],
          ));
    } else if (phase == "pickHours") {
      return Scaffold(
        body: Column(
          children: <Widget>[
            Expanded(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(_hoursAWeek == null
                        ? "How many hours do you have a week?"
                        : "Hours: ${_hoursAWeek}")
                  ]),
            ),
            Expanded(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                  Container(
                      width: 100,
                      child: TextField(
                          onChanged: (newtext) {
                            _hoursAWeek = int.parse(newtext);
                          },
                          textAlign: TextAlign.left,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'enter hours',
                            hintStyle: TextStyle(color: Colors.grey),
                          )))
                ])),
            Expanded(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                      child: Text('Finish'),
                      onPressed: () {
                        if (_hoursAWeek < 64 &&
                            _hoursAWeek > 1 &&
                            _hoursAWeek != 0) {
                          phase = "pickGoal";
                          Navigator.pushNamed(context, "/");
                        } else {
                          _showAlertDialog();
                          setState(() {});
                        }
                      },
                    )
                  ]),
            )
          ],
        ),
      );
    }
  }
}
