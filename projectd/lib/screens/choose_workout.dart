import 'package:flutter/material.dart';
import 'package:projectd/classes/Exercise.dart';
import '../ExerciseCard.dart';

class ChooseWorkoutScreen extends StatefulWidget {
  const ChooseWorkoutScreen({Key key}) : super(key: key);

  @override
  _ChooseWorkoutScreenState createState() => _ChooseWorkoutScreenState();
}

class _ChooseWorkoutScreenState extends State<ChooseWorkoutScreen> {
  Map data = {};

  List<Exercise> exercises = [
    Exercise(points: 1000, text: 'Train Endurance: Ren'),
    Exercise(points: 500, text: 'Active Rest: Walk '),
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
