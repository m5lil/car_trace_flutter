import 'package:flutter/material.dart';
import 'package:trace/Controllers/databasehelper.dart';
import 'package:trace/model/car.dart';
import 'package:trace/view/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'dart:core';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:trace/view/map.dart';


class Dashboard extends StatefulWidget {
  Dashboard({Key key, this.title}) : super(key: key);
  final String title;

  @override
  DashboardState createState() => DashboardState();
}

Future<Car> createCar(String plateNo, String lat, String lng) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;


    final String apiUrl = "https://trace.esol.systems/api/v1/cars";

  final response = await http.post(apiUrl, body: {
    "plate_no": plateNo,
    "lat": lat,
    "lng": lng,
  },headers: {'Accept' : 'application/json','Authorization': 'Bearer $value'});

  print(response.statusCode);

  if(response.statusCode == 200){
    final String resBody = response.body;
    return carFromJson(resBody);
  }else{
    return null;
  }
}

var translator = {
  '#': new RegExp(r'[u0621-\u064A]'),
  '0': new RegExp(r'[0-9]'),

};

class DashboardState extends State<Dashboard> {
  DatabaseHelper databaseHelper = new DatabaseHelper();

  _save(String token) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = token;
    prefs.setString(key, value);
  }



  final TextEditingController plateFirstController = MaskedTextController(mask: '# # # 0000', translator: translator);

//  final TextEditingController plateSecondController = TextEditingController();
//  final TextEditingController plateThirdController = TextEditingController();
//  final TextEditingController plateNumberController = TextEditingController();
//  FocusNode myFocusNodeOne;
//  FocusNode myFocusNodeTwo;
//  FocusNode myFocusNodeThree;
//  FocusNode myFocusNodeFour;
//
  @override
  void initState() {
    super.initState();

//    myFocusNodeOne = FocusNode();
//    myFocusNodeTwo = FocusNode();
//    myFocusNodeThree = FocusNode();
//    myFocusNodeFour = FocusNode();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
//    myFocusNodeOne.dispose();
//    myFocusNodeTwo.dispose();
//    myFocusNodeThree.dispose();
//    myFocusNodeFour.dispose();

    super.dispose();
  }

  Car _car;


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dashboard',
      home: Scaffold(
          appBar: AppBar(
            title: Text('Dashboard'),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.cancel),
                onPressed: () {
                  _save('0');
                  Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => new LoginPage(),
                  ));
                },
              )
            ],
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.navigation),
            onPressed: () async {
              Position position = await getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

              final String plateNo = plateFirstController.text;
              final String lat = position.latitude.toString();
              final String lng = position.longitude.toString();

              print(lat + lng + plateNo);

              final Car car = await createCar(plateNo, lat, lng);
              print(' test :$car');
              setState(() {
                _car = car;
              });
              plateFirstController.clear();
//              plateSecondController.clear();
//              plateThirdController.clear();
//              plateNumberController.clear();
//              myFocusNodeOne.requestFocus();
            },
          ),
        body: Container(
//          decoration: BoxDecoration(
//            gradient: LinearGradient(
//                begin: Alignment.topRight,
//                end: Alignment.bottomLeft,
//                colors: [Colors.blueGrey, Colors.lightBlueAccent]),
//          ),
          padding: EdgeInsets.all(32),
          child: ListView(
            padding: const EdgeInsets.only(top: 62,left: 12.0,right: 12.0,bottom: 12.0),
            children: [
              Container(
                child: Stack(
                  children: [
                    TextField(
                      textAlign: TextAlign.center,
                      autofocus: true,
//                      focusNode: myFocusNodeOne,
                      maxLength: 10,
                      controller: plateFirstController,
//                      onChanged: (text) => myFocusNodeTwo.requestFocus(),
                      onTap: () => plateFirstController.clear(),
                    ),
//                    TextField(
//                      textAlign: TextAlign.center,
//                      focusNode: myFocusNodeTwo,
//                      maxLength: 1,
//                      controller: plateSecondController,
//                      onChanged: (text) => myFocusNodeThree.requestFocus(),
//                      onTap: () => plateSecondController.clear(),
//                    ),
//                    TextField(
//                      textAlign: TextAlign.center,
//                      focusNode: myFocusNodeThree,
//                      maxLength: 1,
//                      controller: plateThirdController,
//                      onChanged: (text) => myFocusNodeFour.requestFocus(),
//                      onTap: () => plateThirdController.clear(),
//                    ),
//                    TextField(
//                      textAlign: TextAlign.center,
//                      focusNode: myFocusNodeFour,
//                      maxLength: 4,
//                      keyboardType: TextInputType.numberWithOptions(),
//                      inputFormatters: <TextInputFormatter>[
//                        WhitelistingTextInputFormatter.digitsOnly
//                      ],
//                      controller: plateNumberController,
//                      onTap: () => plateNumberController.clear(),
//                    ),
                    SizedBox(height: 32,),

                    if (_car == null) Container() else Text('Done'),
                    //                    FlatButton(
                    //                      onPressed: (){
                    //                        plateFirstController.clear();
                    //                        plateSecondController.clear();
                    //                        plateThirdController.clear();
                    //                        plateNumberController.clear();
                    //                      },
                    //                      child: Text('Clear'),
                    //                    )
                  ],
                ),
              ),
              SizedBox(height: 52,),
//              SizedBox(
//                  width: MediaQuery.of(context).size.width,  // or use fixed size like 200
//                  height: MediaQuery.of(context).size.height * .4,
//                  child: GoogleMap(
//                    initialCameraPosition: CameraPosition(
//                        target: LatLng(),
//                        zoom: 10
//                    ),
//                  ),
//              ),
              Container(
                child: FlatButton(

                  onPressed: ()=> Navigator.of(context).push(
                      new MaterialPageRoute(
                        builder: (BuildContext context) => new Map(title: 'Check Your Position',),
                      )
                  ),

                  color: Colors.blue,
                  child: new Text(
                    'تأكد من موقعك',
                    style: new TextStyle(
                      color: Colors.white,
                    ),),
                ),

              )
            ],
          ),
        ),
      ),
    );
  }
}
