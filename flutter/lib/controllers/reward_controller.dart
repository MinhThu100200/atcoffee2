import 'package:get/state_manager.dart';
import 'package:at_coffee/models/reward.dart';
import 'package:at_coffee/services/service_reward.dart';

class RewardController extends GetxController {
  var isLoading = true.obs;
  var rewardsList = <Reward>[].obs;

  @override
  void onInit() {
    fetchRewards();
    super.onInit();
  }

  void fetchRewards() async {
    try {
      isLoading(true);
      var rewards = await RemoteServices.fetchRewards();
      if (rewards != null) {
        rewardsList.value = rewards;
      }
    } finally {
      isLoading(false);
    }
  }
}
