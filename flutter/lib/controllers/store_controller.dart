import 'package:geocoding/geocoding.dart'
    show Placemark, placemarkFromCoordinates;
import 'package:get/state_manager.dart';
import 'package:at_coffee/models/store.dart';
import 'package:at_coffee/services/service_store.dart';
import 'package:location/location.dart';
import 'package:at_coffee/common/utils_common/utils_common.dart';

class StoreController extends GetxController {
  var isLoading = true.obs;
  var storesList = <Store>[].obs;
  var storeListNearYou = <Store>[].obs;
  RxDouble latitude = 0.0.obs;
  RxDouble longitude = 0.0.obs;
  RxString myAddress = "".obs;
  var storeNearYou = Store().obs;
  var storeMinDistance = 0.obs;
  var selected = 0.obs;

  @override
  void onInit() {
    //fetchStores();
    //setLocationData();
    super.onInit();
  }

  void setSeleted(int value) {
    selected.value = value;
  }

  void updateMyAddress(city, dis, ward, numStreet) {
    myAddress.value = numStreet.trim() + ", " + ward + " " + dis + " " + city;
  }

  void setLocationData() async {
    try {
      isLoading.value = true;
      if (latitude.value == 0.0 && longitude.value == 0.0) {
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

        //return _locationData;
        //print("object");
        //print(_locationData.latitude);
        if (_locationData?.latitude != null &&
            _locationData?.longitude != null) {
          latitude.value = _locationData?.latitude;
          longitude.value = _locationData?.longitude;
        }
      }

      //print(currentLocation.value);
    } finally {
      isLoading.value = false;
    }
  }

  void getAddress() async {
    try {
      //isLoading.value = true;
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
        //print(place);

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
      //isLoading.value = false;
    } finally {
      isLoading.value = false;
    }
  }

  void fetchStores() async {
    try {
      isLoading.value = true;
      var stores = await RemoteServices.fetchStores();
      if (stores != null) {
        storesList.value = stores;
      }
    } catch (error) {
      print(error);
    } finally {
      isLoading.value = false;
    }
  }

  void updateMyStoreNearYou(store) {
    try {
      storeNearYou.value = store;
      storeMinDistance.value = UtilsCommon.getAddress(
              store.latitude, store.longitude, latitude.value, longitude.value)
          .round();
    } catch (error) {
      print(error);
    }
  }

  void myStoreNearYou() async {
    try {
      //isLoading(true);
      if (storeNearYou.value.address != null) {
        print("minh thu inside");
      } else {
        var stores = await RemoteServices.fetchStores();
        if (stores != null) {
          storesList.value = stores;
          //print(stores.length);

          var indexMin = 0;
          var minDistance = 1000000;
          //print(minDistance);
          for (var i = 0; i < stores.length; i++) {
            //print("store");

            var distance = UtilsCommon.getAddress(stores[i].latitude,
                stores[i].longitude, latitude.value, longitude.value);
            if (distance < minDistance) {
              minDistance = distance.round();
              indexMin = i;
            }
          }
          storeNearYou.value = stores[indexMin];
          storeMinDistance.value = minDistance.round();
          print(minDistance.toString() + " " + minDistance.toString());
        }
      }
    } catch (error) {
      print(error);
    } finally {
      //isLoading(false);
    }
  }

  void getStoreListNearYou() async {
    try {
      isLoading.value = true;
      List<Store> newList = <Store>[];
      //print(storesList.value.length.toString() + "minthu");

      //var minDistance = 7;

      for (var i = 0; i < storesList.value.length; i++) {
        var distance = UtilsCommon.getAddress(storesList.value[i].latitude,
                storesList.value[i].longitude, latitude.value, longitude.value)
            .round();

        if (distance <= 7) {
          newList.add(storesList.value[i]);
          //print(distance.toString() + "minthu");
        }
      }
      storeListNearYou.value = newList;
      isLoading.value = false;
      //print(storeListNearYou.value.length.toString() + " stores");
    } catch (error) {
      print(error);
    } finally {
      isLoading.value = false;
    }
  }
}
