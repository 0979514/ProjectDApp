import 'package:flutter/material.dart';
import 'package:projectd/classes/Exercise.dart';
import 'classes/Exercise.dart';

class ExerciseCard extends StatelessWidget {

  final Exercise exercise;
  final Function delete;

  ExerciseCard({this.exercise, this.delete});

  @override
  Widget build(BuildContext context) {

    return Card(
      margin: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                exercise.text,
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 6.0,),
              Text(
                "${exercise.points.toString()} Points",
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.grey[900],
                ),
              ),
              SizedBox(height: 6.0,),
              FlatButton.icon(
                onPressed: delete,
                label: Text("Finished"),
                icon: Icon(Icons.favorite),
                color: Colors.red,
              ),
            ]
        ),
      ),
    );
  }
}