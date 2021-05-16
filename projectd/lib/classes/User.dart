import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';

class User {

  //User information that we need
  String name;
  String age;
  String gender;
  String avatar;
  String restheartrate;
  String restheartrateweek;
  String sleepscore;

  User({this.name, this.age, this.gender, this.avatar, this.restheartrate, this.restheartrateweek, this.sleepscore});

  //Get userdata
  Future<void> GetData() async {
    try{
      //Get date of yesterday
      String dayBefore = DateTime.now().add(Duration(hours: -24)).toString().substring(0,10);

      //Get profile data
      Response response = await get(Uri.parse(
          "https://api.fitbit.com/1/user/-/profile.json"
      ),
          headers: {
            "Authorization":
            "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIyM0I1NjUiLCJzdWIiOiI5QkNXQzYiLCJpc3MiOiJGaXRiaXQiLCJ0eXAiOiJhY2Nlc3NfdG9rZW4iLCJzY29wZXMiOiJyc29jIHJhY3QgcnNldCBybG9jIHJ3ZWkgcmhyIHJudXQgcnBybyByc2xlIiwiZXhwIjoxNjUyNjUyOTA0LCJpYXQiOjE2MjExMTY5Njl9.EZXJUVHO6Oz-vtAPeKzJwziWvHUuXMIH0gF4BSqC1Jw"
          });

      //Get heartrate data
      Response response2 = await get(Uri.parse(
          "https://api.fitbit.com/1/user/-/activities/heart/date/today/7d.json"
      ),
          headers: {
            "Authorization":
            "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIyM0I1NjUiLCJzdWIiOiI5QkNXQzYiLCJpc3MiOiJGaXRiaXQiLCJ0eXAiOiJhY2Nlc3NfdG9rZW4iLCJzY29wZXMiOiJyc29jIHJhY3QgcnNldCBybG9jIHJ3ZWkgcmhyIHJudXQgcnBybyByc2xlIiwiZXhwIjoxNjUyNjUyOTA0LCJpYXQiOjE2MjExMTY5Njl9.EZXJUVHO6Oz-vtAPeKzJwziWvHUuXMIH0gF4BSqC1Jw"
          });

      //Get sleepamount data
      Response response3 = await get(Uri.parse(
          "https://api.fitbit.com/1.2/user/-/sleep/date/${dayBefore}.json"
      ),
          headers: {
            "Authorization":
            "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIyM0I1NjUiLCJzdWIiOiI5QkNXQzYiLCJpc3MiOiJGaXRiaXQiLCJ0eXAiOiJhY2Nlc3NfdG9rZW4iLCJzY29wZXMiOiJyc29jIHJhY3QgcnNldCBybG9jIHJ3ZWkgcmhyIHJudXQgcnBybyByc2xlIiwiZXhwIjoxNjUyNjUyOTA0LCJpYXQiOjE2MjExMTY5Njl9.EZXJUVHO6Oz-vtAPeKzJwziWvHUuXMIH0gF4BSqC1Jw"
          });

      //Get sleepgoaldata
      Response response4 = await get(Uri.parse(
          "https://api.fitbit.com/1/user/-/sleep/goal.json"
      ),
          headers: {
            "Authorization":
            "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIyM0I1NjUiLCJzdWIiOiI5QkNXQzYiLCJpc3MiOiJGaXRiaXQiLCJ0eXAiOiJhY2Nlc3NfdG9rZW4iLCJzY29wZXMiOiJyc29jIHJhY3QgcnNldCBybG9jIHJ3ZWkgcmhyIHJudXQgcnBybyByc2xlIiwiZXhwIjoxNjUyNjUyOTA0LCJpYXQiOjE2MjExMTY5Njl9.EZXJUVHO6Oz-vtAPeKzJwziWvHUuXMIH0gF4BSqC1Jw"
          });

      //Data in maps
      Map data = jsonDecode(response.body);
      Map heartratedata = jsonDecode(response2.body);
      Map sleepdata = jsonDecode(response3.body);
      Map sleepgoaldata = jsonDecode(response4.body);

      //Calculate weekly resting heartrate
      int total = 0;

      for (int i = 0; i<7; i++){
        total += heartratedata['activities-heart'][i]['value']['restingHeartRate']!= null ? heartratedata['activities-heart'][i]['value']['restingHeartRate'] : 0;
      }

      //Pass data to User class
      this.name = data['user']['fullName'];
      this.age = data['user']['age'].toString();
      this.gender = data['user']['gender'];
      this.avatar = data['user']['avatar150'];
      this.restheartrate = heartratedata['activities-heart'][6]['value']['restingHeartRate'].toString();

      //Calculate weekly resting heartrate
      this.restheartrateweek = (total/7).toString().substring(0,2);

      //calculate sleepscore = actual sleep in hours / sleepgoal * 10. if sleeping more than goal aka score > 10 then sleepscore = 10 - (score-10)
      double sleepgoalinhours = sleepgoaldata['goal']['minDuration']/60;
      double sleepscore = sleepdata['sleep'].isNotEmpty ? sleepdata['sleep'][0]['duration']/3600000/sleepgoalinhours*10 : 0.0;
      this.sleepscore = sleepscore < 10 ? sleepscore.toString().substring(0,3) : (10-(sleepscore-10)).toString().substring(0,3);
    }
    catch(e){
      print(e);
    }


  }
}