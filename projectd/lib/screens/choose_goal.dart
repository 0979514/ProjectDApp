import 'package:flutter/material.dart';

class ChooseGoalScreen extends StatefulWidget {
  const ChooseGoalScreen({Key key}) : super(key: key);

  @override
  _ChooseGoalScreenState createState() => _ChooseGoalScreenState();
}

class _ChooseGoalScreenState extends State<ChooseGoalScreen> {
  DateTime _date;
  int _hoursAWeek;
  String phase = "pickDate";

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
                              firstDate: DateTime.now(),
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
                        setState(() {});
                      }
                      else {
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
                    Text("How many hours do you have a week?")
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
                        if (_hoursAWeek < 64 && _hoursAWeek > 1 && _hoursAWeek != 0 ) {
                          phase = "pickDate";
                          Navigator.pushNamed(context, "/");
                        }
                        else {
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
