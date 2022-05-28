import 'package:geolocator/geolocator.dart';

class UtilsCommon {
  static bool isEmail(String em) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = RegExp(p);

    return regExp.hasMatch(em);
  }

  static double getAddress(
    double latStore,
    double longStore,
    double lat,
    double long,
  ) {
    double distanceInMeters = 0;
    //_getLocationData().then((value) {
    if (lat == 0 || long == 0 || latStore == 0 || longStore == 0) return 0;
    // GeoCode geoCode = GeoCode();
    //print(currentLocation);

    //LocationData location = value;

    // Address address =
    //     await geoCode.reverseGeocoding(latitude: lat, longitude: lang);
    // print(address);
    // Coordinates coordinates =
    //     await geoCode.forwardGeocoding(address: "10 Lê Văn Việt, Hồ Chí Minh");
    // print(coordinates);
    //getDistance(lat, lang, 10.9021, 106.7754);

    // List<Placemark> placemarks = await placemarkFromCoordinates(lat, lang);
    // //print(placemarks);
    // Placemark place = placemarks[0];
    // print(place);

    distanceInMeters =
        (Geolocator.distanceBetween(latStore, longStore, lat, long) + 1000) /
            1000;
    // lệch 1km cho phép
    //print("distanceInMeters");
    //print(distanceInMeters);

    return distanceInMeters;
  }
}
