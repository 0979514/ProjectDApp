import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:projectd/classes/User.dart';

class ChooseGoalScreen extends StatefulWidget {
  const ChooseGoalScreen({Key key}) : super(key: key);

  @override
  _ChooseGoalScreenState createState() => _ChooseGoalScreenState();
}

DateTime _date;
int _hoursAWeek;
String phase = "pickDate";
bool loading = false;

_read() async {
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

_save() async {
  final prefs = await SharedPreferences.getInstance();
  try {
    prefs.remove('goal-year');

    prefs.setInt('goal-year', _date.year);
    prefs.remove('goal-month');
    prefs.setInt('goal-month', _date.month);
    prefs.remove('goal-day');
    prefs.setInt('goal-day', _date.day);
    print(_date);
  } catch (e) {
    print("Saving went wrong");
  }
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

    _read();
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
    if (_date != null) {
      if (phase == "pickDate") {
        return Scaffold(
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
                      child: Text('Back'),
                      onPressed: () {
                        Navigator.pushNamed(context, "/");
                      },
                    ),
                    RaisedButton(
                      child: Text('Next'),
                      onPressed: () {
                        if (_date != null) {
                          phase = "pickHours";
                          _save();
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
                        child: Text('Back'),
                        onPressed: () {
                          if (_date != null) {
                            phase = "pickDate";
                            setState(() {});
                          }
                        },
                      ),
                      RaisedButton(
                        child: Text('Finish'),
                        onPressed: () {
                          if (_hoursAWeek < 64 &&
                              _hoursAWeek > 1 &&
                              _hoursAWeek != 0) {
                            phase = "pickDate";
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
