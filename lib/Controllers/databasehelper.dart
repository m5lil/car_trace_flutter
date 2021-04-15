import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class DatabaseHelper {
  String serverUrl = "https://trace.esol.systems/api/v1";
  var status;

  var token;

  loginData(String username, String password) async {
    String myUrl = "$serverUrl/login";
    final response = await http.post(myUrl,
        headers: {'Accept': 'application/json'},
        body: {"username": "$username", "password": "$password"});
    status = response.body.contains('error');


    var data = json.decode(response.body);

    if (status) {
      print('data : ${data["error"]}');
    } else {
      print('data : ${data["token"]}');
      _save(data["token"]);
    }
  }

//  registerData(String name, String username, String password) async {
//    String myUrl = "$serverUrl/register1";
//    final response = await http.post(myUrl,
//        headers: {'Accept': 'application/json'},
//        body: {"name": "$name", "username": "$username", "password": "$password"});
//    status = response.body.contains('error');
//
//    var data = json.decode(response.body);
//
//    if (status) {
//      print('data : ${data["error"]}');
//    } else {
//      print('data : ${data["token"]}');
//      _save(data["token"]);
//    }
//  }

//  Future<List> getData() async {
//    final prefs = await SharedPreferences.getInstance();
//    final key = 'token';
//    final value = prefs.get(key) ?? 0;
//
//    String myUrl = "$serverUrl/cars/";
//    http.Response response = await http.get(myUrl, headers: {
//      'Accept': 'application/json',
//      'Authorization': 'Bearer $value'
//    });
//    return json.decode(response.body);
//  }

//  void deleteData(int id) async {
//    final prefs = await SharedPreferences.getInstance();
//    final key = 'token';
//    final value = prefs.get(key) ?? 0;
//
//    String myUrl = "$serverUrl/cars/$id";
//    http.delete(myUrl, headers: {
//      'Accept': 'application/json',
//      'Authorization': 'Bearer $value'
//    }).then((response) {
//      print('Response status : ${response.statusCode}');
//      print('Response body : ${response.body}');
//    });
//  }

//  void addData(String plate_no) async {
//    final prefs = await SharedPreferences.getInstance();
//    final key = 'token';
//    final value = prefs.get(key) ?? 0;
//
//    String myUrl = "$serverUrl/cars";
//    http.post(myUrl, headers: {
//      'Accept': 'application/json',
//      'Authorization': 'Bearer $value'
//    }, body: {
//      "plate_no": "$plate_no",
//      "lat": "12.091023",
//      "lng": "32.123231",
//      "user_id": 1
//    }).then((response) {
//      print('Response status : ${response.statusCode}');
//      print('Response body : ${response.body}');
//    });
//  }
//
//  void editData(int id, String name) async {
//    final prefs = await SharedPreferences.getInstance();
//    final key = 'token';
//    final value = prefs.get(key) ?? 0;
//
//    String myUrl = "http://flutterapitutorial.codeforiraq.org/api/cars/$id";
//    http.put(myUrl, headers: {
//      'Accept': 'application/json',
//      'Authorization': 'Bearer $value'
//    }, body: {
//      "name": "$name",
//    }).then((response) {
//      print('Response status : ${response.statusCode}');
//      print('Response body : ${response.body}');
//    });
//  }

  _save(String token) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = token;
    prefs.setString(key, value);
  }

  read() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;
    print('read : $value');
  }
}
