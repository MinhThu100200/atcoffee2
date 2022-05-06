import 'package:geocoding/geocoding.dart'
    show Placemark, placemarkFromCoordinates;
import 'package:get/state_manager.dart';
import 'package:at_coffee/models/store.dart';
import 'package:at_coffee/services/service_store.dart';
import 'package:location/location.dart';

class StoreController extends GetxController {
  var isLoading = true.obs;
  var storesList = List<Store>().obs;
  RxDouble latitude = 0.0.obs;
  RxDouble longitude = 0.0.obs;
  RxString myAddress = "".obs;

  @override
  void onInit() {
    //fetchStores();
    //setLocationData();
    super.onInit();
  }

  void setLocationData() async {
    try {
      isLoading(true);
      if (latitude.value == 0.0 && longitude.value == 0.0) {
        Location location = new Location();
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

        //return _locationData;
        print("object");
        print(_locationData.latitude);
        if (_locationData?.latitude != null &&
            _locationData?.longitude != null) {
          latitude.value = _locationData?.latitude;
          longitude.value = _locationData?.longitude;
        }
      }

      //print(currentLocation.value);
    } finally {
      isLoading(false);
    }
  }

  void getAddress() async {
    try {
      isLoading.value = true;
      Location location = new Location();
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
      if (_locationData?.latitude != null && _locationData?.longitude != null) {
        latitude.value = _locationData?.latitude;
        longitude.value = _locationData?.longitude;
      }
      //isLoading.value = true;
      if (_locationData.latitude == null || _locationData.longitude == null) {
        myAddress.value = "";
      } else {
        List<Placemark> placemarks = await placemarkFromCoordinates(
            _locationData.latitude, _locationData.longitude);
        //print(placemarks);
        Placemark place = placemarks[0];
        print(place);

        // double distanceInMeters =
        //     Geolocator.distanceBetween(lat, lang, 10.9021, 106.7754);
        // // lệch 1km cho phép
        // print(distanceInMeters + 1000);

        myAddress.value =
            "${place.street}, ${place.subAdministrativeArea}, ${place.administrativeArea}";
      }
      // GeoCode geoCode = GeoCode();
      // Address address =
      //     await geoCode.reverseGeocoding(latitude: lat, longitude: lang);
      // print(address);
      // Coordinates coordinates =
      //     await geoCode.forwardGeocoding(address: "10 Lê Văn Việt, Hồ Chí Minh");
      // print(coordinates);
      //getDistance(lat, lang, 10.9021, 106.7754);
      isLoading.value = false;
    } finally {
      isLoading.value = false;
    }
  }

  void fetchStores() async {
    try {
      isLoading(true);
      var stores = await RemoteServices.fetchStores();
      if (stores != null) {
        storesList.value = stores;
      }
    } finally {
      isLoading(false);
    }
  }
}
