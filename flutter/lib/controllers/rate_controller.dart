import 'package:get/state_manager.dart';
import 'package:at_coffee/models/rate.dart';
import 'package:at_coffee/services/service_rate.dart';

class RateController extends GetxController {
  var isLoading = true.obs;
  var ratesList = <Rate>[].obs;
  var rateByUser = <Rate>[].obs;

  @override
  void onInit() {
    super.onInit();
  }

  void fetchRates(id) async {
    try {
      isLoading.value = true;
      var rates = await RemoteServices.fetchRates(id);
      if (rates != null) {
        ratesList.value = rates;
      }
    } finally {
      isLoading.value = false;
    }
  }

  void fetchRateByUser() async {
    try {
      isLoading.value = true;
      var rates = await RemoteServices.fetchRateByUser();
      if (rates != null) {
        rateByUser.value = rates;
      }
    } finally {
      isLoading.value = false;
    }
  }
}
