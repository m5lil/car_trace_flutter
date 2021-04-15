import 'package:flutter/material.dart';

 import 'package:flutter/services.dart';
 import 'package:geolocator/geolocator.dart';
 import 'package:http/http.dart' as http;
import 'package:trace/view/dashboard.dart';
import 'package:trace/view/login.dart';
import 'package:trace/view/map.dart';
 import 'model/car.dart';

void main() {
  runApp(GeneralApp());
}

class GeneralApp extends StatelessWidget {
  final String title = '';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "CarTrace",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        '/dashboard': (BuildContext context) => new Dashboard(title: title),
        '/map' : (BuildContext context) => new Map(title:title),
        '/login': (BuildContext context) => new LoginPage(title: title),
      },
    );
  }
}

// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }
//
// Future<Car> createCar(String plateNo, String lat, String lng) async {
//   final String apiUrl = "https://mersal.ga/api/add";
//
//   final response = await http.post(apiUrl, body: {
//     "plate_no": plateNo,
//     "lat": lat,
//     "lng": lng,
//   },headers: {'Accept' : 'application/json'});
//
//   if(response.statusCode == 201){
//     final String resBody = response.body;
//
//     return carFromJson(resBody);
//   }else{
//     return null;
//   }
// }
//
// class _HomePageState extends State<HomePage> {
//   final TextEditingController plateFirstController = TextEditingController();
//   final TextEditingController plateSecondController = TextEditingController();
//   final TextEditingController plateThirdController = TextEditingController();
//   final TextEditingController plateNumberController = TextEditingController();
//   FocusNode myFocusNodeOne;
//   FocusNode myFocusNodeTwo;
//   FocusNode myFocusNodeThree;
//   FocusNode myFocusNodeFour;
//
//   @override
//   void initState() {
//     super.initState();
//
//     myFocusNodeOne = FocusNode();
//     myFocusNodeTwo = FocusNode();
//     myFocusNodeThree = FocusNode();
//     myFocusNodeFour = FocusNode();
//   }
//
//   @override
//   void dispose() {
//     // Clean up the focus node when the Form is disposed.
//     myFocusNodeOne.dispose();
//     myFocusNodeTwo.dispose();
//     myFocusNodeThree.dispose();
//     myFocusNodeFour.dispose();
//
//     super.dispose();
//   }
//
//   Car _car;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Car Trace'),
//       ),
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//               begin: Alignment.topRight,
//               end: Alignment.bottomLeft,
//               colors: [Colors.blueGrey, Colors.lightBlueAccent]),
//         ),
//         padding: EdgeInsets.all(32),
//         child: Column(
//           children: [
//             Center(
//               child: Container(
//                 width: 100.0,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     TextField(
//                       textAlign: TextAlign.center,
//                       autofocus: true,
//                       focusNode: myFocusNodeOne,
//                       maxLength: 1,
//                       controller: plateFirstController,
//                       onChanged: (text) => myFocusNodeTwo.requestFocus(),
//                       onTap: () => plateFirstController.clear(),
//                     ),
//                     TextField(
//                       textAlign: TextAlign.center,
//                       focusNode: myFocusNodeTwo,
//                       maxLength: 1,
//                       controller: plateSecondController,
//                       onChanged: (text) => myFocusNodeThree.requestFocus(),
//                       onTap: () => plateSecondController.clear(),
//                     ),
//                     TextField(
//                       textAlign: TextAlign.center,
//                       focusNode: myFocusNodeThree,
//                       maxLength: 1,
//                       controller: plateThirdController,
//                       onChanged: (text) => myFocusNodeFour.requestFocus(),
//                       onTap: () => plateThirdController.clear(),
//                     ),
//                     TextField(
//                       textAlign: TextAlign.center,
//                       focusNode: myFocusNodeFour,
//                       maxLength: 4,
//                       keyboardType: TextInputType.numberWithOptions(),
//                       inputFormatters: <TextInputFormatter>[
//                         WhitelistingTextInputFormatter.digitsOnly
//                       ],
//                       controller: plateNumberController,
//                       onTap: () => plateNumberController.clear(),
//                     ),
//                     SizedBox(height: 32,),
//                     if (_car == null) Container() else Text('Done $_car'),
// //                    FlatButton(
// //                      onPressed: (){
// //                        plateFirstController.clear();
// //                        plateSecondController.clear();
// //                        plateThirdController.clear();
// //                        plateNumberController.clear();
// //                      },
// //                      child: Text('Clear'),
// //                    )
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         child: Icon(Icons.navigation),
//         onPressed: () async {
//           Position position = await getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
//           print(position.latitude.toString());
//
//           final String plateNo = plateFirstController.text + ' ' + plateSecondController.text +' '+ plateThirdController.text + ' '+ plateNumberController.text;
//           final String lat = position.latitude.toString();
//           final String lng = position.longitude.toString();
//           final String userId = "9";
//
//           final Car car = await createCar(plateNo, lat, lng);
//
//           setState(() {
//             _car = car;
//           });
//           plateFirstController.clear();
//           plateSecondController.clear();
//           plateThirdController.clear();
//           plateNumberController.clear();
//           myFocusNodeOne.requestFocus();
//         },
//       ),
//     );
//   }
// }
