import 'package:flutter/material.dart';
import 'dart:convert';
import "package:yaml/yaml.dart";
import "package:flutter/services.dart" as sv;
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'dart:typed_data';

class ChooseGoalScreen extends StatefulWidget {
  const ChooseGoalScreen({Key key}) : super(key: key);

  @override
  _ChooseGoalScreenState createState() => _ChooseGoalScreenState();
}

//write to app path
Future<void> writeToFile(List<int> data, String path) {
  return new File(path).writeAsBytes(data);
}

class _ChooseGoalScreenState extends State<ChooseGoalScreen> {
  DateTime _date;
  int _hoursAWeek;
  String phase = "pickDate";

  void tryAssignVars() async {
    try {
      var yaml = loadYaml(
          await sv.rootBundle.loadString("assets/test.yaml"))['AccountDetails'];
      _date = DateTime(
          yaml['Date']['Year'], yaml['Date']['Month'], yaml['Date']['Day']);
    } catch (e) {
      print(e);
    }
  }

  void publishDate() async {
    final string = await sv.rootBundle.loadString("assets/test.yaml");
    var yaml = json.decode(json.encode(loadYaml(string)));
    yaml['AccountDetails']['Date']['Year'] = _date.year;
    yaml['AccountDetails']['Date']['Month'] = _date.month;
    yaml['AccountDetails']['Date']['Day'] = _date.day;

    var push = json.encode(yaml);
    var data = utf8.encode(push);

    final filename = 'test.yaml';
    String dir = (await getApplicationDocumentsDirectory()).path;
    writeToFile(data, '$dir/$filename');
    print('$dir/$filename');
  }

  @override
  Widget build(BuildContext context) {
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
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2001),
                              lastDate: DateTime(2022))
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
                        if (_hoursAWeek != null) {
                          Navigator.pushNamed(context, "/");
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
