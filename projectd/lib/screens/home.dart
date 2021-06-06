import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  Map data = {};

  String phase = '0';

  @override
  Widget build(BuildContext context) {

    data = data.isNotEmpty ? data : ModalRoute.of(context).settings.arguments;
    print(data);

    if (phase == '0') {
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
                    child: Text("Resting Heartrate",
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
                    child: Text("Points ${data['points']}",
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
                child: Text("Estimated Current Pace",
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
                    onPressed: () async {
                      dynamic update = await Navigator.pushNamed(context, '/measurement');
                      setState(() {
                        data = {
                          'name' : update['name'],
                          'age' : update['age'],
                          'gender' : update['gender'],
                          'avatar' : update['avatar'],
                          'restheartrate' : update['restheartrate'],
                          'restheartrateweek' : update['restheartrateweek'],
                          'sleepscore' : update['sleepscore'],
                          'measurement' : update['measurement'],
                          'goal' : update['goal'],
                          'points' : update['points']
                        };
                        if (data['measurement'] != '00:00:00')
                          phase = '1';
                        else
                          phase = '0';
                      });
                    },
                    child: Text('Set current pace',
                        style: TextStyle(
                          color:Colors.black,
                          letterSpacing: 1.0,
                          fontWeight: FontWeight.bold,
                        ))),
              ),
            ],
          ),
        ),
      );
    }
    else if (phase == '1') {
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
                    child: Text("Resting Heartrate",
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
                    child: Text("Points ${data['points']}",
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
                child: Text("Estimated Current Pace",
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
                    onPressed: () async {
                      dynamic update = await Navigator.pushNamed(context, '/measurement');
                      setState(() {
                        data = {
                          'name' : update['name'],
                          'age' : update['age'],
                          'gender' : update['gender'],
                          'avatar' : update['avatar'],
                          'restheartrate' : update['restheartrate'],
                          'restheartrateweek' : update['restheartrateweek'],
                          'sleepscore' : update['sleepscore'],
                          'measurement' : update['measurement'],
                          'goal' : update['goal'],
                          'points' : update['points']
                        };
                        if (data['measurement'] != '00:00:00')
                          phase = '1';
                        else
                          phase = '0';
                      });
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
              Center(
                child: FlatButton(
                    color: Colors.blue,
                    onPressed: (){
                      Navigator.pushNamed(context, '/goal', arguments: {
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
                      } );
                    },
                    child: Text('Set Goal')),
              ),
            ],
          ),
        ),
      );
    }
    else if (phase == '2'){
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
                    child: Text("Resting Heartrate",
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
                    child: Text("Points ${data['points']}",
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
                child: Text("Estimated Current Pace",
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
                    onPressed: () async {
                      dynamic update = await Navigator.pushNamed(context, '/measurement');
                      setState(() {
                        data = {
                          'name' : update['name'],
                          'age' : update['age'],
                          'gender' : update['gender'],
                          'avatar' : update['avatar'],
                          'restheartrate' : update['restheartrate'],
                          'restheartrateweek' : update['restheartrateweek'],
                          'sleepscore' : update['sleepscore'],
                          'measurement' : update['measurement'],
                          'goal' : update['goal'],
                          'points' : update['points']
                        };
                        if (data['measurement'] != '00:00:00')
                          phase = '1';
                        else
                          phase = '0';
                      });
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
                      onPressed: (){
                        Navigator.pushNamed(context, '/goal', arguments: {
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
                        } );
                      },
                      child: Text('Set Goal')),
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
    else if (phase == '3'){
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
                    child: Text("Resting Heartrate",
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
                    child: Text("Points ${data['points']}",
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
                child: Text("Estimated Current Pace",
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
}
