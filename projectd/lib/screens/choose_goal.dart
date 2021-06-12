import 'package:projectd/classes/User.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class ChooseGoalScreen extends StatefulWidget {
  const ChooseGoalScreen({Key key}) : super(key: key);

  @override
  _ChooseGoalScreenState createState() => _ChooseGoalScreenState();
}

String _goal;
DateTime _date;
int _hoursAWeek;
String phase = "pickGoal";
bool loading = false;

String formatDateToString(DateTime x) {
  return "${x.year}/${x.month}/${x.day}";
}

String formatTimeToString(String x) {
  var y = x.split(":");
  return "${y[0].length == 1 ? "0" + y[0] : y[0]}:${y[1].length == 1 ? "0" + y[1] : y[1]}:00";
}

_readDate() async {
  final prefs = await SharedPreferences.getInstance();
  try {
    var x = prefs.getString('goaldate').split("/");
    if (x.length != 3)
      _date = DateTime(int.parse(x[0]), int.parse(x[1]), int.parse(x[2]));
    else
      _date = null;
  } catch (e) {
    print("Reading went wrong");
  }
}

_saveDate() async {
  final prefs = await SharedPreferences.getInstance();
  try {
    prefs.setString('goaldate', formatDateToString(_date));
    print(_date);
  } catch (e) {
    print("Saving went wrong");
  }
}

_saveGoal(String s) async {
  final prefs = await SharedPreferences.getInstance();
  try {
    prefs.setString("goal", s);
  } catch (e) {}
}

_readhours() async {
  final prefs = await SharedPreferences.getInstance();
  try {
    _hoursAWeek = prefs.getInt('hours-a-week');
  } catch (e) {
    print("Reading went wrong");
  }
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

  void _showLittleTime() {
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text("Error"),
      content: Text("goal has to be above 2 hours"),
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
                    Text(_goal == ""
                        ? 'Please enter the time you\'d like to achieve'
                        : "Time: ${formatTimeToString(data['goal'])}")
                  ])),
              Expanded(
                child: RaisedButton(
                    child: Text("Pick the time"),
                    onPressed: () => showTimePicker(
                                context: context,
                                initialTime: TimeOfDay(hour: 0, minute: 0))
                            .then((time) {
                          setState(() {
                            _goal = "${time.hour}:${time.minute}:00";
                            data['goal'] = _goal;
                            print("data = ${data['goal']}");
                            print("_goal = $_goal");
                          });
                        })),
              ),
              Expanded(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      RaisedButton(
                        child: Text('Next'),
                        onPressed: () {
                          if (int.parse(_goal.split(":")[0]) < 2) {
                            _showLittleTime();
                          } else {
                            var time = data['measurement'].split(":");
                            var secondsMeasurement = int.parse(time[0]) * 3600 +
                                int.parse(time[1]) * 60 +
                                int.parse(time[2]);

                            if (_goal != "") {
                              var secondsCur =
                                  int.parse(_goal.split(":")[0]) * 3600 +
                                      int.parse(_goal.split(":")[1]) * 60;

                              if (secondsCur > secondsMeasurement) {
                                _saveGoal(_goal);
                                Navigator.pop(context, {
                                  'name': data['name'],
                                  'age': data['age'],
                                  'gender': data['gender'],
                                  'avatar': data['avatar'],
                                  'restheartrate': data['restheartrate'],
                                  'restheartrateweek':
                                      data['restheartrateweek'],
                                  'sleepscore': data['sleepscore'],
                                  'measurement': data['measurement'],
                                  'goal': _goal,
                                  'points': data['points']
                                });
                              } else {
                                phase = "pickDate";
                                setState(() {});
                              }

                              setState(() {});
                            } else {
                              _showAlertDialog();
                              setState(() {});
                            }
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
                          _saveDate();
                          _saveGoal(_goal);
                          _saveHours();
                          Navigator.pop(context, {
                            'name': data['name'],
                            'age': data['age'],
                            'gender': data['gender'],
                            'avatar': data['avatar'],
                            'restheartrate': data['restheartrate'],
                            'restheartrateweek': data['restheartrateweek'],
                            'sleepscore': data['sleepscore'],
                            'measurement': data['measurement'],
                            'goal': _goal,
                            'points': data['points']
                          });
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
