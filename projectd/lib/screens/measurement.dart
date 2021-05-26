import 'package:flutter/material.dart';

class MeasurementScreen extends StatefulWidget {
  const MeasurementScreen({Key key}) : super(key: key);

  @override
  _MeasurementScreenState createState() => _MeasurementScreenState();
}

class _MeasurementScreenState extends State<MeasurementScreen> {

  final TextEditingController tcontroller = new TextEditingController();

  String answer = '0';

  String GetMinute(String x){
    int seconds = int.parse(x);
    int secondsminute = seconds-(seconds%60);
    String minutes = (secondsminute / 60).toString();
    return minutes;
  }

  @override
  Widget build(BuildContext context) {
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
                '1. Warm up your body with a slow 5 - 10 minute run',
                style: TextStyle(
                  fontSize: 15.0,
                ),
              ),
              SizedBox(height: 20.0,),
              Text(
                '2. Turn ???',
                style: TextStyle(
                  fontSize: 15.0,
                ),
              ),
              SizedBox(height: 20.0,),
              Text(
                '3. Turn ???',
                style: TextStyle(
                  fontSize: 15.0,
                ),
              ),
              SizedBox(height: 20.0,),
              Text(
                '4. Turn ???',
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

            ],
          ),
        ),
      ),
    );
  }
}
