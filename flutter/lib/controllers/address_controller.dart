import 'package:at_coffee/models/district.dart';
import 'package:at_coffee/models/ward.dart';
import 'package:get/state_manager.dart';
import 'package:at_coffee/models/city.dart';
import 'package:at_coffee/services/service_address.dart';

class AddressController extends GetxController {
  var isLoading = true.obs;
  var addressList = List<City>().obs;
  var cityList = List<City>().obs;
  var districtList = List<District>().obs;
  var wardList = List<Ward>().obs;
  var nameCityList = <String>[].obs;
  var nameDistrictList = <String>[].obs;
  var nameWardList = <String>[].obs;

  @override
  void onInit() {
    // Nếu quán ở nhiều thành phố bỏ cmt ở hàm fetchAddress
    // fetchAddress();
    // fetchDistrictByCity();
    super.onInit();
  }

  void fetchDistrictByCity() async {
    try {
      isLoading(true);
      var address = await RemoteServices.fetchAddress();
      if (address != null) {
        addressList.value = address;
        for (var i = 0; i < address.length; i++) {
          if (address[i].code == 79) {
            print("Thành phố Hồ Chí Minh");
            districtList.value = address[i].districts;
            //setNameList(address[i].districts, nameDistrictList.value);

            break;
          }
        }
      }
    } catch (error) {
      print("error in fetchAddress");
    } finally {
      isLoading(false);
    }
  }

//79 = tp HCM
  void fetchWardByDistrict(myDistrict) async {
    try {
      isLoading(true);
      var address = await RemoteServices.fetchAddress();
      if (address != null) {
        addressList.value = address;
        for (var i = 0; i < address.length; i++) {
          if (address[i].code == 79) {
            for (var j = 0; j < address[i].districts.length; j++) {
              if (address[i].districts[j].code == myDistrict.code) {
                print("error in fetchAddress" +
                    address[i].districts[j].wards.length.toString());
                wardList.value = address[i].districts[j].wards;
              }
            }
          }
        }
      }
    } catch (error) {
      print("error in fetchAddress");
    } finally {
      isLoading(false);
    }
  }

  void setNameList(myList, saveList) {
    var nameList = <String>[];
    for (var i = 0; i < myList.length; i++) {
      nameList.add(myList[i].name);
    }
    saveList = nameList;
    print("my district my district" + saveList.length.toString());
  }

  void fetchAddress() async {
    try {
      isLoading(true);
      // var cities = await RemoteServices.fetchCity();
      // var districts = await RemoteServices.fetchDistrict();
      var wards = await RemoteServices.fetchWard();
      // if (cities != null) {
      //   cityList.value = cities;
      //   setNameList(cities, nameCityList.value);
      // }
      // if (districts != null) {
      //   districtList.value = districts;
      //   setNameList(districts, nameDistrictList.value);
      // }
      if (wards != null) {
        wardList.value = wards;
        setNameList(wards, nameWardList.value);
      }
    } finally {
      isLoading(false);
    }
  }
}
