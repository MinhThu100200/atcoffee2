import 'package:get/state_manager.dart';
import 'package:at_coffee/models/rate.dart';
import 'package:at_coffee/services/service_rate.dart';

class RateController extends GetxController {
  var isLoading = true.obs;
  var ratesList = List<Rate>().obs;

  @override
  void onInit() {
    super.onInit();
  }

  void fetchRates(id) async {
    try {
      isLoading(true);
      var rates = await RemoteServices.fetchRates(id);
      if (rates != null) {
        ratesList.value = rates;
      }
    } finally {
      isLoading(false);
    }
  }
}
