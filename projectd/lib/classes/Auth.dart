import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:url_launcher/url_launcher.dart';
import "package:yaml/yaml.dart";
import "package:flutter/services.dart" as sv;

class Login
{
  var data = {};

  Future<void> readYAML()
  async {
    final temp = await sv.rootBundle.loadString("assets/resource.yaml");
    this.data = loadYaml(temp);
    print(this.data['application']["auth"]);
    authenticate(data["application"]['auth']);
  }

  Future<void> authenticate(String path)
  async {
    await launch(path);
  }
}