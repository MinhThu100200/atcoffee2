import 'package:get/state_manager.dart';
import 'package:at_coffee/models/store.dart';
import 'package:at_coffee/services/service_store.dart';

class StoreController extends GetxController {
  var isLoading = true.obs;
  var storesList = List<Store>().obs;

  @override
  void onInit() {
    fetchStores();
    super.onInit();
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
