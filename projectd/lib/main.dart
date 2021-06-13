import 'package:flutter/material.dart';
import 'package:projectd/screens/loading.dart';
import 'package:projectd/screens/home.dart';
import 'package:projectd/screens/measurement.dart';
import 'package:projectd/screens/choose_goal.dart';
import 'package:projectd/screens/choose_workout.dart';
import 'package:projectd/screens/workout.dart';


void main() => runApp(MaterialApp(
  initialRoute: '/',
  routes: {
    '/': (context) => LoadingScreen(),
    '/home' : (context) => HomeScreen(),
    '/measurement' : (context) => MeasurementScreen(),
    '/goal' : (context) => ChooseGoalScreen(),
    '/chooseworkout' : (context) => ChooseWorkoutScreen(),
    '/workout' : (context) => WorkoutScreen(),
  },
));