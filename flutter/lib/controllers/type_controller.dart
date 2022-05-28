import 'package:get/state_manager.dart';
import 'package:at_coffee/models/type.dart';
import 'package:at_coffee/services/service_type.dart';

class TypeController extends GetxController {
  var isLoading = true.obs;
  var typesList = <Type>[].obs;

  @override
  void onInit() {
    fetchTypes();
    super.onInit();
  }

  void fetchTypes() async {
    try {
      isLoading(true);
      var types = await RemoteServices.fetchTypes();
      if (types != null) {
        typesList.value = types;
      }
    } finally {
      isLoading(false);
    }
  }
}
