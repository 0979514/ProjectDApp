import 'dart:ffi';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class ChooseGoalScreen extends StatefulWidget {
  const ChooseGoalScreen({Key key}) : super(key: key);

  @override
  _ChooseGoalScreenState createState() => _ChooseGoalScreenState();
}

DateTime _date;
int _hoursAWeek;
String phase = "pickDate";

Future<String> get _localPath async {
  final directory = await getExternalStorageDirectory();

  return directory.path;
}

Future<File> get _localFile async {
  final path = await _localPath;
  var file = File('$path/test.json');
  if (await file.exists() == false) {
    File('$path/test.json').create();
    print("file created");
  }
  return File('$path/test.json');
}

Future<Map> getData() async {
  try {
    final file = await _localFile;
    // Read the file
    final contents = await file.readAsString();
    return jsonDecode(contents);
  } catch (e) {
    // If encountering an error, return 0
    return null;
  }
}

Future<File> publishDate() async {
  final file = await _localFile;
  final map = await getData();
  map['Date']['Year'] = _date.year;
  map['Date']['Month'] = _date.month;
  map['Date']['Year'] = _date.day;

  // Write the file
  return file.writeAsString('${jsonEncode(map)}');
}

Future<Void> tryAssignVars() async {
  try {
    final data = await getData();
    _date = DateTime(
        data['Date']['Year'], data['Date']['Month'], data['Date']['Day']);
  } catch (e) {}
}

DateTime getDay(int n) {
  DateTime today = DateTime.now();
  return today.add(Duration(days: n));
}

class _ChooseGoalScreenState extends State<ChooseGoalScreen> {
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
    tryAssignVars();
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
                              initialDate:
                                  DateTime.now().add(const Duration(days: 10)),
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
                        publishDate();
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
  }
}
