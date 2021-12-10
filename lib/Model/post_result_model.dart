import 'dart:convert';

import 'package:http/http.dart' as http;

class PostResult {
  String name;
  String job;
  String id;
  String createdAt;

  PostResult({this.name, this.job, this.id, this.createdAt});

  factory PostResult.createData(Map<String, dynamic> obj) {
    return PostResult(
        name: obj['name'],
        id: obj['id'],
        job: obj['job'],
        createdAt: obj['createdAt']);
  }
  static Future<PostResult> connectToApi(String name, String job) async {
    String baseUrl = "https://reqres.in/api/users";

    var response = await http.post(baseUrl, body: {"name": name, "job": job});
    var jsonObj = json.decode(response.body);

    return PostResult.createData(jsonObj);
  }
}
