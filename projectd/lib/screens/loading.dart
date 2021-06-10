import 'package:flutter/material.dart';
import 'package:projectd/classes/User.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key key}) : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  void SetupFitbitData() async {
    User user = User();
    await user.GetData();
    final prefs = await SharedPreferences.getInstance();
    try {
      prefs.getString("measurement");
    } catch (e) {
      prefs.setString("measurement", "00:00:00");
    }

    Navigator.pushReplacementNamed(context, '/home', arguments: {
      'name': user.name,
      'age': user.age,
      'gender': user.gender,
      'avatar': user.avatar,
      'restheartrate': user.restheartrate,
      'restheartrateweek': user.restheartrateweek,
      'sleepscore': user.sleepscore,
      'measurement': (prefs.getString("measurement")),
      'goal': user.goal
    });
  }

  //Get Data from Fitbit first run
  @override
  void initState() {
    super.initState();

    SetupFitbitData();
  }

  @override
  Widget build(BuildContext context) {
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
