import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class ChooseGoalScreen extends StatefulWidget {
  const ChooseGoalScreen({Key key}) : super(key: key);

  @override
  _ChooseGoalScreenState createState() => _ChooseGoalScreenState();
}

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
    _goalhour = prefs.getInt('goal-hours');
    _goalminute = prefs.getInt('goal-minutes');
    _goalsecond = prefs.getInt('goal-seconds');
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
    data = data.isNotEmpty ? data : ModalRoute.of(context).settings.arguments;

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
                    Text(_goalhour == null &&
                            _goalminute == null &&
                            _goalsecond == null
                        ? 'Please enter the time you\'d like to achieve'
                        : "Time: $_goalhour:$_goalminute:$_goalsecond")
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
                            width: 40,
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
                            width: 40,
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
                            width: 40,
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
                          print(data);

                          var time = data['measurement'].split(":");
                          var secondsMeasurement = int.parse(time[0]) * 3600 +
                              int.parse(time[1]) * 60 +
                              int.parse(time[2]);

                          if (_goalhour != null &&
                              _goalminute != null &&
                              _goalsecond != null) {
                            var secondsCur = _goalhour * 3600 +
                                _goalminute * 60 +
                                _goalsecond;
                            if (secondsCur > secondsMeasurement) {
                              Navigator.pop(context);
                              phase = "pickGoal";
                            } else {
                              phase = "pickDate";
                              setState(() {});
                            }

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
                          Navigator.pop(context);
                          _saveDate();
                          _saveGoal();
                          _saveHours();
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
