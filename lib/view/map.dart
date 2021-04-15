import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:trace/view/dashboard.dart';

class Map extends StatefulWidget {
  Map({Key key , this.title}) : super(key : key);
  final String title;

  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<Map>  {
  LatLng _center ;
  Position currentLocation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserLocation();
  }

  Future<Position> locateUser() async {
    return getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
//    Position position = await getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }

  getUserLocation() async {
    currentLocation = await locateUser();
    setState(() {
      _center = LatLng(currentLocation.latitude, currentLocation.longitude);
    });
//    print('center $_center');
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Map',
      home: Scaffold(
        appBar: AppBar(
          title:  Text(widget.title),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.arrow_forward),
              onPressed: ()=>Navigator.of(context).push(
                  new MaterialPageRoute(
                    builder: (BuildContext context) => new Dashboard(),
                  )
              ),
            )
          ],

        ),
        body: Stack(
          children: [
            GoogleMap(
              initialCameraPosition: CameraPosition(
                  target: _center,
                  zoom: 25
              ),
            ),
            Center(
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(icon: Icon(Icons.person), onPressed: null)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
