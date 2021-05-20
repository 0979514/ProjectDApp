import 'package:flutter/material.dart';

class ChooseGoalScreen extends StatefulWidget {
  const ChooseGoalScreen({Key key}) : super(key: key);

  @override
  _ChooseGoalScreenState createState() => _ChooseGoalScreenState();
}

class _ChooseGoalScreenState extends State<ChooseGoalScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Set Goal"),
          centerTitle: true,
          backgroundColor: Colors.blue[400],
          elevation: 0.0,
        ),
        body: Padding(padding: EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 0.0)));
  }
}
