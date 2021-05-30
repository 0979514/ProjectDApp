import 'package:flutter/material.dart';
import 'package:projectd/classes/User.dart';

class ChooseGoalScreen extends StatefulWidget {
  const ChooseGoalScreen({Key key}) : super(key: key);

  @override
  _ChooseGoalScreenState createState() => _ChooseGoalScreenState();
}

class _ChooseGoalScreenState extends State<ChooseGoalScreen> {

  Map data = {};


  @override
  Widget build(BuildContext context) {

    data = data.isNotEmpty ? data : ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text("Choose Goal"),
      ),
      body: Text(data['measurement']),
    );
  }
}
