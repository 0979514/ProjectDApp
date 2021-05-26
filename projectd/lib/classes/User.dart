import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';
import "package:yaml/yaml.dart";
import "package:flutter/services.dart" as sv;

class User {
  //User information that we need
  String name;
  String age;
  String gender;
  String avatar;
  String restheartrate;
  String restheartrateweek;
  String sleepscore;
  String measurement;
  String goal;

  User(
      {this.name,
        this.age,
        this.gender,
        this.avatar,
        this.restheartrate,
        this.restheartrateweek,
        this.sleepscore,
        this.measurement,
        this.goal});

  //Get userdata
  Future<void> GetData() async {
    try {
      final temp = await sv.rootBundle.loadString("assets/test.yaml");
      var temp2 = loadYaml(temp);
      String bearer = temp2['AccountDetails']['Authorization'];
      print(bearer);
      //Get profile data
      Response response = await get(
          Uri.parse("https://api.fitbit.com/1/user/-/profile.json"),
          headers: {"Authorization": "Bearer $bearer"});

      //Get heartrate data
      Response response2 = await get(
          Uri.parse(
              "https://api.fitbit.com/1/user/-/activities/heart/date/today/7d.json"),
          headers: {"Authorization": "Bearer $bearer"});
      //Get sleepamount data
      Response response3 = await get(
          Uri.parse("https://api.fitbit.com/1.2/user/-/sleep/date/today.json"),
          headers: {"Authorization": "Bearer $bearer"});
      //Get sleepgoaldata
      Response response4 = await get(
          Uri.parse("https://api.fitbit.com/1/user/-/sleep/goal.json"),
          headers: {"Authorization": "Bearer $bearer"});
      //Data in maps
      Map data = jsonDecode(response.body);
      Map heartratedata = jsonDecode(response2.body);
      Map sleepdata = jsonDecode(response3.body);
      Map sleepgoaldata = jsonDecode(response4.body);

      //Calculate weekly resting heartrate
      int total = 0;
      int daysHeartrateRecorded = 0;
      int lastDayRecorded = 0;

      for (int i = 0; i < 7; i++) {
        total += heartratedata['activities-heart'][i]['value']
        ['restingHeartRate'] !=
            null
            ? heartratedata['activities-heart'][i]['value']['restingHeartRate']
            : 0;
        daysHeartrateRecorded += heartratedata['activities-heart'][i]['value']
        ['restingHeartRate'] !=
            null
            ? 1
            : 0;
        lastDayRecorded = heartratedata['activities-heart'][i]['value']
        ['restingHeartRate'] !=
            null
            ? i
            : lastDayRecorded;
      }

      //Pass data to User class
      this.name = data['user']['fullName'];
      this.age = data['user']['age'].toString();
      this.gender = data['user']['gender'];
      this.avatar = data['user']['avatar150'];
      this.restheartrate = heartratedata['activities-heart'][6]['value']
      ['restingHeartRate']
          .toString();

      this.measurement = '00:00:00';
      this.goal = '00:00:00';

      //Calculate weekly resting heartrate
      this.restheartrateweek =
          (total / daysHeartrateRecorded).toString().substring(0, 2);

      //calculate sleepscore = actual sleep in hours / sleepgoal * 10. if sleeping more than goal aka score > 10 then sleepscore = 10 - (score-10)
      double sleepgoalinhours = sleepgoaldata['goal']['minDuration'] / 60;
      double sleepscore = sleepdata['sleep'].isNotEmpty
          ? sleepdata['sleep'][0]['duration'] / 3600000 / sleepgoalinhours * 10
          : 0.0;
      this.sleepscore = sleepscore < 10
          ? sleepscore.toString().substring(0, 3)
          : (10 - (sleepscore - 10)).toString().substring(0, 3);



    } catch (e) {
      print(e);
    }
  }
}
