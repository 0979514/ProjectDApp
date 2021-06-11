import 'package:flutter/material.dart';
import 'package:projectd/ExerciseCard.dart';
import 'package:projectd/classes/Exercise.dart';
import 'package:projectd/classes/User.dart';

class WorkoutScreen extends StatefulWidget {
  const WorkoutScreen({Key key}) : super(key: key);

  @override
  _WorkoutScreenState createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen> {

  Map data = {};

  List<Exercise> exercises = [
    Exercise(points: 100, text: '100 push ups (example)'),
    Exercise(points: 300, text: '300 push ups (example)'),
    Exercise(points: 600, text: '600 push ups (example)'),
    Exercise(points: 900, text: '900 push ups (example)'),
    Exercise(points: 1100, text: '1100 push ups (example)'),
  ];

  @override
  Widget build(BuildContext context) {

    data = data.isNotEmpty ? data : ModalRoute.of(context).settings.arguments;



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
            Column(
              children: exercises.map((exercise) => ExerciseCard(
                  exercise:exercise,
                  delete: () => this.setState(() {
                    exercises.remove(exercise);
                    data['points'] = data['points'] + exercise.points;
                    print(data['points']);
                  })
              )).toList(),
            ),
            SizedBox(height: 10.0,),
            Center(
              child: FlatButton(
                  color: Colors.blue,
                  onPressed: (){
                    Navigator.pop(context, {
                      'name' : data['name'],
                      'age' : data['age'],
                      'gender' : data['gender'],
                      'avatar' : data['avatar'],
                      'restheartrate' : data['restheartrate'],
                      'restheartrateweek' : data['restheartrateweek'],
                      'sleepscore' : data['sleepscore'],
                      'measurement' : data['measurement'],
                      'goal' : data['goal'],
                      'points' : data['points']
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
