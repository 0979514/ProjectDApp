import 'package:flutter/material.dart';
import 'package:projectd/ExerciseCard.dart';
import 'package:projectd/classes/Exercise.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WorkoutScreen extends StatefulWidget {
  const WorkoutScreen({Key key}) : super(key: key);

  @override
  _WorkoutScreenState createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen> {
  Map data = {};
  int workoutplan;
  String message;

  List<Exercise> exercises1 = [
    Exercise(points: 50, text: '15 minutes of jogging'),
    Exercise(points: 400, text: '2000 meter moderate pace run'),
    Exercise(points: 500, text: '600 meter high pace run'),
    Exercise(points: 400, text: '1000 meter moderate pace run'),
    Exercise(points: 100, text: '10 minutes of walking'),
    Exercise(points: 100, text: '5 minutes of stretching'),
  ];

  List<Exercise> exercises2 = [
    Exercise(points: 50, text: '10 minutes of jogging'),
    Exercise(points: 100, text: '1600 meter moderate pace run'),
    Exercise(points: 200, text: '500 meter high pace run'),
    Exercise(points: 300, text: '750 meter minute moderate pace run'),
    Exercise(points: 100, text: '8 minutes of walking'),
    Exercise(points: 100, text: '5 minutes of stretching'),
  ];
  List<Exercise> exercises3 = [
    Exercise(points: 100, text: '8 minutes of jogging'),
    Exercise(points: 300, text: '1400 meter moderate pace run'),
    Exercise(points: 200, text: '400 meter high pace run'),
    Exercise(points: 300, text: '500 meter minute moderate pace run'),
    Exercise(points: 100, text: '6 minutes of walking'),
    Exercise(points: 100, text: '5 minutes of stretching'),
  ];
  List<Exercise> exercisesextra = [
    Exercise(points: 50, text: '15 minutes of jogging'),
    Exercise(points: 200, text: '400 meter moderate pace run'),
    Exercise(points: 250, text: '5000 steps walk'),
    Exercise(points: 150, text: '15 minutes of stretching'),
  ];
  _readWorkoutPlan() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getInt("workoutplan") == null) {
      prefs.setInt("workoutplan", -1);
    }
    workoutplan = prefs.getInt("workoutplan");
    setState(() {});
  }

  _savePoints() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt("points", data['points']);
  }

  List<Exercise> plan;
  @override
  Widget build(BuildContext context) {
    data = data.isNotEmpty ? data : ModalRoute.of(context).settings.arguments;
    _readWorkoutPlan();

    switch (workoutplan) {
      case 1:
        {
          message = "Complete this workout twice a week";
          plan = exercises1;
          break;
        }
      case 2:
        {
          message = "Complete this workout three times a week";

          plan = exercises2;
          break;
        }
      case 3:
        {
          message = "Complete this workout five times a week";

          plan = exercises3;

          break;
        }
      default:
        {
          message =
              "you didn't sleep well today, maybe try this lighter workout";

          plan = exercisesextra;
          break;
        }
    }
    if (data['sleepscore'] != '0.0' && double.parse(data['sleepscore']) < 5.5)
      plan = exercisesextra;
    return Scaffold(
      appBar: AppBar(
        title: Text("Workout"),
        centerTitle: true,
        backgroundColor: Colors.blue[400],
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: 10.0),
            Text("Total Points: ${data['points']}"),
            SizedBox(height: 10.0),
            Text(message),
            Column(
              children: plan
                  .map((exercise) => ExerciseCard(
                      exercise: exercise,
                      delete: () => this.setState(() {
                            plan.remove(exercise);
                            data['points'] = data['points'] + exercise.points;
                            print(data['points']);
                            _savePoints();
                          })))
                  .toList(),
            ),
            SizedBox(
              height: 10.0,
            ),
            Center(
              child: FlatButton(
                  color: Colors.blue,
                  onPressed: () {
                    Navigator.pop(context, {
                      'name': data['name'],
                      'age': data['age'],
                      'gender': data['gender'],
                      'avatar': data['avatar'],
                      'restheartrate': data['restheartrate'],
                      'restheartrateweek': data['restheartrateweek'],
                      'sleepscore': data['sleepscore'],
                      'measurement': data['measurement'],
                      'goal': data['goal'],
                      'points': data['points']
                    });
                  },
                  child: Text('Finish Workout')),
            ),
          ],
        ),
      ),
    );
  }
}
