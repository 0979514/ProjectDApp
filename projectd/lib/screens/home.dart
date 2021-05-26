import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  Map data = {};

  @override
  Widget build(BuildContext context) {

    data = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Home Screen"),
        centerTitle: true,
        backgroundColor: Colors.blue[400],
        elevation: 0.0,
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(30.0,40.0,30.0,0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: CircleAvatar(
                backgroundImage: NetworkImage(data['avatar']),
                radius: 70.0,
              ),
            ),
            SizedBox(height: 30.0,),
            Row(
              children: <Widget>[
                Expanded(
                  flex: 6,
                  child: Text("Name ${data['name']}",
                      style: TextStyle(
                        color: Colors.black,
                        letterSpacing: 1.0,
                        fontWeight: FontWeight.bold,
                      )),
                ),
                SizedBox(width: 10.0),
                Icon(
                  Icons.directions_run,
                  color: Colors.black,
                ),
                SizedBox(width: 5.0),
                Expanded(
                  flex: 6,
                  child: Text("Level",
                      style: TextStyle(
                        color: Colors.black,
                        letterSpacing: 1.0,
                        fontWeight: FontWeight.bold,
                      )),
                ),
                Expanded(
                  flex: 1,
                  child: Text("0",
                      style: TextStyle(
                        color: Colors.red,
                        letterSpacing: 1.0,
                        fontWeight: FontWeight.bold,
                      )),
                ),
              ],
            ),

            SizedBox(height: 10.0,),
            Row(
              children: <Widget>[
                Expanded(
                  flex: 6,
                  child: Text("Age ${data['age']}",
                      style: TextStyle(
                        color: Colors.black,
                        letterSpacing: 1.0,
                        fontWeight: FontWeight.bold,
                      )),
                ),
                SizedBox(width: 10.0),
                Icon(
                  Icons.favorite,
                  color: Colors.pink,
                ),
                SizedBox(width: 5.0,),
                Expanded(
                  flex: 6,
                  child: Text("Heartrate",
                      style: TextStyle(
                        color: Colors.black,
                        letterSpacing: 1.0,
                        fontWeight: FontWeight.bold,
                      )),
                ),
                Expanded(
                  flex: 1,
                  child: Text(data['restheartrate'],
                      style: TextStyle(
                        color: Colors.red,
                        letterSpacing: 1.0,
                        fontWeight: FontWeight.bold,
                      )),
                ),
              ],
            ),
            SizedBox(height: 10.0,),
            Row(
              children: <Widget>[
                Expanded(
                  flex:6,
                  child: Text("Gender ${data['gender']}",
                      style: TextStyle(
                        color: Colors.black,
                        letterSpacing: 1.0,
                        fontWeight: FontWeight.bold,
                      )),
                ),
                SizedBox(width: 10.0,),
                Icon(
                  Icons.favorite,
                  color: Colors.pink,
                ),
                SizedBox(width: 5.0,),
                Expanded(
                  flex: 6,
                  child: Text("Weekly Resting Heartrate",
                      style: TextStyle(
                        color: Colors.black,
                        letterSpacing: 1.0,
                        fontWeight: FontWeight.bold,
                      )),
                ),
                Expanded(
                  flex: 1,
                  child: Text(data['restheartrateweek'],
                      style: TextStyle(
                        color: Colors.red,
                        letterSpacing: 1.0,
                        fontWeight: FontWeight.bold,
                      )),
                ),
              ],
            ),
            SizedBox(height: 10.0,),
            Row(
              children: <Widget>[
                Expanded(
                  flex: 6,
                  child: Text("Points 0",
                      style: TextStyle(
                        color: Colors.black,
                        letterSpacing: 1.0,
                        fontWeight: FontWeight.bold,
                      )),
                ),
                SizedBox(width: 10.0),
                Icon(
                  Icons.alarm,
                  color: Colors.black,
                ),
                SizedBox(width: 5.0,),
                Expanded(
                  flex: 6,
                  child: Text("Sleep",
                      style: TextStyle(
                        color: Colors.black,
                        letterSpacing: 1.0,
                        fontWeight: FontWeight.bold,
                      )),
                ),
                Expanded(
                  flex: 1,
                  child: Text(data['sleepscore'],
                      style: TextStyle(
                        color: Colors.red,
                        letterSpacing: 1.0,
                        fontWeight: FontWeight.bold,
                      )),
                ),
              ],
            ),
            Divider(
              height: 30.0,
              color: Colors.grey[900],
            ),
            Center(
              child: Text("Current marathon speed",
                  style: TextStyle(
                      color: Colors.black,
                      letterSpacing: 1.0,
                      fontWeight: FontWeight.bold
                  )),
            ),
            SizedBox(height: 10.0,),
            Center(
              child: Text(data['measurement'],
                  style: TextStyle(
                    color: Colors.red,
                    letterSpacing: 1.0,
                    fontWeight: FontWeight.bold,
                  )),
            ),
            Center(
              child: FlatButton(
                  color: Colors.blue,
                  onPressed: (){
                    Navigator.pushNamed(context, '/measurement');
                  },
                  child: Text('Set current pace',
                      style: TextStyle(
                        color:Colors.black,
                        letterSpacing: 1.0,
                        fontWeight: FontWeight.bold,
                      ))),
            ),
            Divider(
              height: 20.0,
              color: Colors.grey[900],
            ),
            Center(
              child: Text("Desired marathon speed",
                  style: TextStyle(
                      color: Colors.black,
                      letterSpacing: 1.0,
                      fontWeight: FontWeight.bold
                  )),
            ),
            SizedBox(height: 10.0,),
            Center(
              child: Text(data['goal'],
                  style: TextStyle(
                    color: Colors.red,
                    letterSpacing: 1.0,
                    fontWeight: FontWeight.bold,
                  )),
            ),
            Divider(
              height: 20.0,
              color: Colors.grey[900],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[

                FlatButton(
                    color: Colors.blue,
                    onPressed: (){},
                    child: Text('Set Goal')),
                FlatButton(
                    color: Colors.green,
                    onPressed: (){},
                    child: Text('Start Workout')),
                FlatButton(
                    color: Colors.blue,
                    onPressed: (){},
                    child: Text('Set Workout')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
