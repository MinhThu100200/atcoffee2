import 'package:get/state_manager.dart';
import 'package:at_coffee/models/promotion.dart';
import 'package:at_coffee/services/service_promotion.dart';

class PromotionController extends GetxController {
  var isLoading = true.obs;
  var promotionsList = List<Promotion>().obs;

  @override
  void onInit() {
    fetchPromotions();
    super.onInit();
  }

  void fetchPromotions() async {
    try {
      isLoading(true);
      var promotions = await RemoteServices.fetchPromotions();
      if (promotions != null) {
        promotionsList.value = promotions;
      }
    } finally {
      isLoading(false);
    }
  }
}
