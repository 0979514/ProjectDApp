import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:projectd/classes/User.dart';

class MeasurementScreen extends StatefulWidget {
  const MeasurementScreen({Key key}) : super(key: key);

  @override
  _MeasurementScreenState createState() => _MeasurementScreenState();
}

class _MeasurementScreenState extends State<MeasurementScreen> {

  final TextEditingController tcontroller = new TextEditingController();

  String answer = '0';

  String phase = 'notloading';

  String GetMinute(String x){
    int seconds = int.parse(x);
    int secondsminute = seconds-(seconds%60);
    String minutes = (secondsminute / 60).toString();
    return minutes;
  }

  void updatePace(String pace) async{
    User user = User(measurement: pace);
    await user.GetData();

    Navigator.pop(context, {
      'name' : user.name,
      'age' : user.age,
      'gender' : user.gender,
      'avatar' : user.avatar,
      'restheartrate' : user.restheartrate,
      'restheartrateweek' : user.restheartrateweek,
      'sleepscore' : user.sleepscore,
      'measurement' : user.measurement,
      'goal' : user.goal
    });
  }

  @override
  Widget build(BuildContext context) {
    if (phase == 'notloading'){
      return Scaffold(
        appBar: AppBar(
          title: Text("Measurement"),
          centerTitle: true,
          backgroundColor: Colors.blue[400],
          elevation: 0.0,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(30.0,40.0,30.0,0.0),
            child: Column(
              children: <Widget>[
                Center(child: Text('What to do',
                  style: TextStyle(
                    letterSpacing: 1.0,
                    fontWeight: FontWeight.bold,
                    fontSize: 30.0,
                  ),)),
                SizedBox(height: 20.0,),
                Text(
                  '1. Warm up your body with a slow 5 - 10 minute run   ',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 15.0,
                  ),
                ),
                SizedBox(height: 20.0,),
                Text(
                  '2. Now measure the time for the Magic Mile                ',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 15.0,
                  ),
                ),
                SizedBox(height: 20.0,),
                Text(
                  '3. Run about as hard as you can for one mile               ',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 15.0,
                  ),
                ),
                SizedBox(height: 20.0,),
                Text(
                  '4. Pace yourself as even as possible on each quarter mile',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 15.0,
                  ),
                ),
                SizedBox(height: 40.0,),
                Text(
                  'Enter how long it took, in seconds',
                  style: TextStyle(
                    fontSize: 15.0,
                  ),
                ),
                SizedBox(height: 20.0,),
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black)
                  ),
                  child: TextField(
                      decoration: new InputDecoration(
                        hintText: "Enter in seconds",
                      ),
                      keyboardType: TextInputType.number,
                      onSubmitted: (String str) {
                        setState(() {
                          //Er zijn nog bugs met invoer bijv crash als je . , of andere tekens erin zet
                          answer = str!='' ? str : '0';
                        });
                        tcontroller.text = "";
                        GetMinute(answer);
                      },
                      controller: tcontroller
                  ),
                ),
                SizedBox(height: 20.0),
                Text("So your time is: ${answer} seconds?"),
                SizedBox(height: 20.0),
                Text("Confirm that your time is"),
                SizedBox(height: 10.0),
                Text("${GetMinute(answer)} minutes and ${int.parse(answer)%60}.0 seconds"),
                SizedBox(height: 10.0),
                FlatButton(
                    color: Colors.blue,
                    onPressed: (){
                      //calculate marathon speed
                      double pace = int.parse(answer)*1.3;
                      pace = pace*26.21875;
                      var date = new DateTime.fromMillisecondsSinceEpoch(pace.toInt() * 1000);
                      answer = date.toString().substring(11, 19);
                      updatePace(answer);
                      setState(() {
                        phase = 'loading';
                      });
                    },
                    child: Text('Update current pace')),
              ],
            ),
          ),
        ),
      );
    }
    else {
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
}
