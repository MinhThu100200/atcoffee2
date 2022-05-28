import 'package:flutter/material.dart';
//import 'package:geocode/geocode.dart';
import 'package:location/location.dart';
import 'dart:math' show sin, cos, sqrt, atan2;
import 'package:vector_math/vector_math.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart'
    show Placemark, placemarkFromCoordinates;

class GetUserLocation extends StatefulWidget {
  GetUserLocation({Key key, @required this.title}) : super(key: key);
  final String title;

  @override
  _GetUserLocationState createState() => _GetUserLocationState();
}

class _GetUserLocationState extends State<GetUserLocation> {
  LocationData currentLocation;
  String address = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              if (currentLocation != null)
                Text(
                    "Location: ${currentLocation?.latitude}, ${currentLocation?.longitude}"),
              if (currentLocation != null) Text("Address: $address"),
              MaterialButton(
                onPressed: _getLocation,
                color: const Color.fromARGB(255, 123, 2, 5),
                child: const Text(
                  "Get Location",
                  style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _getLocation() {
    _getLocationData().then((value) {
      LocationData location = value;
      _getAddress(location?.latitude, location?.longitude).then((value) {
        setState(() {
          currentLocation = location;
          address = value;
        });
      });
    });
  }
}

Future<LocationData> _getLocationData() async {
  Location location = Location();
  LocationData _locationData;

  bool _serviceEnabled;
  PermissionStatus _permissionGranted;

  _serviceEnabled = await location.serviceEnabled();
  if (!_serviceEnabled) {
    _serviceEnabled = await location.requestService();
    if (!_serviceEnabled) {
      return null;
    }
  }

  _permissionGranted = await location.hasPermission();
  if (_permissionGranted == PermissionStatus.denied) {
    _permissionGranted = await location.requestPermission();
    if (_permissionGranted != PermissionStatus.granted) {
      return null;
    }
  }

  _locationData = await location.getLocation();

  return _locationData;
}

getDistance(latitude1, longitude1, latitude2, longitude2) {
  double earthRadius = 6371000;
  var dLat = radians(latitude2 - latitude1);
  var dLng = radians(longitude2 - longitude1);
  var a = sin(dLat / 2) * sin(dLat / 2) +
      cos(radians(latitude1)) *
          cos(radians(latitude2)) *
          sin(dLng / 2) *
          sin(dLng / 2);
  var c = 2 * atan2(sqrt(a), sqrt(1 - a));
  var d = earthRadius * c;
  print(d); //d is the distance in meters
}

Future<String> _getAddress(double lat, double lang) async {
  if (lat == null || lang == null) return "";
  // GeoCode geoCode = GeoCode();
  // Address address =
  //     await geoCode.reverseGeocoding(latitude: lat, longitude: lang);
  // print(address);
  // Coordinates coordinates =
  //     await geoCode.forwardGeocoding(address: "10 Lê Văn Việt, Hồ Chí Minh");
  // print(coordinates);
  getDistance(lat, lang, 10.9021, 106.7754);

  List<Placemark> placemarks = await placemarkFromCoordinates(lat, lang);
  //print(placemarks);
  Placemark place = placemarks[0];
  //print(place);

  double distanceInMeters =
      Geolocator.distanceBetween(lat, lang, 10.9021, 106.7754);
  // lệch 1km cho phép
  print(distanceInMeters + 1000);

  return "${place.street}, ${place.subAdministrativeArea}, ${place.administrativeArea}";
}
