// To parse this JSON data, do
//
//     final car = carFromJson(jsonString);

import 'dart:convert';

Car carFromJson(String str) => Car.fromJson(json.decode(str));

String carToJson(Car data) => json.encode(data.toJson());

class Car {
  Car({
    this.plateNo,
    this.lat,
    this.lng,
  });

  String plateNo;
  String lat;
  String lng;

  factory Car.fromJson(Map<String, dynamic> json) => Car(
    plateNo: json["plate_no"],
    lat: json["lat"],
    lng: json["lng"],
  );


  Map<String, dynamic> toJson() => {
    "plate_no": plateNo,
    "lat": lat,
    "lng": lng,
  };
}
